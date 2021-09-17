USE DB_LAYLOIHOI;
GO

CREATE TABLE PHONG
(
    MaPhong CHAR(10) PRIMARY KEY,
    LoaiPhong CHAR(20),
    SoKhachToiDa INT,
    GiaPhong MONEY,
    MoTa VARCHAR(MAX)
        DEFAULT NULL
);
GO
--DROP TABLE dbo.PHONG
--SELECT * FROM dbo.PHONG

CREATE TABLE KHACH_HANG
(
    MaKH CHAR(10) PRIMARY KEY,
    TenKH VARCHAR(200),
    DiaChi VARCHAR(MAX),
    SoDT CHAR(15)
);
GO
--DROP TABLE dbo.KHACH_HANG
--SELECT * FROM dbo.KHACH_HANG

CREATE TABLE DICH_VU_DI_KEM
(
    MaDV CHAR(10) PRIMARY KEY,
    TenDV VARCHAR(200),
    DonViTinh VARCHAR(100),
    DonGia MONEY
);
GO
--DROP TABLE dbo.DICH_VU_DI_KEM
--SELECT * FROM dbo.DICH_VU_DI_KEM

CREATE TABLE DAT_PHONG
(
    MaDatPhong CHAR(10) PRIMARY KEY,
    MaPhong CHAR(10),
    MaKH CHAR(10),
    NgayDat DATE,
    GioBatDau TIME,
    GioKetThuc TIME,
    TienDatCoc MONEY,
    GhiChu VARCHAR(MAX),
    TrangThaiDat VARCHAR(100)
);
GO
--DROP TABLE dbo.DAT_PHONG
--SELECT * FROM dbo.DAT_PHONG

CREATE TABLE CHI_TIET_SU_DUNG_DICH_VU
(
    MaDatPhong CHAR(10),
    MaDV CHAR(10),
    SoLuong INT
        PRIMARY KEY (
                        MaDatPhong,
                        MaDV
                    )
);
GO
--DROP TABLE dbo.CHI_TIET_SU_DUNG_DICH_VU
--SELECT * FROM dbo.CHI_TIET_SU_DUNG_DICH_VU

ALTER TABLE dbo.DAT_PHONG
ADD CONSTRAINT FK_PHONG_DAT_PHONG
    FOREIGN KEY (MaPhong)
    REFERENCES dbo.PHONG (MaPhong);
GO

ALTER TABLE dbo.DAT_PHONG
ADD CONSTRAINT FK_KHACH_HANG_DAT_PHONG
    FOREIGN KEY (MaKH)
    REFERENCES dbo.KHACH_HANG (MaKH);
GO

ALTER TABLE dbo.CHI_TIET_SU_DUNG_DICH_VU
ADD CONSTRAINT FK_DAT_PHONG_CHI_TIET
    FOREIGN KEY (MaDatPhong)
    REFERENCES dbo.DAT_PHONG (MaDatPhong);
GO

ALTER TABLE dbo.CHI_TIET_SU_DUNG_DICH_VU
ADD CONSTRAINT FK_DICH_VU_CHI_TIET
    FOREIGN KEY (MaDV)
    REFERENCES dbo.DICH_VU_DI_KEM (MaDV);
GO

INSERT INTO dbo.PHONG
(
    MaPhong,
    LoaiPhong,
    SoKhachToiDa,
    GiaPhong,
    MoTa
)
VALUES
('P001', 'Loai 1', 20, 60000, ''),
('P002', 'Loai 1', 25, 80000, ''),
('P003', 'Loai 2', 15, 50000, ''),
('P004', 'Loai 3', 20, 50000, '');
GO

INSERT INTO dbo.KHACH_HANG
(
    MaKH,
    TenKH,
    DiaChi,
    SoDT
)
VALUES
('KH001', 'Nguyen Van A', 'Hoa Xuan', '11111'),
('KH002', 'Nguyen Van B', 'Hoa Hai', '11112'),
('KH003', 'Phan Van A', 'Cam Le', '11113'),
('KH004', 'Phan Van B', 'Hoa Xuan', '11114');
GO

INSERT INTO dbo.DICH_VU_DI_KEM
(
    MaDV,
    TenDV,
    DonViTinh,
    DonGia
)
VALUES
('DV001', 'Beer', 'Lon', 10000),
('DV002', 'Nuoc Ngot', 'Lon', 8000),
('DV003', 'Trai Cay', 'Dia', 35000),
('DV004', 'Khan Uot', 'Cai', 2000);
GO

INSERT INTO dbo.DAT_PHONG
(
    MaDatPhong,
    MaPhong,
    MaKH,
    NgayDat,
    GioBatDau,
    GioKetThuc,
    TienDatCoc,
    GhiChu,
    TrangThaiDat
)
VALUES
('DP001', 'P001', 'KH002', '2018-03-26', '11:00:00', '13:30:00', 100000, '', 'Da Dat'),
('DP002', 'P001', 'KH003', '2018-03-27', '17:15:00', '19:15:00', 50000, '', 'Da Huy'),
('DP003', 'P002', 'KH002', '2018-03-26', '20:30:00', '22:15:00', 100000, '', 'Da Dat'),
('DP004', 'P003', 'KH001', '2018-04-01', '19:30:00', '21:15:00', 200000, '', 'Da Dat');
GO

INSERT INTO dbo.CHI_TIET_SU_DUNG_DICH_VU
(
    MaDatPhong,
    MaDV,
    SoLuong
)
VALUES
('DP001', 'DV001', 20),
('DP001', 'DV003', 3),
('DP001', 'DV002', 10),
('DP002', 'DV002', 10),
('DP002', 'DV003', 1),
('DP003', 'DV003', 1),
('DP003', 'DV004', 10);
GO


--Câu 1:Liệt kê MaDatPhong, MaDV, SoLuong của tất cả các dịch vụ có số lượng lớn hơn 3 và nhỏ hơn 10. (1 điểm)
SELECT ct.MaDatPhong,
       ct.MaDV,
       ct.SoLuong
FROM dbo.CHI_TIET_SU_DUNG_DICH_VU ct
WHERE ct.SoLuong > 3						--	|
      AND ct.SoLuong < 10;					--	| => đoạn này có thể dùng với betwen 
GO

--Câu 2: Cập nhật dữ liệu trên trường GiaPhong thuộc bảng PHONG tăng lên 10,000 VNĐ 
--so với giá phòng hiện tại, chỉ cập nhật giá phòng 
--của những phòng có số khách tối đa lớn hơn 10. (1 điểm)
UPDATE dbo.PHONG
SET GiaPhong = GiaPhong + 10000
WHERE SoKhachToiDa > 10;
GO

--Câu 3: Xóa tất cả những đơn đặt phòng (từ bảng DAT_PHONG) 
--có trạng thái đặt (TrangThaiDat) là “Da huy”. (1 điểm)
DECLARE @MaDP CHAR(10) =
        (
            SELECT TOP 1 MaDatPhong FROM dbo.DAT_PHONG WHERE TrangThaiDat = 'Da Huy'
        );
DELETE FROM dbo.CHI_TIET_SU_DUNG_DICH_VU
WHERE MaDatPhong = @MaDP;
UPDATE dbo.DAT_PHONG
SET MaPhong = NULL,
    MaKH = NULL
WHERE TrangThaiDat = 'Da Huy';
DELETE FROM dbo.DAT_PHONG
WHERE TrangThaiDat = 'Da Huy'
      AND MaDatPhong = @MaDP;
GO

--Câu 4: Hiển thị TenKH của những khách hàng có tên bắt đầu là một trong các ký tự “H”, “N”, “M” và có độ dài tối đa là 20 ký tự. (1 điểm)
SELECT TenKH
FROM dbo.KHACH_HANG
WHERE SUBSTRING(TenKH, 1, 1) = 'H'					--|	
      OR SUBSTRING(TenKH, 1, 1) = 'N'				--| => có thể thay bằng like với lọc kí tự đầu [x]%
      OR SUBSTRING(TenKH, 1, 1) = 'M'				--|
         AND LEN(TenKH) <= 20;
GO

--Câu 5: Hiển thị TenKH của tất cả các khách hàng có trong hệ thống, 
--TenKH nào trùng nhau thì chỉ hiển thị một lần. Sinh viên sử dụng hai cách khác nhau 
--để thực hiện yêu cầu trên, mỗi cách sẽ được 0,5 điểm. (1 điểm)
SELECT DISTINCT
       TenKH
FROM dbo.KHACH_HANG;
GO

SELECT TENKH										--|
FROM khach_hang										--| => group by cũng lọc được các giá trị trùng nhau
GROUP BY TENKH										--|
GO 

--Câu 6: Hiển thị MaDV, TenDV, DonViTinh, DonGia của những dịch vụ đi kèm 
--có DonViTinh là “lon” và có DonGia lớn hơn 10,000 VNĐ hoặc những dịch vụ 
--đi kèm có DonViTinh là “Cai” và có DonGia nhỏ hơn 5,000 VNĐ. (1 điểm) 
SELECT MaDV,
       TenDV,
       DonViTinh,
       DonGia
FROM dbo.DICH_VU_DI_KEM
WHERE (
          DonViTinh = 'Lon'
          AND DonGia > 10000
      )
      OR
      (
          DonViTinh = 'Cai'
          AND DonGia < 5000
      );
GO


--Câu 7: Hiển thị MaDatPhong, MaPhong, LoaiPhong, SoKhachToiDa, GiaPhong, MaKH, TenKH, SoDT, NgayDat, GioBatDau, GioKetThuc, MaDichVu, SoLuong, 
--DonGia của những đơn đặt phòng có năm đặt phòng là “2016”, “2017” và đặt những phòng có giá phòng > 50,000 VNĐ/ 1 giờ. (1 điểm)
SELECT dp.MaDatPhong,
       dp.MaPhong,
       p.LoaiPhong,
       p.SoKhachToiDa,
       p.GiaPhong,
       dp.MaKH,
       kh.TenKH,
       kh.SoDT,
       dp.NgayDat,
       dp.GioBatDau,
       dp.GioKetThuc,
       ct.MaDV,
       ct.SoLuong,
       dv.DonGia
FROM dbo.DAT_PHONG dp,
     dbo.PHONG p,
     dbo.KHACH_HANG kh,
     dbo.CHI_TIET_SU_DUNG_DICH_VU ct,
     dbo.DICH_VU_DI_KEM dv
WHERE (
          YEAR(dp.NgayDat) = '2016'
          OR YEAR(dp.NgayDat) = '2017'
      )
      AND p.GiaPhong > 50000;
GO

--Câu 8: Hiển thị MaDatPhong, MaPhong, LoaiPhong, GiaPhong, TenKH, NgayDat, TongTienHat, TongTienSuDungDichVu, 
--TongTienThanhToan tương ứng với từng mã đặt phòng có trong 
--bảng DAT_PHONG. Những đơn đặt phòng nào không sử dụng dịch vụ đi kèm thì cũng liệt kê thông tin của đơn đặt phòng đó ra. (1 điểm)
SELECT DISTINCT
       dp.MaDatPhong,
       dp.MaPhong,
       p.LoaiPhong,
       p.GiaPhong,
       kh.TenKH,
       dp.NgayDat,
       (p.GiaPhong * (DATEDIFF(MINUTE, dp.GioBatDau, dp.GioKetThuc) / 60)) TongTienHat,
       ct.SoLuong * dv.DonGia AS TongTienSuDungDichVu,
       (p.GiaPhong * (DATEDIFF(MINUTE, dp.GioBatDau, dp.GioKetThuc) / 60)) +
       (
           SELECT SUM(ct.SoLuong * dv.DonGia)
           FROM dbo.CHI_TIET_SU_DUNG_DICH_VU ct
               INNER JOIN dbo.DICH_VU_DI_KEM dv
                   ON dv.MaDV = ct.MaDV
       ) AS TongTienThanhToan
FROM dbo.DAT_PHONG dp
    INNER JOIN dbo.PHONG p
        ON p.MaPhong = dp.MaPhong
    INNER JOIN dbo.KHACH_HANG kh
        ON kh.MaKH = dp.MaKH
    INNER JOIN dbo.CHI_TIET_SU_DUNG_DICH_VU ct
        ON ct.MaDatPhong = dp.MaDatPhong
    INNER JOIN dbo.DICH_VU_DI_KEM dv
        ON dv.MaDV = ct.MaDV
GROUP BY dp.MaDatPhong,
         dp.MaPhong,
         p.LoaiPhong,
         p.GiaPhong,
         kh.TenKH,
         dp.NgayDat,
         dp.GioBatDau,
         dp.GioKetThuc,
         ct.SoLuong,
         dv.DonGia;
GO

--trong thực tế  k tính thời gian bằng GIOKETHUC - GIOBATDAU đâu đây là người ta cho sẵn biểu thức thế thôi, 
--mà chúng ta phải dùng hàm TIMEDIFF(time_end, time_start ) để tính chính xác thời gian và lấy ra Giờ phút giây của nó bằng hàm DATEPART(), 
--tiếp đó tính tổng số giây. Nó cho giá phòng trong 1 giờ thì chúng ta phải đổi ra 1 giây bao nhiêu tiền, Tổng tiền phòng bằng tổng giây * tiền phòng 1 giây ^^! 

--Câu 9: Hiển thị MaKH, TenKH, DiaChi, SoDT của những khách hàng đã từng đặt phòng karaoke có địa chỉ ở “Hoa xuan”. (1 điểm)
SELECT dp.MaKH,
       kh.TenKH,
       kh.DiaChi,
       kh.SoDT
FROM dbo.KHACH_HANG kh
    INNER JOIN dbo.DAT_PHONG dp
        ON dp.MaKH = kh.MaKH
WHERE kh.DiaChi = 'Hoa Xuan';
GO

SELECT kh.MaKH,
       kh.TenKH,
       kh.DiaChi,
       kh.SoDT
FROM KHACH_HANG kh
WHERE kh.DiaChi = 'Hoa Xuan'
      AND EXISTS
(
    SELECT dp.MaKH FROM DAT_PHONG dp WHERE kh.MaKH = dp.MaKH
);
GO 
-- => thực sự 2 câu truy vấn này cho ra cùng 1 kết quả, nhưng EXISTS sẽ lọc bớt các giá trị của table DAT_PHONG, 
-- cho nên truy vấn sẽ nhanh hơn với những truy vấn lớn

--Câu 10: Hiển thị MaPhong, LoaiPhong, 
--SoKhachToiDa, GiaPhong, SoLanDat của những phòng được khách 
--hàng đặt có số lần đặt lớn hơn 2 lần và trạng thái đặt là “Da dat”. (1 điểm)
SELECT dp.MaPhong,
       p.LoaiPhong,
       p.SoKhachToiDa,
       p.GiaPhong,
       (
           SELECT COUNT(MaKH) FROM dbo.DAT_PHONG WHERE MaKH = dp.MaKH
       ) SoLanDat
FROM dbo.KHACH_HANG kh
    INNER JOIN dbo.DAT_PHONG dp
        ON dp.MaKH = kh.MaKH
    INNER JOIN dbo.PHONG p
        ON p.MaPhong = dp.MaPhong
WHERE dp.TrangThaiDat = 'Da Dat'
      AND
      (
          SELECT COUNT(MaKH) FROM dbo.DAT_PHONG WHERE MaKH = dp.MaKH
      ) >= 2;
GO