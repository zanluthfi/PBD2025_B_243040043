-- buat database TokoRetailDB
CREATE DATABASE TokoRetailDB;

-- gunakan DB TokoRetailDB
USE TokoRetailDB;

-- membuat tabel KategoriProduk
CREATE TABLE KategoriProduk (
	KategoriID INT IDENTITY(1,1) PRIMARY KEY,
	NamaKategori VARCHAR(100) NOT NULL UNIQUE,
)

-- membuat tabel produk
CREATE TABLE Produk (
	ProdukID INT IDENTITY(1000,1) PRIMARY KEY,
	SKU VARCHAR(20) NOT NULL UNIQUE,
	NamaProduk VARCHAR(150) NOT NULL,
	Harga DECIMAL(10,2) NOT NULL,
	Stok INT NOT NULL,
	KategoriID INT NULL,

	-- harganya gaboleh negatif
	CONSTRAINT CHK_HargaPositif CHECK (Harga >= 0),

	-- stok juga sama
	CONSTRAINT CHK_StokPositif CHECK (Stok >= 0),

	--relasikan dengan tabel KategoriProduk melalui KategoriID
	CONSTRAINT FK_Produk_Kategori
		FOREIGN KEY (KategoriID)
		REFERENCES KategoriProduk(KategoriID)
);

-- masukkan data ke tabel KategoriProduk
INSERT INTO KategoriProduk (NamaKategori)
VALUES
('Elektronik');

INSERT INTO KategoriProduk (NamaKategori)
VALUES
('Pakaian'),
('Buku')

-- menampilkan tabel kategori
SELECT *
FROM KategoriProduk;

-- menampilkan nama kategori
SELECT NamaKategori
FROM KategoriProduk;

-- menambahkan data ke tabel produk
INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
VALUES
('ELEC-001', 'Laptop Gaming', 15000000.00, 50, 2);

INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
VALUES
('ELEC-002', 'HP Gaming', 50000000.00, 50, 1);

-- tampil produk
SELECT *
FROM Produk;

-- mengubah data stok
UPDATE Produk
SET Stok = 30
WHERE ProdukID = 1000;

-- menghapus data
BEGIN TRANSACTION;

DELETE FROM Produk
WHERE ProdukID = 1003;

COMMIT TRANSACTION

-- rollback
INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
VALUES
('PAKA-002', 'Celana Gaming', 70000000.00, 50, 2);

-- hapus baju gaming
BEGIN TRAN;
DELETE FROM Produk
WHERE ProdukID = 1004;

-- baju gaming kombek
ROLLBACK TRAN;

COMMIT TRAN;