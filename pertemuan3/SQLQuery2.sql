-- Menampilkan semua data pada tabel produk
SELECT * 
FROM Production.Product;

-- Menampilkan Name, ProductNumber, dan ListPrice
SELECT Name, ProductNumber, ListPrice
FROM Production.Product;

-- Menampilkan data menggunakan alias kolom
SELECT Name AS [Nama Barang], ListPrice AS 'Harga Jual'
FROM Production.Product;

-- Menampilkan HargaBaru = ListPrice * 1.1
SELECT Name, ListPrice, (ListPrice * 1.1) AS HargaBaru 
FROM Production.Product;

-- Menampilkan data dengan menggabungkan string
SELECT Name + '(' + ProductNumber + ')' AS ProductLengkap 
FROM Production.Product;

-- Filterisasi Data
-- Menampilkan Produk yg Berwarna Merah
SELECT Name, Color, ListPrice 
FROM Production.Product 
WHERE Color = 'red';

-- Menampilkan produk yg ListPrice nya leih dari 1000
SELECT Name, ListPrice
FROM Production.Product
WHERE ListPrice > 1000;

-- Menampilkan Produk yg berwarna black dan ListPrice nya lebih dari 500
SELECT Name, Color, ListPrice 
FROM Production.Product
WHERE Color = 'black' AND ListPrice > 500;

-- Menampilkan Produk yg berwarna red, blue, atau black
SELECT Name, Color  
FROM Production.Product
WHERE Color IN ('red', 'blue', 'black');

-- Menampilkan produk yg namanya mengandung kata 'Road'
SELECT Name, ProductNumber
FROM Production.Product
WHERE Name Like '%Road%';

-- Agregasi dan Pengelompokan
-- Menghitung total baris
SELECT COUNT(*) AS TotalProduk
FROM Production.Product

-- Menampilkan warna produk dan jumlahnya
SELECT Color, COUNT(*) AS JumlahProduk
FROM Production.Product
GROUP BY Color;

-- Menampilkan ProductID, jumlah OrderQty, dan rata2 UnitPrice
SELECT ProductID, SUM(OrderQty) AS TotalTerjual, AVG(UnitPrice) AS RataRataHarga
FROM Sales.SalesOrderDetail
GROUP BY ProductID;

SELECT *
FROM Sales.SalesOrderDetail;

-- Menampilkan data dengan grouping lebih dari satu kolom
SELECT Color, Size, COUNT(*) AS Jumlah
FROM Production.Product
GROUP BY Color, Size;

SELECT * 
FROM Production.Product;

-- Filter Hasil Agregasi
-- Menampilkan warna produk yg jumlahnya lebih dari 20
SELECT Color, COUNT(*) AS Jumlah
FROM Production.Product
GROUP BY Color
HAVING COUNT(*) > 2;

-- Menampilkan warna produk yg ListPrice nya > 500 dan jumlah nya < 10
SELECT Color, COUNT(*) AS Jumlah
FROM Production.Product
WHERE ListPrice > 500
GROUP BY Color
HAVING COUNT(*) < 10;

-- Menampilkan ProductID yg jumlah OrderQty nya lebih dari 100
SELECT ProductID , SUM(OrderQty) AS RataRataBEli
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(OrderQty) > 10;

-- Menampilkan SpecialOfferID yyg rata2 OrderQty nya > 2
SELECT SpecialOfferID, AVG(OrderQty) AS RataRataBeli
FROM Sales.SalesOrderDetail
GROUP BY SpecialOfferID
HAVING SUM(OrderQty) > 2;

-- Menampilkan warna yg ListPrice nya > 3000 menggunakan MAX
SELECT Color
FROM Production.Product
GROUP BY Color
HAVING MAX(ListPrice) > 300;

-- Advanced SELECT dan ORDER BY
-- Menampilkan JobTitle tanpa duplikat
SELECT  DISTINCT JobTitle
FROM HumanResources.Employee;

-- Menampilkan 5 nama produk termahal
SELECT TOP 5 Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;

SELECT TOP 5 Name, ListPrice
FROM Production.Product
ORDER BY ListPrice ASC;

-- OFFSET FETCH
SELECT Name, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC
OFFSET 2 ROWS
FETCH NEXT 4 ROWS ONLY;

SELECT TOP 3 Color, SUM(ListPrice) AS TotalNilaiStok
FROM Production.Product
WHERE ListPrice > 0
GROUP BY Color
ORDER BY TotalNilaiStok DESC;

-- Tugas Mandiri
-- Gunakan tabel Sales.SalesOrderDetail (Tabel detail transaksi).
-- 1. Tampilkan ProductID dan total uang yang didapat (LineTotal) dari produk tersebut.
-- 2. Hanya hitung transaksi yang OrderQty (jumlah beli) >= 2.
-- 3. Kelompokkan berdasarkan ProductID.
-- 4. Filter agar hanya menampilkan produk yang total uangnya (SUM(LineTotal)) di atas $50,000.
-- 5. Urutkan dari pendapatan tertinggi.
-- 6. Ambil 10 produk teratas saja.


-- 1.
SELECT ProductID,SUM(LineTotal) AS TotalUang -- Menampilkan ProductID, LineTotal AS TotalUang, dan setiap kelompok produk, lalu SQL melakukan SUM(LineTotal).
FROM Sales.SalesOrderDetail -- Mengambil data dari kolom SalesOrderDetail.
GROUP BY ProductID; -- Mengelompok kan baris berdasarkan ProductID.

-- 2.
SELECT ProductID, SUM(LineTotal) AS TotalUang -- Menampilkan ProductID dan total uangnya, lalu menghitung total uang per produk dari baris yang sudah lolos filter.
FROM Sales.SalesOrderDetail -- Mengambil data dari SalesOrderDetail.
WHERE OrderQty >= 2 -- Menampilkan hanya transaksi dengan OrderQty minimal 2 yang diproses.
GROUP BY ProductID; -- Mengelompokkan berdasarkan ProductID.

-- 3.
SELECT ProductID, SUM(LineTotal) AS TotalUang -- Menampilkan total uang dari tiap produk.
FROM Sales.SalesOrderDetail -- Mengambil data dari SalesOrderDetail.
WHERE OrderQty >= 2 -- Filter: hanya transaksi dengan jumlah beli minimal 2.
GROUP BY ProductID; -- Mengelompokkan berdasarkan ProductID (tahap inti dari nomor 3).


-- 4.
SELECT ProductID, SUM(LineTotal) AS TotalUang -- Menampilkan ProductID & total pendapatan.
FROM Sales.SalesOrderDetail -- Mengambil data dari tabel SalesOrderDetail.
WHERE OrderQty >= 2 -- Filter awal: hanya transaksi OrderQty >= 2.
GROUP BY ProductID -- SQL mengelompokkan baris berdasarkan ProductID.
HAVING SUM(LineTotal) > 50000; -- Filter hasil agregasi: hanya produk dengan total > 50.000.


-- 5.
SELECT ProductID, SUM(LineTotal) AS TotalUang -- Menampilkan ProductID & total pendapatan.
FROM Sales.SalesOrderDetail -- Sumber data SalesOrderDetail.
WHERE OrderQty >= 2 -- Filter baris sebelum pengelompokan.
GROUP BY ProductID -- Kelompokkan per produk.
HAVING SUM(LineTotal) > 50000 -- Filter hasil agregasi.
ORDER BY TotalUang DESC; -- Mengurutkan dari pendapatan terbesar ke terkecil.


-- 6.
SELECT TOP 10 ProductID, SUM(LineTotal) AS TotalUang -- Menampilkan 10 produk dengan pendapatan tertinggi.
FROM Sales.SalesOrderDetail -- Mengambil semua data transaksi.
WHERE OrderQty >= 2 -- Filter transaksi dengan OrderQty minimal 2.
GROUP BY ProductID -- Mengelompokkan baris berdasarkan ProductID.
HAVING SUM(LineTotal) > 50000 -- Hanya produk dengan total uang > 50.000.
ORDER BY TotalUang DESC; -- Urutkan dari total pendapatan tertinggi.