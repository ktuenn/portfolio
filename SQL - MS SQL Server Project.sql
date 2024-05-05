/* 

Final project of my database course in semester 3 (12/2022) - Flight Management Project

*/
--- 6.Lệnh mô tả dữ liệu:DDL
--- 6.1.Tạo databse
  CREATE DATABASE QLCB 
-------------------------
  GO
-------------------------
------USE QLCB GO
--- 6.2.Tạo Table
 --Tạo bảng hành khách
 CREATE TABLE HANHKHACH
(
	MAHK varchar (20) not null,
	HOTENHK nvarchar (50),
	NGAYSINH date ,
	GIOITINH varchar (5),
	SDT varchar (11),
	DIACHI nvarchar (50),
	MACB varchar (20),
	constraint pk_hk primary key(MAHK)
)
--Tạo bảng máy bay
CREATE TABLE MAYBAY
(
	MAMB varchar (20) not null ,
	LOAIMB varchar (50) ,
	HANGMB varchar (50) ,
	constraint pk_mb primary key(MAMB)
)
--Tạo bảng chuyến bay
CREATE TABLE CHUYENBAY
(
	MACB varchar (20) not null ,
	SBCC varchar (50),		
	SBHC varchar (50) ,
	NGAYBAY date ,
	GCC  time ,
	GHC  time ,
	MALT varchar (20),
	MAMB  varchar (20)
	constraint pk_cb primary key(MACB)
)
--Tạo bảng Nhân Viên
CREATE TABLE NHANVIEN
(
	MANV varchar (20),
	HOTEN nvarchar (20) ,
	NGAYSINH date ,
	GIOITINH varchar (5),
	DIACHI nvarchar (50),
	SDT varchar (11),
	constraint pk_manv primary key(MANV)
)
--Tạo bảng Điều Khiển
CREATE TABLE DIEUKHIEN
(
	MAMB varchar (20),
	MANV varchar (20)
)

CREATE TABLE LOTRINH
(
	MALT varchar (20),
	TGBAY varchar (50),
	DDDI varchar (50),
	DDDEN varchar (50),
	constraint pk_malt primary key(MALT)
)
CREATE TABLE VE
(
	MAVE varchar (20),
	MACB varchar (20),
	SOGHE varchar (10),
	MAHK varchar (20),
	HANGVE varchar (50),
	constraint pk_mave primary key(MAVE)
)
CREATE TABLE HANHLY
(
	MAHL varchar (20),
	MAHK varchar (20),
	MACB varchar (20),
	KHOILUONG int ,
	constraint pk_mahl primary key(MAHL)
)
--Tạo các khóa ngoại
ALTER TABLE DIEUKHIEN ADD CONSTRAINT fk01_DK FOREIGN KEY(MAMB) REFERENCES MAYBAY(MAMB)
ALTER TABLE DIEUKHIEN ADD CONSTRAINT fk02_DK FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV)
ALTER TABLE CHUYENBAY ADD CONSTRAINT fk01_CB FOREIGN KEY(MALT) REFERENCES LOTRINH(MALT)
ALTER TABLE CHUYENBAY ADD CONSTRAINT fk02_CB FOREIGN KEY(MAMB) REFERENCES MAYBAY(MAMB)
ALTER TABLE HANHKHACH ADD CONSTRAINT fk_HK FOREIGN KEY(MACB) REFERENCES CHUYENBAY(MACB)
ALTER TABLE VE ADD CONSTRAINT fk01_VE FOREIGN KEY(MACB) REFERENCES CHUYENBAY(MACB)
ALTER TABLE VE ADD CONSTRAINT fk02_VE FOREIGN KEY(MAHK) REFERENCES HANHKHACH(MAHK)
ALTER TABLE HANHLY ADD CONSTRAINT fk01_HL FOREIGN KEY(MAHK) REFERENCES HANHKHACH(MAHK)
ALTER TABLE HANHLY ADD CONSTRAINT fk02_HL FOREIGN KEY(MACB) REFERENCES CHUYENBAY(MACB)
--- 7.Lệnh thao tác dữ liệu:DDL 

--- 7.1.Thêm dữ liệu vào các table

-- NHANVIEN

Insert into NHANVIEN values ('NV001',N'Ngô Phúc Hưng','2000/12/08','NAM',N'Hà Nội','0868525295')
Insert into NHANVIEN values ('NV002',N'Mai Đức Anh','1995/08/11','NAM',N'Đà Nẵng','0911517709')
Insert into NHANVIEN values ('NV003',N'Hà Thị Mỹ Linh','1990/06/12','NU',N'Quảng Bình','0823688789')
Insert into NHANVIEN values ('NV004',N'Tạ Anh Tấn','1991/11/11','NAM',N'Lào Cai','0916747249')
Insert into NHANVIEN values ('NV005',N'Bùi Thu Thủy','1993/10/16','NU',N'Thái Nguyên','0963245789')
Insert into NHANVIEN values ('NV006',N'Vũ Thanh Thanh','1992/05/17','NU',N'Lâm Đồng','0973821367')
Insert into NHANVIEN values ('NV007',N'Đoàn Văn Dũng','1995/07/10','NAM',N'Hậu Giang','0874187953')
Insert into NHANVIEN values ('NV008',N'Hoàng Thanh Vân','1993/07/04','NU',N'Bình Phước','0963035729')
Insert into NHANVIEN values ('NV009',N'Lê Văn Minh','1998/03/19','NAM',N'Ninh Thuận','0913741179')
Insert into NHANVIEN values ('NV010',N'Hứa Việt Hà','1997/05/13','NAM',N'Quảng Trị','0347391789')
Insert into NHANVIEN values ('NV011',N'Nguyễn Thị Trang','1997/02/03','NU',N'Gia Lai','0386305758')
Insert into NHANVIEN values ('NV012',N'Đỗ Thị Thắm','1995/12/23','NU',N'Bạc Liêu','0912847245')
Insert into NHANVIEN values ('NV013',N'Hồ Xuân Trường','1994/02/10','NAM',N'Bình Dương','0988672498')
Insert into NHANVIEN values ('NV014',N'Nguyễn Minh Anh','1999/04/23','NU',N'Thái Nguyên','0387456132')
Insert into NHANVIEN values ('NV015',N'Đỗ Duy Anh','1998/08/01','NAM',N'Hồ Chí Minh','0342137421')
Insert into NHANVIEN values ('NV016',N'Huỳnh Ngọc Cảnh','1994/02/13','NU',N'Quảng Ngãi','0988567233')
Insert into NHANVIEN values ('NV017',N'Hứa Hùng','1999/04/05','NAM',N'Thái Bình','0347123789')
Insert into NHANVIEN values ('NV018',N'Nguyễn Công Hiền','1997/03/04','NAM',N'Bình Thuận','0745753988')
Insert into NHANVIEN values ('NV019',N'Trần Thị Tâm','2000/04/23','NU',N'Nghệ An','0912879342')
Insert into NHANVIEN values ('NV020',N'Nguyễn Tùng Dương','2001/07/08','NU',N'Hồ Chí Minh','0326527987')

--DIEUKHIEN

Insert into DIEUKHIEN values ('VN144','NV001')
Insert into DIEUKHIEN values ('VN144','NV002')
Insert into DIEUKHIEN values ('VJ206','NV003')
Insert into DIEUKHIEN values ('BB331','NV004')
Insert into DIEUKHIEN values ('BB331','NV005')
Insert into DIEUKHIEN values ('VN412','NV006')  
Insert into DIEUKHIEN values ('JP521','NV007')
Insert into DIEUKHIEN values ('VN146','NV008')
Insert into DIEUKHIEN values ('VN146','NV009')
Insert into DIEUKHIEN values ('QH354','NV010')
Insert into DIEUKHIEN values ('VJ367','NV011')
Insert into DIEUKHIEN values ('VJ367','NV012')
Insert into DIEUKHIEN values ('VN489','NV013')
Insert into DIEUKHIEN values ('VN134','NV014')
Insert into DIEUKHIEN values ('VN134','NV015')
--MAYBAY
Insert into MAYBAY values ('VN144','Boeing 747','Vietnam Airlines')
Insert into MAYBAY values ('VJ206','A350','Vietjet Air')
Insert into MAYBAY values ('BB331','A321','Bamboo Airways')
Insert into MAYBAY values ('VN412','A350','Vietravel Airlines')
Insert into MAYBAY values ('JP521','A320','Pacific Airlines')
Insert into MAYBAY values ('VN146','Boeing 747','Vietnam Airlines')
Insert into MAYBAY values ('QH354','A350','Bamboo Airways')
Insert into MAYBAY values ('VJ367','A321','Vietjet Air')
Insert into MAYBAY values ('VN489','A320','Vietravel Airlines')
Insert into MAYBAY values ('VN134','Boeing 747','Vietnam Airlines')

--LOTRINH

SELECT * FROM LOTRINH
Insert into LOTRINH values ('HNTHCM','2h10m','HA NOI','HO CHI MINH')
Insert into LOTRINH values ('HCMTDN','1h20m','HO CHI MINH','DA NANG')
Insert into LOTRINH values ('DNTCTX','1h35m','DA NANG','CAN THO')
Insert into LOTRINH values ('CTTDLX','1h45m','CAN THO','DA LAT')
Insert into LOTRINH values ('DLTHNX','1h55m','DA LAT','HA NOI')
Insert into LOTRINH values ('HNTDNX','1h25m','HA NOI','DA NANG')
Insert into LOTRINH values ('DNTHCM','1h20m','DA NANG','HO CHI MINH')
Insert into LOTRINH values ('HCMTHX','1h25m','HO CHI MINH','HUE')

--CHUYENBAY

Insert into CHUYENBAY values ('HNHCM1X',N'Nội Bài',N'Tân Sơn Nhất','2022/11/18','05:25','07:35','HNTHCM','VN144')
Insert into CHUYENBAY values ('HCMDN2X',N'Tân Sơn Nhất',N'Đà Nẵng','2022/11/15','7:15','8:35','HCMTDN','VJ206')
Insert into CHUYENBAY values ('DNCT3XX',N'Đà Nẵng',N'Cần Thơ','2022/11/11','8:20','9:55','DNTCTX','BB331')
Insert into CHUYENBAY values ('CTDL4XX',N'Cần Thơ',N'Liên Khương','2022/11/14','10:45','12:30','CTTDLX','VN412')
Insert into CHUYENBAY values ('DLHN5XX',N'Liên Khương',N'Nội Bài','2022/11/13','14:15','16:10','DLTHNX','JP521')
Insert into CHUYENBAY values ('HNDN6XX',N'Nội Bài ',N'Đà Nẵng','2022/11/14','12:50','14:15','HNTDNX','VN134')
Insert into CHUYENBAY values ('DNHCM7X',N'Đà Nẵng ',N'Tân Sơn Nhất','2022/11/18','4:30','5:50','DNTHCM','VN489')
Insert into CHUYENBAY values ('HCMH8XX',N'Tân Sơn Nhất',N'Phú Bài','2022/11/15','17:00','18:25','HCMTHX','VJ367')
Insert into CHUYENBAY values ('HNHCM9X',N'Nội Bài',N'Tân Sơn Nhất','2022/11/12','15:45','17:55','HNTHCM','QH354')
Insert into CHUYENBAY values ('DNHCM10',N'Đà Nẵng',N'Tân Sơn Nhất','2022/11/16','4:40','6:00','HCMTDN','VN146')

--HANHKHACH

Insert into HANHKHACH values ('HK001',N'Nguyễn Thanh Hằng','1989/03/12','NU','0902830128',N'Hà Nội','HNHCM1X')
Insert into HANHKHACH values ('HK002',N'Thân Thị Hoa','1984/05/03','NU','0920162021',N'Cần Thơ','HCMDN2X')
Insert into HANHKHACH values ('HK003',N'Nguyễn Sơn','2000/04/02','NAM','0937280180',N'Đà Nẵng','DNCT3XX')
Insert into HANHKHACH values ('HK004',N'Trần Liên','1970/08/04','NAM','0927392831',N'Quảng Nam','CTDL4XX')
Insert into HANHKHACH values ('HK005',N'Huỳnh Minh Tâm','2010/02/14','NU','0193749384',N'Huế','DLHN5XX')
Insert into HANHKHACH values ('HK006',N'Lưu Mạnh Hà','2003/08/23','NAM','0839348984',N'Nghệ An','HNHCMIX')
Insert into HANHKHACH values ('HK007',N'Võ Văn Chương','2001/10/19','NAM','0834920484',N'Quảng Trị','HNHCM9X')
Insert into HANHKHACH values ('HK008',N'Lê Thị Quế','1999/06/21','NU','0163847389',N'Đăk Lăk','HNDN6XX')
Insert into HANHKHACH values ('HK009',N'Huỳnh Minh Thông','2007/11/13','NAM','0847394749',N'Quảng Nam','HNDN6XX')
Insert into HANHKHACH values ('HK010',N'Phạm Thúy Hồng','2002/12/29','NU','0847294700',N'Gia Lai','DNHCM7X')
Insert into HANHKHACH values ('HK011',N'Phan Tấn Trung','2004/03/13','NAM','0849394739',N'Đà Lạt','HCMH8XX')
Insert into HANHKHACH values ('HK012',N'Đinh Tiến Đạt','1995/09/18','NAM','0837295833',N'Kiên Giang','HNHCM9X')
Insert into HANHKHACH values ('HK013',N'Trịnh Minh Khang','1998/01/30','NU','0874812321',N'Khánh Hòa','HNHCM9X')
Insert into HANHKHACH values ('HK014',N'Ngô Bích Hà','2005/05/14','NU','0847593155',N'Quy Nhơn','HNHCM9X')
Insert into HANHKHACH values ('HK015',N'Trần Kim Cúc','1981/11/18','NU','0384839452',N'Khánh Hòa ','DNHCM10')
Insert into HANHKHACH values ('HK016',N'Trần Anh Tuấn','2003/10/27','NAM','0758479031',N'Đà Nẵng','DNCT3XX')
Insert into HANHKHACH values ('HK017',N'Ngô Minh Hiếu','1997/12/11','NAM','0484938842',N'Quảng Bình','DNHCM7X')
Insert into HANHKHACH values ('HK018',N'Mai Anh Thư','2003/04/15','NU','0948867757',N'Cà Mau','HCMH8XX')
Insert into HANHKHACH values ('HK019',N'Lê Trí Viến','1999/01/31','NAM','0384847899',N'Bình Phước','HCMH8XX')
Insert into HANHKHACH values ('HK020',N'Phạm Huy Quang','1969/02/19','NAM','0193838389',N'Phú Yên','DLHN5XX')

--VE
SELECT  * FROM VE
SELECT * FROM VE
Insert into VE values ('AAAAAA','HNHCM1X','11D','HK001','First Class')
Insert into VE values ('AAAAAB','HCMDN2X','14G','HK002','Business Class')
Insert into VE values ('AAAAAC','DNCT3XX','31E','HK003','Premium Class')
Insert into VE values ('AAAAAD','CTDL4XX','3F','HK004','Economy Class')
Insert into VE values ('AAAAAE','DLHN5XX','2D','HK005','First Class')
Insert into VE values ('AAAAAF','HNHCM1X','11A','HK006','Business Class')
Insert into VE values ('AAAAAG','CTDL4XX','3E','HK007','Premium Class')
Insert into VE values ('AAAAAH','HNDN6XX','32G','HK008','Economy Class')
Insert into VE values ('AAAAAI','HNDN6XX','32E','HK009','First Class')
Insert into VE values ('AAAAAJ','DNHCM7X','55A','HK010','Business Class')
Insert into VE values ('AAAAAK','HCMH8XX','21G','HK011','Premium Class')
Insert into VE values ('AAAAAL','HNHCM9X','16A','HK012','Economy Class')
Insert into VE values ('AAAAAM','HNHCM9X','16B','HK013','First Class')
Insert into VE values ('AAAAAN','HNHCM9X','16C','HK014','Business Class')
Insert into VE values ('AAAAAO','DNHCM10','40J','HK015','Premium Class')
Insert into VE values ('AAAAAP','DNHCM10','31G','HK016','Economy Class')
Insert into VE values ('AAAAAQ','DNHCM7X','33G','HK017','First Class')
Insert into VE values ('AAAAAR','HCMH8XX','21F','HK018','Business Class')
Insert into VE values ('AAAAAS','HCMH8XX','12A','HK019','Premium Class')
Insert into VE values ('AAAAAT','DLHN5XX','2G','HK020','Economy Class')

--HANHLY

SELECT * FROM HANHLY
Insert into HANHLY values ('HL010','HK001','HNHCM1X',12)
Insert into HANHLY values ('HL009','HK002','HCMDN2X',9)
Insert into HANHLY values ('HL008','HK003','DNCT3XX',7)
Insert into HANHLY values ('HL007','HK004','CTDL4XX',7)
Insert into HANHLY values ('HL006','HK005','DLHN5XX',8)
Insert into HANHLY values ('HL005','HK006','HNHCM1X',5)
Insert into HANHLY values ('HL004','HK007','CTDL4XX',9)
Insert into HANHLY values ('HL003','HK008','HNDN6XX',7)
Insert into HANHLY values ('HL002','HK009','HNDN6XX',11)
Insert into HANHLY values ('HL001','HK010','DNHCM7X',10)
Insert into HANHLY values ('HL011','HK011','HCMH8XX',0)
Insert into HANHLY values ('HL012','HK012','HNHCM9X',0)
Insert into HANHLY values ('HL013','HK013','HNHCM9X',0)
Insert into HANHLY values ('HL014','HK014','HNHCM9X',0)
Insert into HANHLY values ('HL015','HK015','DNHCM10',0)
Insert into HANHLY values ('HL016','HK016','DNCT3XX',0)
Insert into HANHLY values ('HL017','HK017','DNHCM7X',0)
Insert into HANHLY values ('HL018','HK018','HCMH8XX',0)
Insert into HANHLY values ('HL019','HK019','HCMH8XX',0)
Insert into HANHLY values ('HL020','HK020','DLHN5XX',0)


---7.2.Update dữ liệu vào các table

---7.2.1.UPDATE ngày sinh thành '16/07/1990' cho Nhân Viên có mã NV là 'NV003' 

UPDATE NHANVIEN set NGAYSINH ='1990/07/16' where MANV = 'NV003'

SELECT * FROM NHANVIEN
---7.2.2.UPDATE SDT thành '0365089861' cho Nhân Viên có họ tên là 'Nguyễn Minh Anh'

UPDATE NHANVIEN set SDT ='0365089861' where HOTEN = N'Nguyễn Minh Anh'

---7.2.3.UPDATE giờ cất cánh và giờ hạ cánh cho chuyến bay  có mã chuyến bay là 'HCMDN2X'

UPDATE CHUYENBAY set GCC = '7:45'  where MACB = 'HCMDN2X'
UPDATE CHUYENBAY set GHC = '9:05'  where MACB = 'HCMDN2X'

---7.3.Xóa dữ liệu ở các table

---7.3.1.Xóa nhân viên có mã nhân viên là 'NV016'

DELETE FROM NHANVIEN WHERE MANV = 'NV016'

---8.Lệnh truy vấn dữ liệu:SQL
---8.1.Truy vấn 1 bảng
---8.1.1.Lấy thông tin của những nhân viên có giới tính nam

	SELECT * 
	FROM NHANVIEN 
	WHERE GIOITINH = 'NAM'

---8.1.2.Lấy thông tin của những máy bay đến từ hãng 'Vietnam Airlines'
	
	SELECT *
	FROM MAYBAY
	WHERE HANGMB = 'Vietnam Airlines'

---8.1.3.Lấy thông tin lộ trình của những chuyến bay có điểm đến là 'HO CHI MINH'

SELECT *
FROM LOTRINH
WHERE DDDEN = 'HO CHI MINH'

---8.1.4.Lấy thông tin vé của những hành khách có hạng vé là 'Economy Class'

SELECT  *
FROM VE
WHERE HANGVE = 'Economy Class'
---8.2.Truy vấn nhiều bảng (Phép kết)

---8.2.1.Lấy thông tin của những nhân viên được phân công điều khiển máy bay

	SELECT NHANVIEN.MANV,NHANVIEN.HOTEN,NHANVIEN.NGAYSINH,NHANVIEN.GIOITINH,
		   NHANVIEN.DIACHI,NHANVIEN.SDT,DIEUKHIEN.MAMB  
	FROM NHANVIEN JOIN DIEUKHIEN ON NHANVIEN.MANV = DIEUKHIEN.MANV

---8.2.2.Lấy thông tin của những hành khách có điểm đến là 'HO  CHI MINH'

	SELECT HANHKHACH.MAHK,HANHKHACH.HOTENHK,HANHKHACH.NGAYSINH,HANHKHACH.GIOITINH,
		   HANHKHACH.SDT,HANHKHACH.DIACHI,HANHKHACH.MACB,LOTRINH.DDDEN
	FROM CHUYENBAY JOIN LOTRINH ON CHUYENBAY.MALT = LOTRINH.MALT
				   JOIN HANHKHACH ON CHUYENBAY.MACB = HANHKHACH.MACB
	WHERE LOTRINH.DDDEN = 'HO CHI MINH'
---8.2.3.Lấy thông tin hành khách và vé tương ứng

	SELECT HANHKHACH.MAHK,HANHKHACH.HOTENHK,HANHKHACH.NGAYSINH,HANHKHACH.GIOITINH,
		   HANHKHACH.SDT,HANHKHACH.DIACHI,HANHKHACH.MACB,VE.MAVE,VE.SOGHE,VE.HANGVE
	FROM HANHKHACH,VE
	WHERE HANHKHACH.MAHK = VE.MAHK

---8.2.4.Lấy thông tin hành khách và hành lý tương ứng

	SELECT HANHKHACH.MAHK,HANHKHACH.HOTENHK,HANHKHACH.NGAYSINH,HANHKHACH.GIOITINH,
		   HANHKHACH.SDT,HANHKHACH.DIACHI,HANHKHACH.MACB,HANHLY.MAHL,HANHLY.KHOILUONG
	FROM HANHKHACH,HANHLY
	WHERE HANHKHACH.MAHK = HANHLY.MAHK

---8.3.Truy vấn có điều kiện (and, or, like, between,….)
---8.3.1.Lấy thông tin của những nhân viên là nam và lớn hơn 24 tuổi

	SELECT * 
	FROM NHANVIEN
	WHERE GIOITINH = 'NAM' and (YEAR(GETDATE())-YEAR(NGAYSINH)) > 24
---8.3.2.Lấy thông tin của những hành khách là nam,lớn hơn 21 tuổi và có địa chỉ là 'Quảng Trị'

	SELECT *
	FROM HANHKHACH
	WHERE GIOITINH = 'NAM' and (YEAR(GETDATE())-YEAR(NGAYSINH)) > 20 and DIACHI = N'Quảng Trị'
---8.3.3.Lấy thông tin của những hành khách là nữ,đi chuyến bay của Vietnam Airlines hoặc Vietjet Air
	SELECT  HANHKHACH.MAHK,HANHKHACH.HOTENHK,HANHKHACH.NGAYSINH,HANHKHACH.GIOITINH,
			HANHKHACH.SDT,HANHKHACH.DIACHI,HANHKHACH.MACB,MAYBAY.HANGMB
	FROM CHUYENBAY JOIN HANHKHACH ON CHUYENBAY.MACB = HANHKHACH.MACB
				   JOIN MAYBAY ON CHUYENBAY.MAMB = MAYBAY.MAMB
	WHERE
	HANHKHACH.GIOITINH = 'NU' and (MAYBAY.HANGMB = 'Vietnam Airlines' or MAYBAY.HANGMB = 'Vietjet Air')
--8.3.4.Lấy thông tin những hành khách có họ Nguyễn
	SELECT *
	FROM HANHKHACH
	WHERE HOTENHK LIKE N'Nguyễn%'
--8.3.5.Lấy thông tin của những nhân viên có độ tuổi từ 25-30
	SELECT *
	FROM NHANVIEN
	WHERE (YEAR(GETDATE())-YEAR(NGAYSINH)) between 25 and 30

---8.4.Truy vấn tính toán
--8.4.1.Xuất thông tin và tuổi của nhân viên
	SELECT NHANVIEN.MANV,NHANVIEN.HOTEN,NHANVIEN.GIOITINH,NHANVIEN.DIACHI,
		   NHANVIEN.SDT,(YEAR(GETDATE())-YEAR(NGAYSINH)) as Tuổi
	FROM NHANVIEN
--8.4.2.Tính toán số ngày kể từ ngày sinh đến hiện tại của nhân viên
	SELECT NHANVIEN.MANV,NHANVIEN.HOTEN,NHANVIEN.GIOITINH,NHANVIEN.DIACHI,NHANVIEN.SDT,
		   (YEAR(GETDATE())-YEAR(NGAYSINH)) as Tuổi,DATEDIFF(day,(NGAYSINH),GETDATE()) as 'Số ngày'
	FROM NHANVIEN
--8.4.3.Tính toán tổng số kg hành lý kí gửi của hành khách trên chuyến bay có mã chuyến bay 'CTDL4XX'
	SELECT HANHLY.MACB,SUM (KHOILUONG) as TONGKHOILUONG
	FROM HANHLY
	WHERE MACB = 'CTDL4XX'
	GROUP BY MACB
---8.5.Truy vấn có gom nhóm (group by)
--8.5.1.Đếm số lượng nhân viên theo phái
	SELECT GIOITINH as 'Giới tính',Count(MANV) as 'Số lượng'
	FROM NHANVIEN
	GROUP BY GIOITINH
--8.5.2.Đếm số lượng máy bay theo hãng
	SELECT HANGMB as 'Hãng máy bay',Count(HANGMB) as 'Số lượng'
	FROM MAYBAY
	GROUP BY HANGMB
--8.5.3.Đếm số lượng vé theo hạng vé
	SELECT HANGVE as 'Hạng vé',Count(HANGVE) as 'Số lượng'
	FROM VE
	GROUP BY HANGVE
--8.5.4.Đếm số lượng và tính tuổi trung bình của nhân viên theo giới tính
	SELECT GIOITINH as 'Giới tính',Count(MANV) as 'Số lượng',
		   AVG((YEAR(GETDATE())-YEAR(NGAYSINH))) as 'Tuổi trung bình'
	FROM NHANVIEN
	GROUP BY GIOITINH
--8.5.5.Đếm số lượng vé theo hạng vé và tuổi trung bình của hành khách với hạng vé tương ứng
	SELECT VE.HANGVE as 'Hạng vé',Count(HANGVE) as 'Số lượng',AVG((YEAR(GETDATE())-YEAR(NGAYSINH))) as 'Tuổi trung bình'
	FROM VE,HANHKHACH
	WHERE VE.MAHK = HANHKHACH.MAHK
	GROUP BY VE.HANGVE
---8.6.Truy vấn gom nhóm có điều kiện (having) 
--8.6.1.Lấy mã chuyến bay của các chuyến bay có trên 2 hành khách
	SELECT CHUYENBAY.MACB,count(CHUYENBAY.MACB) as 'Số lượng'
	FROM CHUYENBAY,HANHKHACH
	WHERE HANHKHACH.MACB = CHUYENBAY.MACB
	GROUP BY CHUYENBAY.MACB,HANHKHACH.MACB
	HAVING count(CHUYENBAY.MACB) > 2
--8.6.2.Số lượng của nhân viên nam,nữ có tuổi trên 30
	SELECT GIOITINH as 'Giới tính',Count(MANV) as 'Số lượng'
	FROM NHANVIEN
	GROUP BY GIOITINH,NGAYSINH
	HAVING (YEAR(GETDATE())-YEAR(NGAYSINH)) > 30

--8.6.3.Số lượng hành khách theo từng độ tuổi của hãng Vietnam Airlines
	SELECT count(MAHK) as 'Số lượng',MAYBAY.HANGMB,(YEAR(GETDATE())-YEAR(NGAYSINH)) as Tuổi
	FROM HANHKHACH,CHUYENBAY,MAYBAY
	WHERE HANHKHACH.MACB = CHUYENBAY.MACB and
		  CHUYENBAY.MAMB = MAYBAY.MAMB
	GROUP BY MAHK,HANGMB,NGAYSINH
	HAVING HANGMB = 'Vietnam Airlines'
---8.7.Truy vấn có sử dụng phép giao, hội,trừ 
--8.7.1.Lấy thông tin của những nhân viên không được phân công điều khiển máy bay nào
	SELECT NHANVIEN.MANV,NHANVIEN.HOTEN,NHANVIEN.GIOITINH,
		   NHANVIEN.NGAYSINH,NHANVIEN.DIACHI,NHANVIEN.SDT
	FROM NHANVIEN
	EXCEPT
	SELECT NHANVIEN.MANV,NHANVIEN.HOTEN,NHANVIEN.GIOITINH,
		   NHANVIEN.NGAYSINH,NHANVIEN.DIACHI,NHANVIEN.SDT
	FROM DIEUKHIEN,NHANVIEN
	WHERE NHANVIEN.MANV = DIEUKHIEN.MANV
--8.7.2.Lấy mã hành khách,mã chuyến bay của những hành khách có đem theo hành lý kí gửi
    SELECT HANHKHACH.MAHK,HANHKHACH.MACB FROM HANHKHACH
	INTERSECT
	SELECT HANHLY.MAHK,HANHLY.MACB FROM HANHLY
	WHERE KHOILUONG > 0
	SELECT * FROM VE
	SELECT * FROM HANHLY
--8.7.3.Lấy mã hành khách của những hành khách có MAHK bắt đầu bằng 'HK01' hoặc có MAHL bắt đầu bằng 'HL01'
	SELECT MAHK
	FROM VE
	WHERE MAHK LIKE 'HK01%'
	UNION
	SELECT MAHK
	FROM HANHLY
	WHERE MAHL like 'HL01%'
	
--8.8.Truy vấn con
---8.8.1.Lấy thông tin của những hành khách có giới tính nam
	SELECT * FROM HANHKHACH
				WHERE GIOITINH IN (SELECT GIOITINH
								FROM HANHKHACH
				WHERE GIOITINH ='NAM')

---8.8.2.Lấy thông tin của những nhân viên có độ tuổi lớn hơn độ tuổi trung bình của nhân viên
	SELECT NHANVIEN.MANV,NHANVIEN.HOTEN,NHANVIEN.GIOITINH,NHANVIEN.NGAYSINH,NHANVIEN.DIACHI,
		   NHANVIEN.SDT,year (getdate())- year(NGAYSINH) as 'Tuổi'
	FROM NHANVIEN
	WHERE (year (getdate())- year(NGAYSINH)) > (SELECT AVG(year (getdate())- year(NGAYSINH)) FROM NHANVIEN)
---8.8.3.Lấy thông tin của những nhân viên có độ tuổi không nằm trong khoảng từ 25 đến 30.
	SELECT MANV,HOTEN,NGAYSINH,year (getdate())- year(NGAYSINH) as 'Tuổi'
			FROM NHANVIEN
			WHERE  ( year (getdate())- year(NGAYSINH)) 
					 NOT IN (SELECT year (getdate())- year(NgaySinh) 
							FROM nhanvien
							WHERE ( year (getdate())- year(NgaySinh)) < 31 and year (getdate())- year(NgaySinh) > 24 )
---8.9.Truy vấn chéo
--*Tạo bảng tổng hợp từ 3 bảng NHANVIEN,DIEUKHIEN,MAYBAY
	SELECT NHANVIEN.MANV,NHANVIEN.HOTEN,DIEUKHIEN.MAMB,MAYBAY.HANGMB INTO BANGTH FROM NHANVIEN,DIEUKHIEN,MAYBAY
	WHERE NHANVIEN.MANV = DIEUKHIEN.MANV and DIEUKHIEN.MAMB = MAYBAY.MAMB
--*Đếm số lượng máy bay của mỗi hãng
	SELECT N'SỐ LƯỢNG MÁY BAY' as 'HÃNG MÁY BAY',[Vietnam Airlines],[Vietjet Air],[Bamboo Airways],[Pacific Airlines],[Vietravel Airlines]
	FROM (
	SELECT MAMB,HANGMB FROM BANGTH as BANGMOI) as BANGCU
	PIVOT
	( COUNT(MAMB)
	FOR HANGMB IN ([Vietnam Airlines],[Vietjet Air],[Bamboo Airways],[Pacific Airlines],[Vietravel Airlines]))
	AS BANGCU


-- 9.Viết store procedure và function 

--- 9.1.STORE PROCEDURE
------------------------

--  9.1.1.STORE PROCEDURE(1)
--Viết store procedure lọc tuổi của hành khách
	CREATE PROCEDURE loctuoihk (@tuoi INT)
	AS
	BEGIN
	SELECT * FROM HANHKHACH 
	WHERE (YEAR(GETDATE()) - YEAR(NGAYSINH)) >= @tuoi
	END ;
--Thực thi loctuoihk với tham số đầu vào là 20 tuổi
    EXEC loctuoihk 20 ;
-- 9.1.2.STORE PROCEDURE(2)
--Viết store procedure cho biết thông tin của hành khách có điểm đến là @diemden
	CREATE PROCEDURE locdiemden (@diemden varchar(50))
	AS
	BEGIN
	SELECT HANHKHACH.MAHK,HANHKHACH.HOTENHK,HANHKHACH.NGAYSINH,HANHKHACH.GIOITINH,HANHKHACH.SDT,HANHKHACH.DIACHI
	,HANHKHACH.MACB
	FROM
	CHUYENBAY JOIN HANHKHACH ON CHUYENBAY.MACB = HANHKHACH.MACB
	JOIN LOTRINH ON CHUYENBAY.MALT = LOTRINH.MALT
	WHERE LOTRINH.DDDEN = @diemden 
	END ;
--Thực thi locdiemden với điểm đến là HO CHI MINH
    EXEC locdiemden 'HO CHI MINH'
-- 9.1.3.STORE PROCEDURE(3)
--Viết store procedure cho biết thông tin của hành khách đi hãng máy bay @hanggmaybay
	CREATE PROCEDURE hangmaybay (@hangmaybay varchar(50))
	AS
	BEGIN
	SELECT HANHKHACH.MAHK,HANHKHACH.HOTENHK,HANHKHACH.NGAYSINH,HANHKHACH.GIOITINH,HANHKHACH.SDT,HANHKHACH.DIACHI
	,HANHKHACH.MACB,MAYBAY.HANGMB
	FROM
	CHUYENBAY JOIN HANHKHACH ON CHUYENBAY.MACB = HANHKHACH.MACB
	JOIN MAYBAY ON CHUYENBAY.MAMB = MAYBAY.MAMB
	WHERE MAYBAY.HANGMB = @hangmaybay 
	END ;
--Thực thi hangmaybay với Hãng máy bay là Vietnam Airlines
	EXEC hangmaybay 'Vietnam Airlines'

-----9.2.FUNCTION
---------------
-- 9.2.1.FUNCTION(1)
--Viết function tính tuổi của nhân viên
	CREATE FUNCTION tinhtuoinv ()
	RETURNS TABLE AS RETURN 
	SELECT NHANVIEN.MANV,NHANVIEN.HOTEN,NHANVIEN.GIOITINH,(YEAR(GETDATE()) - YEAR(NGAYSINH)) as 'Tuổi'
	FROM NHANVIEN
--Thực thi function
    SELECT * FROM tinhtuoinv ()
-- 9.2.2.FUNCTION(2)
--Viết function cho biết thông tin của những hành khách >20 tuổi,có mã chuyến bay là 'HNHCM1X',Có hạng vé là 'First Class' và đem nhiều hơn 9kg hành lý.
	CREATE FUNCTION laytth ()
	RETURNS TABLE AS RETURN 
	SELECT HANHKHACH.MAHK,HANHKHACH.HOTENHK,HANHKHACH.NGAYSINH,HANHKHACH.GIOITINH,HANHKHACH.SDT,HANHKHACH.DIACHI
	,HANHKHACH.MACB
	FROM HANHKHACH JOIN VE ON HANHKHACH.MAHK = VE.MAHK
	JOIN HANHLY ON HANHKHACH.MAHK = HANHLY.MAHK
	WHERE HANHKHACH.MACB = 'HNHCM1X' and (YEAR(GETDATE()) - YEAR(NGAYSINH)) > 20 and HANGVE = 'First Class' and KHOILUONG > 9
--Thực thi Funtion 
	SELECT * FROM laytth()
-- 9.2.3.FUNCTION(3)
--Viết function cho biết thông tin của những hành khách có tuổi > @tuoi,có điểm đến là @diemden,hãng máy bay là @hangmaybay
	CREATE FUNCTION lochk (@tuoi INT,@diemden varchar(50),@hangmaybay varchar(50))
	RETURNS TABLE AS RETURN 
	SELECT HANHKHACH.MAHK,HANHKHACH.HOTENHK,HANHKHACH.NGAYSINH,HANHKHACH.GIOITINH,HANHKHACH.SDT,HANHKHACH.DIACHI
	,HANHKHACH.MACB,LOTRINH.DDDEN,MAYBAY.HANGMB
	FROM CHUYENBAY JOIN HANHKHACH ON CHUYENBAY.MACB = HANHKHACH.MACB
	JOIN LOTRINH ON CHUYENBAY.MALT = LOTRINH.MALT
	JOIN MAYBAY ON CHUYENBAY.MAMB = MAYBAY.MAMB
	WHERE (YEAR(GETDATE()) - YEAR(NGAYSINH)) > @tuoi AND LOTRINH.DDDEN = @diemden AND MAYBAY.HANGMB = @hangmaybay
--Thực thi Funtion với tham sô đầu vào là 18 tuổi,điểm đến là 'HO CHI MINH',hãng máy bay là 'Vietnam Airlines'.
	SELECT * FROM lochk(18,'HO CHI MINH','Vietnam Airlines')

--- 10. Viết trigger ràng buộc dữ liệu cho các bảng 

-- 10.1.Trigger
--Viết trigger cập nhật khối lượng hành lý kí gửi của hành khách.
--Tạo bảng cập nhật hành lý

	CREATE TABLE CAPNHATHL
	(
	MAHK varchar (20),
	MAHL varchar (20),
	HLMUATHEM int,
	CONSTRAINT pk_hkl PRIMARY KEY (MAHK,MAHL) 
	)
	ALTER TABLE CAPNHATHL ADD CONSTRAINT fk_UD1 FOREIGN KEY(MAHL) REFERENCES HANHLY(MAHL)
	--Tạo trigger
	CREATE TRIGGER trg_hanhly ON CAPNHATHL AFTER INSERT AS 
	BEGIN
		UPDATE HANHLY
		SET KHOILUONG = KHOILUONG + (
			SELECT HLMUATHEM
			FROM inserted
			WHERE MAHL = HANHLY.MAHL
		)
		FROM HANHLY
		JOIN inserted ON HANHLY.MAHL = inserted.MAHL
	END
--Cập nhật hành lý
INSERT INTO CAPNHATHL VALUES ('HK006','HL005',5)
INSERT INTO CAPNHATHL VALUES ('HK008','HL003',10)
INSERT INTO CAPNHATHL VALUES ('HK011','HL011',12)
INSERT INTO CAPNHATHL VALUES ('HK013','HL013',10)
INSERT INTO CAPNHATHL VALUES ('HK019','HL019',20)

---10.2.Viết ràng buộc
-- Viết ràng buộc mã nhân viên có 5 kí tự
		ALTER TABLE NHANVIEN
		ADD CONSTRAINT check_MANV CHECK (len(rtrim(MANV))=5)
--Viết ràng buộc số điện thoại là duy nhất
  --Bảng nhân viên
		ALTER TABLE NHANVIEN
		ADD CONSTRAINT uni_SDT UNIQUE (SDT)
  --Bảng hành khách
		ALTER TABLE HANHKHACH
		ADD CONSTRAINT uni_SDTHK UNIQUE (SDT)
--Viết ràng buộc số điện thoại phải có 10 chữ số
  --Bảng nhân viên
		ALTER TABLE NHANVIEN
		ADD CONSTRAINT check_SDT CHECK (len(SDT) = 10 and isnumeric(SDT) = 1)
  --Bảng hành khách
       	ALTER TABLE HANHKHACH
		ADD CONSTRAINT check_SDTHK CHECK (len(SDT) = 10 and isnumeric(SDT) = 1)
--Viết ràng buộc giới tính phải làm NAM hoặc NU
  --Bảng nhân viên
        ALTER TABLE NHANVIEN
		ADD CONSTRAINT check_GT CHECK (GIOITINH = 'NAM' or GIOITINH = 'NU')
  --Bảng hành khách
        ALTER TABLE HANHKHACH
		ADD CONSTRAINT check_GTHK CHECK (GIOITINH = 'NAM' or GIOITINH = 'NU')

---11. Phân quyền 

-- TẠO TÀI KHOẢN admin
			CREATE LOGIN account_ad1 WITH PASSWORD = '123456ad1'
			CREATE LOGIN account_ad2 WITH PASSWORD = '135790ad2'
-- Phân quyền cho admin
			CREATE USER admin1 FOR LOGIN account_ad1 
			CREATE USER admin2 FOR LOGIN account_ad2 
			GRANT SELECT, INSERT,UPDATE, DELETE , REFERENCES to admin1 
			GRANT SELECT, INSERT,UPDATE, DELETE , REFERENCES to admin2
-- Tạo tài khoản cho user
			CREATE LOGIN user1 WITH PASSWORD = '1234567us1'
			CREATE LOGIN user2 WITH PASSWORD = '1717281us2'
-- Phân quyền cho user
			CREATE USER user_1 FOR LOGIN user1
			CREATE USER user_2 FOR LOGIN user2
			GRANT SELECT, INSERT ON HANHKHACH to user_1
			GRANT SELECT, INSERT ON NHANVIEN to user_2
			GRANT SELECT ON CHUYENBAY to user_1
			GRANT SELECT,UPDATE ON HANHLY to user_2
			GRANT UPDATE,DELETE ON VE to user_1
			GRANT SELECT,INSERT,UPDATE ON DIEUKHIEN to user_2

-- Thu hồi quyền

			REVOKE INSERT ON user_1 from HANHKHACH
			REVOKE INSERT ON user_2 from NHANVIEN
			REVOKE DELETE ON user_1 from VE
			REVOKE UPDATE ON user_2 from DIEUKHIEN

--12.Sao lưu dữ liệu
-- Sao lưu bằng lệnh
-- Tạo thủ tục lưu dữ liệu
CREATE PROCEDURE
			CREATE PROCEDURE SLDatabse(@database nvarchar(200),@NoiLuu nvarchar(200))
			 AS
				BEGIN
					backup database @database to disk = @NoiLuu 
				END
--  Chạy thủ tục lưu CSDL QLCB với nới lưu là Local Disk (D:) với tên file là [CSDLFINAL]
			EXEC SLDatabse QLCB,'D:\[CSDLFINAL]'
			GO
-- Khôi phục dữ liệu bằng SQL
-- Tạo thủ tục khôi phục dữ liệu
			CREATE PROCEDURE KPDatabase(@database nvarchar(200),@Vitri nvarchar(200))
			AS
				BEGIN
					restore database @database from disk = @Vitri With replace ,
					RECOVERY
				END
-- Chạy thủ tục khôi phục CSDL QLCB với nới khôi phục là Local Disk (D:) với tên file là [CSDLRESTORE]
			EXEC KPDatabase QLCB,'D:\[CSDLFINAL]'
      		GO

