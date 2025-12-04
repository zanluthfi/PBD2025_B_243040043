use KampusDB;

-- Cross join
-- menampilkan semua kombinasi mahasiswa dan matakuliah
SELECT NamaMahasiswa FROM Mahasiswa
SELECT NamaMK FROM MataKuliah

SELECT M.NamaMahasiswa, MK.NamaMK
FROM Mahasiswa AS M
CROSS JOIN MataKuliah AS MK;

-- Menampilkan semua kombinasi dosen dan ruangan
SELECT D.NamaDosen, R.KodeRuangan
FROM Dosen D
CROSS JOIN Ruangan R;

-- Left join
-- Menampilkan semua mahasiswa termasuk yang belum mengambil KRS
SELECT M.NamaMahasiswa, K.MataKuliahID
FROM Mahasiswa M
LEFT JOIN KRS K ON M.MahasiswaID = K.MahasiswaID;

-- Menampilkan semua matakuliah, termasuk yang belum punya jadwal
SELECT MK.NamaMK, J.Hari
FROM MataKuliah MK
LEFT JOIN JadwalKuliah J ON MK.MataKuliahID = J.MataKuliahID;

-- RIGHT JOIN 
-- Menampilkan semua jadwal, walaupun tidak ada matakuliah
SELECT MK.NamaMK, J.Hari
FROM MataKuliah MK
RIGHT JOIN JadwalKuliah J ON MK.MataKuliahID = J.MataKuliahID;

-- Menampilkan semua ruangan dan dipakai di jadwal atau tidak
SELECT R.KodeRuangan, J.Hari
FROM JadwalKuliah J
RIGHT JOIN Ruangan R ON J.RuanganID = R.RuanganID;

-- INNER JOIN
-- menampilkan nama mahasiswa dengan matakuliah melalui tabel KRS
SELECT * FROM Mahasiswa
SELECT * FROM KRS
SELECT * FROM MataKuliah

SELECT M.NamaMahasiswa, MK.NamaMK
FROM KRS K
INNER JOIN Mahasiswa M ON K.MahasiswaID = M.MahasiswaID
INNER JOIN MataKuliah MK ON K.MataKuliahID = MK.MataKuliahID;

-- Menampilkan mk dan dosennya
SELECT MK.NamaMK, D.NamaDosen
FROM MataKuliah MK
JOIN Dosen D ON MK.DosenID = D.DosenID;

-- Menampilkan semua jadwal
SELECT MK.NamaMK, D.NamaDosen, R.KodeRuangan, J.Hari
FROM JadwalKuliah J
JOIN MataKuliah MK ON J.MataKuliahID = MK.MataKuliahID
JOIN Dosen D ON J.DosenID = D.DosenID
JOIN Ruangan R ON J.RuanganID = R.RuanganID;

-- menampilkan nama mahasiswa dengan nilai akhir
SELECT M.NamaMahasiswa, MK.NamaMK, N.NilaiAkhir
FROM Nilai N
JOIN Mahasiswa M ON N.MahasiswaID = M.MahasiswaID
JOIN MataKuliah MK ON N.MataKuliahID = MK.MataKuliahID;

-- menampilkan dosen dan matakuliah yang dia ajar
SELECT D.NamaDosen, MK.NamaMK
FROM Dosen D
JOIN MataKuliah MK ON D.DosenID = MK.MataKuliahID;

-- Menampilkan nama mahasiswa dan nilai akhirnya
SELECT M.NamaMahasiswa, N.NilaiAkhir
FROM Mahasiswa M
JOIN Nilai N ON M.MahasiswaID = N.MahasiswaID;

-- SELF JOIN
-- menampilkan pasangan mahasiswa prodi sama
SELECT A.NamaMahasiswa AS M1, B.NamaMahasiswa AS M2, A.Prodi
FROM Mahasiswa A
JOIN Mahasiswa B ON A.Prodi = B.Prodi
WHERE A.MahasiswaID < B.MahasiswaID; -- tidak ada duplikat

--LATIHAN
--1.Tampilkan nama mahasiswa (NamaMahasiswa) beserta prodi-nya (Prodi) dari tabel Mahasiswa,tetapi hanya mahasiswa yang memiliki nilai di tabel Nilai.

--2.Tampilkan nama dosen(NamaDosen) dan ruangan(KodeRuangan) tempat dosen tersebut mengajar

--3. Tampilkan daftar mahasiswa (NamaMahasiswa) yang mengambil suatu mata kuliah(NamaMK) beserta nama mata kuliah dan dosen pengampu-nya(NamaDosen)

--4. Tampilkan jadwal kuliah berisi nama mata kuliah(NamaMK), nama dosen(NamaDosen), dan hari kuliah(Hari) tetapi tidak perlu menampilkan ruangan.

--5. Tampilkan nilai mahasiswa(NilaiAkhir) lengkap dengan nama mahasiswa(NamaMahasiswa) nama mata kuliah (NamaMK) , nama dosen pengampu(NamaDosen) dan nilai akhirnya(NilaiAkhir)

--1
SELECT M.NamaMahasiswa, M.Prodi
FROM Mahasiswa M
JOIN Nilai N ON M.MahasiswaID = N.MahasiswaID;

--2
SELECT D.NamaDosen, R.KodeRuangan
FROM Dosen D
JOIN JadwalKuliah J ON D.DosenID = J.DosenID
JOIN Ruangan R ON J.RuanganID = R.RuanganID;

--3
SELECT M.NamaMahasiswa, MK.NamaMK, D.NamaDosen
FROM KRS K
JOIN Mahasiswa M ON K.MahasiswaID = M.MahasiswaID
JOIN MataKuliah MK ON K.MataKuliahID = MK.MataKuliahID
JOIN Dosen D ON MK.DosenID = D.DosenID;

--4
SELECT MK.NamaMK, D.NamaDosen, J.Hari
FROM JadwalKuliah J
JOIN MataKuliah MK ON J.MataKuliahID = MK.MataKuliahID
JOIN Dosen D ON J.DosenID = D.DosenID;

--5
SELECT M.NamaMahasiswa, MK.NamaMK, D.NamaDosen, N.NilaiAkhir
FROM Nilai N
JOIN Mahasiswa M ON N.MahasiswaID = M.MahasiswaID
JOIN MataKuliah MK ON N.MataKuliahID = MK.MataKuliahID
JOIN Dosen D ON MK.DosenID = D.DosenID;