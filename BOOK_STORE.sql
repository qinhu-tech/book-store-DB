use master
if exists (select * from sysdatabases where name = 'book_store')
	drop database book_store
go

create database book_store
go
use book_store
go

CREATE TABLE THELOAI(
	MaTL CHAR(10) PRIMARY KEY,
	TenTL NVARCHAR(50) NOT NULL,
);

CREATE TABLE TACGIA(
	MaTG CHAR(10) PRIMARY KEY,
	TenTG NVARCHAR(50) NOT NULL,
	NgaySinh DATE NOT NULL,
);

CREATE TABLE NXB(
	MaNXB CHAR(10) PRIMARY KEY,
	TenNXB NVARCHAR(50) NOT NULL,
	DiaChi NVARCHAR(100) NOT NULL,
	SDT CHAR(10) NOT NULL,
);

CREATE TABLE SACH(
	MaSach CHAR(10) PRIMARY KEY,
	MaNXB CHAR(10) NOT NULL,
	TenSach NVARCHAR(50) NOT NULL,
	ChiTiet NVARCHAR(200) NOT NULL,
	Gia INT NOT NULL,
	TinhTrang NVARCHAR(50) NOT NULL,
	MaTL CHAR(10) NOT NULL,
	NXB NVARCHAR(50) NOT NULL,
	MaTG CHAR(10) NOT NULL,
	FOREIGN KEY (MaTL) REFERENCES THELOAI(MaTL),
	FOREIGN KEY (MaTG) REFERENCES TACGIA(MaTG),
	FOREIGN KEY (MaNXB) REFERENCES NXB(MaNXB)
);

CREATE TABLE CHUCVU(
	MaCV CHAR(10) PRIMARY KEY,
	TenCV NVARCHAR(50) NOT NULL,
);

CREATE TABLE NHANVIEN(
	MaNV CHAR(10) PRIMARY KEY,
	TenNV NVARCHAR(50) NOT NULL,
	NgaySinh DATE NOT NULL,
	DiaChi NVARCHAR(100) NOT NULL,
	MaCV CHAR(10) NOT NULL,
	GioiTinh CHAR(5) NOT NULL,
	FOREIGN KEY (MaCV) REFERENCES CHUCVU(MaCV)
);

CREATE TABLE KHACHHANG(
	MaKH CHAR(10) PRIMARY KEY,
	TenKH NVARCHAR(50) NOT NULL,
	Email NVARCHAR(50) UNIQUE NOT NULL,
	DiaChi NVARCHAR(100) NOT NULL,
	MatKhau NVARCHAR(20) NOT NULL,
	SDT CHAR(10) NOT NULL,
);


CREATE TABLE HOADON(
	MaHD CHAR(10) PRIMARY KEY,
	MaKH CHAR(10) NOT NULL,
	MaNV CHAR(10) NOT NULL,
	NgayLapHD DATE NOT NULL,
	NgayGiao DATE NOT NULL,
	TongGia DECIMAL(10, 2) NOT NULL,
	FOREIGN KEY (MaKH) REFERENCES KHACHHANG(MaKH),
	FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
);

CREATE TABLE NHACUNGCAP(
	MaNCC CHAR(10) PRIMARY KEY,
	TenNCC NVARCHAR(50) NOT NULL,
	DiaChi NVARCHAR(100) NOT NULL,
	SDT CHAR(10) NOT NULL,
);

CREATE TABLE HOADONNHAP(
	MaHDN CHAR(10) PRIMARY KEY,
	MaNCC CHAR(10) NOT NULL,
	MaNV CHAR(10) NOT NULL,
	NgayLapHD DATE NOT NULL,
	NgayGiao DATE NOT NULL,
	FOREIGN KEY (MaNCC) REFERENCES NHACUNGCAP(MaNCC),
	FOREIGN KEY (MaNV) REFERENCES NHANVIEN(MaNV)
);

CREATE TABLE CHITIETHOADON(
	MaHD CHAR(10) NOT NULL,
	MaSach CHAR(10) NOT NULL,
	SoLuong INT NOT NULL,
	DonGia DECIMAL(10, 2) NOT NULL,
	FOREIGN KEY (MaHD) REFERENCES HOADON(MaHD),
	FOREIGN KEY (MaSach) REFERENCES SACH(MaSach)
);

CREATE TABLE CHITIETNHAP(
	MaHDN CHAR(10) NOT NULL,
	MaSach CHAR(10) NOT NULL,
	TenSach NVARCHAR(50) NOT NULL,
	SoLuong INT NOT NULL,
	DonGia DECIMAL(10, 2) NOT NULL,
	FOREIGN KEY (MaHDN) REFERENCES HOADONNHAP(MaHDN)
);

INSERT INTO THELOAI(MaTL, TenTL)
VALUES ('TL01', N'Kiến thức tổng hợp'),
		('TL02', N'Truyện'),
		('TL03', N'Âm nhạc'),
		('TL04', N'Nghiên cứu'),
		('TL05', N'Tiểu thuyết')

INSERT INTO TACGIA(MaTG, TenTG, NgaySinh)
VALUES ('TG01', N'Nguyễn Nhật Ánh','1955-05-07'),
		('TG02', N'Tô Hoài','1918-11-05'),
		('TG03', N'Nguyên Hồng','19-09-27'),
		('TG04', N'Nguyễn Ngọc Hoài Nam','1965-05-05'),
		('TG05', N'Luis Sepúlveda','1949-10-04'),
		('TG06', N'Kitou Aya','1962-07-19'),
		('TG07', N'Alphonse Daudet','1840-05-13'),
		('TG08', N'Usami Rin','1999-05-16'),
		('TG09', N'Alex Tú','1799-06-06'),
		('TG10', N'Đào Hải Ninh','1931-12-31')

INSERT INTO NXB(MaNXB, TenNXB, DiaChi, SDT)
VALUES ('NXB01', N'Nhà Xuất Bản Trẻ', N'161B Lý Chính Thắng, phường Võ Thị Sáu, Quận 3, TP. Hồ Chí Minh', '039316289'),
		('NXB02', N'Nhà Xuất Kim Đồng', N'248 Cống Quỳnh, P. Phạm Ngũ Lão, Q.1 TP. Hồ Chí Minh', '039303832 '),
		('NXB03', N'Nhã Nam', N'59 Đỗ Quang, Cầu Giấy, Hà Nội ', '0903244248'),
		('NXB04', N'Nhà Xuất Bản Phụ nữ Việt Nam', N'16 Alexandre De Rhodes, Q.1, TP. HCM ', '038294459')

INSERT INTO SACH(MaSach,MaNXB,TenSach,ChiTiet,Gia,TinhTrang,MaTL,NXB,MaTG)
VALUES 
		('S01', N'NXB01',N'Làm bạn với bầu trời',
		N'Làm bạn với bầu trời mở đầu với một câu chuyện giản dị, chân phương nhưng không kém phần bất ngờ đến tận trang cuối cùng.',
		100.000,N'còn hàng',N'TL05',N'Nhà Xuất Bản Trẻ',N'TG01'),

		('S02', N'NXB01',N'Con chim xanh biếc bay về',
		N'Con chim xanh biếc bay về dẫn bạn đi hết từ bất ngờ này đến tò mò suy đoán khác, để kết thúc bằng một nỗi hân hoan vô bờ sau bao phen hồi hộp nghi kị đến khó thở.',
		100.000,N'còn hàng',N'TL05',N'Nhà Xuất Bản Trẻ',N'TG01'),

		('S03', N'NXB01',N'Mắt biếc', 
		N'Một tác phẩm với nội dung trong sáng của một tình cảm, điểm đặc biệt của tác phẩm khi suốt câu chuyện vẫn là những điều vui, buồn lẫn lộn nhưng lại có một kết thúc buồn, kết thúc không như mong đợi của mọi người.',
		100.000,N'còn hàng',N'TL05',N'Nhà Xuất Bản Trẻ',N'TG01'),

		('S04', N'NXB01',N'Cô gái đến từ hôm qua', 
		N'Cuốn sách này đã được chuyển thể thành phim cùng tên rất thành công. Nếu ngày xưa còn bé, Thư luôn tự hào mình là cậu con trai thông minh có quyền bắt nạt và sai khiến các cô bé cùng lứa tuổi thì giờ đây khi lớn lên, anh luôn khổ sở khi thấy mình ngu ngơ và bị con gái “xỏ mũi”. ',
		100.000,N'còn hàng',N'TL05',N'Nhà Xuất Bản Trẻ',N'TG01'),

		('S05', N'NXB02',N'Kính Vạn Hoa',
		N' Qua nét vẽ hiện đại, cá tính và đầy nghệ thuật, thế giới học trò tinh nghịch hiện lên sống động hòa quyện với những lời văn của “hoàng tử bé” Nguyễn Nhật Ánh.',
		100.000,N'còn hàng',N'TL05',N'Nhà Xuất Kim Đồng',N'TG01'),

		('S06', N'NXB02',N'Dế Mèn',
		N'Một con dế đã từ tay ông thả ra chu du thế giới tìm những điều tốt đẹp cho loài người. Và con dế ấy đã mang tên tuổi ông đi cùng trên những chặng đường phiêu lưu đến với cộng đồng những con vật trong văn học thế giới, đến với những xứ sở thiên nhiên và văn hóa của các quốc gia khác.',
		100.000,N'còn hàng',N'TL02',N'Nhà Xuất Kim Đồng',N'TG02'),

		('S07', N'NXB02',N'Những ngày thơ ấu',
		N'Cuốn sách tái hiện rõ nét tuổi thơ cơ cực và bất hạnh của Nguyên Hồng với những đắng cay xảy đến khi tuổi đời quá nhỏ. Có lẽ ai ai cũng sẽ rơi nước mắt đồng cảm cho một cậu bé ngây thơ phải chịu đủ mọi ngang trái của số phận.',
		100.000,N'còn hàng',N'TL02',N'Nhà Xuất Kim Đồng',N'TG03'),

		('S08', N'NXB02',N'Tủ sách tuổi thần tiên - giao thừa không đến muộn',
		N'“Giao thừa không đến muộn” là tập truyện ngắn đầu tay của Nguyễn Ngọc Hoài Nam. Cuốn sách gồm 10 truyện ngắn thú vị, hấp dẫn như: “Con ma da sau vườn”, “Học bơi”, “Đô ơi”… là món quà ấm áp mà tác giả muốn dành tặng cho những bạn đọc nhỏ tuổi có lòng dũng cảm và sự hào hiệp',
		100.000,N'hết hàng',N'TL02',N'Nhà Xuất Kim Đồng',N'TG04'),

		('S09', N'NXB03',N'Chuyện con mèo dạy hải âu bay',
		N'Chuyện con mèo dạy hải âu bay luôn giúp người đọc nhận ra được nhiều bài học trong cuộc sống như học cách yêu thương những điều khác biệt, luôn luôn giữ lời hứa dù trong hoàn cảnh khó khăn,... vô cùng ý nghĩa',
		100.000,N'còn hàng',N'TL02',N'Nhã Nam',N'TG05'),

		('S10', N'NXB03',N'Một lít nước mắt',
		N'Aya, tương lai của cô là một con đường hẹp, và càng ngày nó càng trở nên hẹp hơn. Căn bệnh ngăn trở Aya khỏi tất cả những ước mơ và dự định, thậm chí việc tự mình bước ra ngoài phố để đi tới hiệu sách cũng trở thành một khao khát cháy bỏng',
		100.000,N'hết hàng',N'',N'Nhã Nam',N'TG06'),

		('S11', N'NXB03',N'Lá thư hè',
		N'Đây chính là tác phẩm tôi thích nhất, không phải về phương diện văn chương mà bởi tác phẩm này đã nhắc tôi nhớ những giờ khắc đẹp đẽ nhất của tuổi trẻ, những trận cười điên cuồng, những phút say mê không hối tiếc, những bộ mặt, những bóng dáng bạn bè mà sau này tôi không còn gặp lại bao giờ',
		100.000,N'còn hàng',N'TL02',N'Nhã Nam',N'TG07'),

		('S12', N'NXB03',N'THẦN TƯỢNG CỦA TÔI DÍNH PHỐT RỒI',
		N'Không lối thoát, không nơi nương tựa, với Akari, "thần tượng" là lý do em hít thở mỗi ngày, là "xương sống" của em. Nhưng thần tượng của em dính "phốt" rồi! Ngọn lửa thị phi ngày càng lan rộng. Thế giới của em từng phần vụn vỡ. Phải làm sao để cứu chính mình? ',
		100.000,N'hết hàng',N'TL05',N'Nhã Nam',N'TG08'),

		('S13', N'NXB04',N'Chiếc Birkin màu cam',
		N'Một chiếc túi Birkin không phải là đích đến trong cuộc đời này. Nhưng chiếc túi Birkin màu cam gắn bó trong cuốn sách này là một ẩn dụ mà tác giả Alex Tu muốn chia sẻ với độc giả về một cuộc sống tự chủ, chất lượng, đầy tiềm năng, nhiều niềm vui và lan tỏa năng lượng tích cực.',
		100.000,N'còn hàng',N'TL01',N'Nhà Xuất Phụ nữ Việt Nam',N'TG09'),

		('S14', N'NXB04',N'Quý cô tự chủ',
		N'Nếu bạn đang cảm thấy một chút chênh vênh,
		Nếu bạn đang muốn bản thân mạnh mẽ hơn,
		Nếu bạn đang cần tự do, thật nhiều tự do,',
		100.000,N'còn hàng',N'TL01',N'Nhà Xuất Phụ nữ Việt Nam',N'TG09'),

		('S15', N'NXB04',N'Con về không phải bởi phép màu',
		N'Câu chuyện đồng hành cùng trẻ tự kỉ, ghi lại những câu chuyện của giáo viên và phụ huynh tại Trung tâm Nghiên cứu ứng dụng và hỗ trợ trẻ tự kỉ Tuệ Quang',
		100.000,N'còn hàng',N'TL02',N'Nhà Xuất Phụ nữ Việt Nam',N'TG10'),

		('S16', N'NXB04',N'Con về',
		N'Tự truyện về hành trình nuôi dạy trẻ tự kỉ',
		100.000,N'còn hàng',N'',N'Nhà Xuất Phụ nữ Việt Nam',N'TG10')


INSERT INTO CHUCVU(MaCV, TenCV)
VALUES ('GD', N'Giám đốc'),
		('TP', N'Trưởng phòng'),
		('NVBH', N'Nhân viên bán hàng'),
		('NVKH', N'Nhân viên kho hàng'),
		('NVVP', N'Nhân viên văn phòng')


INSERT INTO NHANVIEN(MaNV, TenNV, NgaySinh, DiaChi, MaCV, GioiTinh)
VALUES ('NV01', N'Nguyễn Minh Huy','2000-04-05',N'863 Phan Văn Trị, phường 7, quận Gò Vấp','NVVP',N'Nam'),
		('NV02', N'Nguyễn Thị Lan','1998-09-02',N'348 Bắc Hải, phường 6, quận 10, TP.HCM','NVBH',N'Nữ'),
		('NV03', N'Lê Thị Ly','2001-02-01',N'244 Huỳnh Văn Bánh, phường 11, quận Phú Nhuận, TP.HCM','GD',N'Nữ'),
		('NV04', N'Lê Văn Trung','1995-04-19',N'453 Lê Văn Sỹ, phường 12, quận 3, TP.HCM','NVBH',N'Nam'),
		('NV05', N'Nguyễn Thị Ngọc','2000-06-13',N'645 Quang Trung, phường 11, quận Gò Vấp, TP.HCM','TP',N'Nữ'),
		('NV06', N'Nguyễn Minh Thắng','2000-11-05',N'234 đường 3/2, phường 12, quận 10, TP.HCM','NVKH',N'Nam'),
		('NV07', N'Lê Thị Yên','1997-10-30',N'524 Lý Thường Kiệt, phường 7, Tân Bình, TP.HCM','NVKH',N'Nữ'),
		('NV08', N'Nguyễn Thị Hoa','1997-04-29',N'673 Nguyễn Kiệm, phường 9, quận Phú Nhuận, TP.HCM','NVVP',N'Nữ'),
		('NV09', N'Lê Ngọc Hân','1998-01-12',N'87 Hoàng Sa, phường 9, quận 3, TP.HCM','NVBH',N'Nữ'),
		('NV10', N'Nguyễn Thị Thư','2001-04-05',N'969 Lạc Long Quân, phường 11, Tân Bình, TP.HCM','NVKH',N'Nữ')

INSERT INTO KHACHHANG(MaKH, TenKH, Email, DiaChi, MatKhau, SDT)
VALUES ('KH01', N'Lâm Minh Anh',N'lmanh@gmai;.com',N'423 Lạc Long Quân, phường 5, quận 11, TP.HCM',N'minhanh6386','0339646386'),
		('KH02', N'Ngô Minh Duy',N'ngoduy23@gmail.com',N'255 Nguyễn Văn Lượng, phường 10, quận Gò Vấp, TP.HCM',N'duyngo033857357','033857357'),
		('KH03', N'Nguyễn Thị Anh',N'thingyanh352@gmail.com',N'132 Lý Thái Tổ, phường 2, quận 3, TP.HCM',N'0908264038','0908264038'),
		('KH04', N'Lâm Ngọc Yên',N'yehnahti@gmail.com',N'549 Điện Biên Phủ, phường 3, quận 3, TP.HCM',N'yen69264822','0957485024'),
		('KH05', N'Nguyễn Minh Ngọc',N'nginhmocng@gmail.com',N'74 Sư Vạn Hạnh, phường 10, quận 10, TP.HCM',N'0933749204','0933749204'),
		('KH06', N'Hàn Ngọc Ý',N'yhmibg153@gmail.com',N'970 Tạ Quang Bửu, phường 6, quận 8, TP.HCM',N'6629562ngocy','0338264038'),
		('KH07', N'Ngô Thị Lệ',N'leyhthungo@gmail.com',N'27 Nguyễn Văn Đậu, phường 6, quận Phú Nhuận, TP.HCM',N'975638629le','0975638629'),
		('KH08', N'Hàn Minh Quân',N'quahmihnan41@gmail.com',N'911 Lê Hồng Phong, phường 12, quận 10, TP.HCM',N'124356788','0333956295')

INSERT INTO HOADON(MaHD, MaKH, MaNV, NgayLapHD, NgayGiao, TongGia)
VALUES ('HD01','KH02','NV02','2023-05-23','2023-05-30','200,000đ'),
		('HD02','KH05','NV02','2023-05-23','2023-05-30','300,000đ'),
		('HD03','KH01','NV02','2023-05-23','2023-05-30','100,00đ'),
		('HD04','KH03','NV09','2023-06-10','2023-06-17','150,000đ'),
		('HD05','KH02','NV09','2023-06-10','2023-06-17','200,000đ'),
		('HD06','KH08','NV09','2023-06-10','2023-06-17','420,000đ'),
		('HD07','KH04','NV09','2023-06-10','2023-06-17','140,000đ'),
		('HD08','KH05','NV02','2023-06-15','2023-06-22','620,000đ'),
		('HD09','KH02','NV04','2023-07-03','2023-07-10','320,000đ'),
		('HD10','KH06','NV04','2023-07-03','2023-07-10','160,000đ'),
		('HD11','KH03','NV04','2023-07-03','2023-07-10','190,000đ'),
		('HD12','KH07','NV04','2023-07-03','2023-07-10','475,000đ'),
		('HD13','KH01','NV04','2023-07-03','2023-07-10','380,000đ'),
		('HD14','KH08','NV09','2023-07-16','2023-07-23','340,000đ')

INSERT INTO NHACUNGCAP(MaNCC, TenNCC, DiaChi, SDT)
VALUES ('NCC01', N'Sách Đại Nam',N'250A Tân Kỳ Tân Quý, phường Sơn Kỳ, quận Tân Phú, TP.HCM','0285 4082 479'),
		('NCC02', N'Nhà sách Fahasa',N'60 - 62 Lê Lợi, Quận 1, TP. HCM','1900636467'),
		('NCC03', N'Nhân Văn',N'Số 1 Trường Chinh,phường 11,quận Tân Bình, TP.HCM','0813.709.777')

INSERT INTO HOADONNHAP(MaHDN, MaNCC, MANV, NgayLApHD, NgayGiao)
VALUES ('HDN01','NCC02','NV02','2023-05-23','2023-05-30'),
		('HDN02','NCC05','NV02','2023-05-23','2023-05-30'),
		('HDN03','NCC01','NV02','2023-05-23','2023-05-30'),
		('HDN04','NCC03','NV09','2023-06-10','2023-06-17'),
		('HDN05','NCC02','NV09','2023-06-10','2023-06-17'),
		('HDN06','NCC08','NV09','2023-06-10','2023-06-17'),
		('HDN07','NCC04','NV09','2023-06-10','2023-06-17'),
		('HDN08','NCC05','NV02','2023-06-15','2023-06-22'),
		('HDN09','NCC02','NV04','2023-07-03','2023-07-10'),
		('HDN10','NCC06','NV04','2023-07-03','2023-07-10'),
		('HDN11','NCC03','NV04','2023-07-03','2023-07-10'),
		('HDN12','NCC07','NV04','2023-07-03','2023-07-10'),
		('HDN13','NCC01','NV04','2023-07-03','2023-07-10'),
		('HDN14','NCC08','NV09','2023-07-16','2023-07-23')

INSERT INTO CHITIETHOADON(MaHD, MaSach, SoLuong, DonGia)
VALUES ('HD01','S02','2','100,000đ'),
		('HD02','S05','3','90,000đ'),
		('HD03','S01','1','100,00đ'),
		('HD04','S03','2','100,000đ'),
		('HD05','S02','2','100,000đ'),
		('HD06','S16','4','75,000đ'),
		('HD07','S04','3','130,000đ'),
		('HD08','S05','9','90,000đ'),
		('HD09','S13','3','175,000đ'),
		('HD10','S06','2','120,000đ'),
		('HD11','S10','4','100,000đ'),
		('HD12','S07','6','130,000đ'),
		('HD13','S10','4','100,000đ'),
		('HD14','S08','3','150,000đ')	

INSERT INTO CHITIETNHAP(MaHDN, MaSach, TenSach, SoLuong, DonGia)
VALUES ('HD01','S02',N'Làm bạn với bầu trời','2','100,000đ'),
		('HD02','S05',N'Kính Vạn Hoa','3','90,000đ'),
		('HD03','S01',N'Làm bạn với bầu trời','1','100,00đ'),
		('HD04','S03',N'Mắt biếc','2','100,000đ'),
		('HD05','S02',N'Làm bạn với bầu trời','2','100,000đ'),
		('HD06','S16',N'Con về','4','75,000đ'),
		('HD07','S04',N'Cô gái đến từ hôm qua','3','130,000đ'),
		('HD08','S05',N'Kính Vạn Hoa','9','90,000đ'),
		('HD09','S13',N'Chiếc Birkin màu cam','3','175,000đ'),
		('HD10','S06',N'Dế Mèn','2','120,000đ'),
		('HD11','S10',N'Một lít nước mắt','4','100,000đ'),
		('HD12','S07',N'Những ngày thơ ấu','6','130,000đ'),
		('HD13','S10',N'Một lít nước mắt','4','100,000đ'),
		('HD14','S08',N'Tủ sách tuổi thần tiên - giao thừa không đến muộn','3','150,000đ')	


-- Store procedure
-- Tìm sách qua tên tác giả
GO
CREATE PROCEDURE sp_TimSachBangTacGia @TenTacGia NVARCHAR(50)
AS
BEGIN
    SELECT *
    FROM SACH AS S
    INNER JOIN TACGIA AS TG ON S.MaTG = TG.MaTG
    WHERE TG.TenTG = @TenTacGia;
END

EXEC sp_TimSachBangTacGia N'Nguyễn Nhật Ánh'


-- Tìm sách qua thể loại
GO
CREATE PROCEDURE sp_TimSachBangTheLoai @TenTL NVARCHAR(50)
AS
BEGIN
    SELECT *
    FROM SACH AS S
    INNER JOIN THELOAI AS TL ON S.MaTL = TL.MaTL
    WHERE TL.TenTL = @TenTL;
END

EXEC sp_TimSachBangTheLoai N'Tiểu thuyết'


-- Cập nhập thông tin sách
GO
CREATE PROCEDURE sp_CapNhapSach
    @MaSach CHAR(10),
    @TenSachMoi NVARCHAR(50),
    @ChiTiet NVARCHAR(200),
    @Gia INT,
    @TinhTrang NVARCHAR(50)
AS
BEGIN
    UPDATE SACH
    SET TenSach = @TenSachMoi,
        ChiTiet = @ChiTiet,
        Gia = @Gia,
        TinhTrang = @TinhTrang 
    WHERE MaSach = @MaSach;
END


-- Thêm tác giả
GO
CREATE PROCEDURE sp_ThemTacGia	
    @MaTacGia NVARCHAR(10),
    @TenTacGia NVARCHAR(100),
    @NgaySinh DATE
AS
BEGIN
    INSERT INTO TacGia (MaTG, TenTG, NgaySinh)
    VALUES (@MaTacGia, @TenTacGia, @NgaySinh);
END;

EXEC sp_ThemTacGia @MaTacGia = 'TG001', @TenTacGia = 'Nguyễn Văn A', @NgaySinh = '2000-01-01';
