-- thêm 1 bộ mới vào bảng
Khach (MaK, tenk, diachi, dthoai, ghichu)
insert into  khach values
('K7', N'hiếu', N'nam dinh', '0123', null)
-- N là nchar

--xem ttin bang
select * from <tên bảng>

insert into Khach(Mak,tenk) values ('a1', N'Hiếu')

--cập nhật(sửa đổi) các bộ trong bảng

update <tên bảng> set <tên bảng>=<NDung mới> where <tên bảng>=<ND cũ>

update Khach set tenk=N'Loan' where tenk=N'Hiếu';

-- xóa bộ

delete from Khach; -- xóa tất cả các bộ trong bảng khách
delete from Khach where diachi=N'Hà Nội' -- chỉ xóa bảng ghi có địa chỉ HN

--truy vấn dữ liệu
select Mak, tenk from khach;
--cho biết mã và tên của khách sống tại Hà Nội
select mak, tenk from khach where diachi=N'Hà Nội'
-- toán tử % thay thế cho 1 dãy ký tự không xác định
select sdt from khach where tenk=N'%Linh'
-- xem ttin, loại ptu lặp
select distinct diachi from khach;
-- as: đặt tên mới cho khách
select tenk as hotenkhachhang from khach
--lấy ra n bản ghi đầu tiên
select top 5 mak from khach
max,min, aug(tbc)
--cho biết giá bán cao nhất của sản phẩm
select max(dongia) from chitietHD;
count: đếm số lượng
-- cho biết cửa hàng hiện đang bán bao nhiêu đầu sản phẩm
select count(Mah) from Hang
sum: tính tổng
select sum(slton) from Hang

--- cho biết tên h, tên loại của mỗi mặt hàng
select TENH, TENLOAI from Hang H, LoaiHang LH where H.MaLoai=LH.MaLoai;
---hoặc
select TENH, TENLOAI from Hang H inner join LoaiHang LH on H.MaLoai==LH.MaLoai;

---cho biết tên khách mua hàng vào năm 2020
select TenK from Khach K, HoaDon HD where K.MaK=HD.MaK and year(ngayHD)=2020;

---cho biết khách hàng nào đã mua sản phẩm nào(mak, mah)
select MaK, MaH from HoaDon HD, ChitietHD CTHD where HD.SoHD=CTHD.SoHD;

---cho biết khách hàng nào đã mua sản phẩm nào(tenk, tenh)
select TenK, TenH from HoaDon HD, ChitietHD CTHD, Khach K, Hang H where HD.SoHD=CTHD.SoHD and HD.MaK=K.MaK and CTHD.MaH=H.MaH;

---cho biết tên sản phẩm bán ra vào ngày 15/5/2020
select TenH from HoaDon HD, ChitietHD CTHD, Hang H where HD.SoHD=CTHD.SoHD and CTHD.MaH=H.MaH and ngayHD='2020/5/15';

---cho biết đỗ mý linh đã mua bao nhiêu hóa đơn
select count(SoHD) as Solanmua from Khach K, HoaDon HD where K.MaK=HD.MaK and TenK=N'ĐỖ Mỹ Linh';

-- cho biết loại hàng kem đã được những khách hàng nào mua(tenk)
select TenK from Hang H, Khach K, ChitietHD CTHD, HoaDon HD, Loaihang LH where K.MaK=HD.MaK and HD.SoHD=CTHD.SoHD and CTHD.MaH=H.MaH and LH.Maloai=H.Maloai and Tenloai=N'kem';

-- cho biết số lượng khách hàng trong từng thành phố
group by -- gộp nhóm, ví dụ:
select count(MaK) from Khach group by DiaChi;

--cho biết số lượng HD bán ra trong mỗi ngày
select ngayHD, count(SoHD) as SoLuongHD from HoaDon group by NgayHD;

--cho biết mỗi ngày cửa hàng bán ra bao nhiêu sp
select ngayHD,sum(Slban) from ChitietHD CTHD, HoaDon HD where CTHD.SoHD=HD.SoHD group by NgayHD;

--groupby + having(điều kiện lọc sau khi gom nhóm - chỉ lọc ra nhwug nhóm t/m đk having)
--cho biết những tp có số khách >2
select count(MaK) as slk from Khach group by DiaChi having count(MaK)>2;

--cho biết KH nào tiêu>10000
select MaK, sum(dgia*Slban) from HoaDon HD, ChitietHD CTHD where HD.SoHD=CTHD.SoHD group by MaK having sum(dgia*Slban)>10000;

--1.cho biết tên KH đã mua 'BIA 333'
--2.cho biết số đầu sản phẩm mỗi KH mua
--3. cho biết số lượng hd bán ra trong tháng 5 năm 2020
--4. cho bt doanh thu mỗi ngày
--5.cho biết ngày nào có doah thu >10000
--6. cho biết mỗi ngày của hàng bán được bao nhiêu'sữa chua dâu'


--------
--truy vấn lồng nhau

select con được thực hiện trc
kết quả của select con dùng để phục vụ select cha bên ngoài
--Tên H có slton lớn nhất
select TenH from Hang where slton=(select max(slton) from Hang);
--Tên H có slton nhỏ nhất
select TenH from Hang where slton=(select min(slton) from Hang);
--tên nằm trong loại hàng kem
select TenH from Hang where Maloai=(select Maloai from Loaihang where Tenloai=N'Kem');
--tên K mua hàng vào năm 2020
select TenK from Khach where MaK in (select MaK from HoaDon where year(NgayHD)=2020);
in : là 1 trong số các giá trị trong tập giá trị
= any : bằng 1 trong những giá trị bất kì. any luôn đi với các phép so sánh như =any, >any,...
some : 1 vài
>=all <=all : tìm các giá trị lớn/nhỏ hơn tất cả
--tên khách k mua hàng vào tháng 5, năm 2020
select TenK from Khach where MaK not in (select MaK from HoaDon 
where NgayHD>='2020/05/01' and NgayHD<='2020/05/31'); -- có cách khác là dùng minus
--TênH có tổng slban >100
select TenH from Hang 
where MaH in (select MaH as tongslban from ChitietHD group by MaH having  sum(Slban)>100);
-- mah có tổng slban > slban sữa chua dâu
select MaH from ChitietHD group by MaH
having sum(SLban) > (select sum(Slban) from ChitietHD 
where MaH = (select MaH from Hang where TenH=N'Sữa Chua Dâu'));
--cho biết mã h có tổng slban lớn nhất
select MaH,sum(Slban) from ChitietHD group by MaH
having sum(Slban) >=all(select sum(Slban) from ChitietHD group by MaH);
--cho biết tên khách có số lần mua hàng nhiều nhất
select TenK from Khach 
where MaK in (select MaK from HoaDon group by MaK having count(SoHD) >=all 
(select count(SoHD) from HoaDon group by MaK));

--****---
Nhanvien(MaNV, Hoten, Luong, Gioiinh, MaPt,MaDA)
DonVi(MaDV, TenDV)
1. tên của dv có số nv nữ > số nv  nữ của 'DHTL'
2. tên dv có lương trung bình cao nhất
3. tên nv làm cùng đvi vs phạm thị nhàn
4. tên ĐV có đông nvien nhất

create table DONVI
(MaDV char(4) not null,
TenDV nchar(50),
constraint DV_K primary key(MaDV)
);

create table NHANVIEN
(MaNV char(8) not null,
HoTen nchar(30),
CongViec nchar(50),
Luong money,
MaDV char(4) foreign key references DONVI(MaDV),
MaPT char(8),
constraint NV_K primary key(MaNV)
);

alter table NHANVIEN add constraint NV_K_P foreign key(MaPT) references NHANVIEN(MaNV);

create table BACLUONG
(MaBac char(50) not null,
BacThap smallint,
BacCao smallint,
constraint BL_K primary key(MaBac)
);
---***-----1.select count(MaNV) from NHANVIEN where Gioitinh=N'Nữ' group by MaDV having count(MaNV) > (select count(MaNV) from NHANVIEN where Gioitinh=N'Nữ' and MaDV = (select MaDV from DONVI where TenDV='DHTL'));-----c5phụ thuộc hàm-phụ thuộc hàm : là 1 hàm F có dạng X->Y-biểu diễn X xác định Y hay Y phụ thuộc X	vd: Sinhvien(Masv, TenSV, SoDT, Diachi)		F1: {Masv} -> {tensv, sodt, diachi}		F2: {sodt}->{masv,tensv,diachi}Để xác định phụ thuộc hàm, cần căn cứ vào các ràng buộc(constraint-là những quy tắc quản lý)Ràng buộc 1: nếu như bt đc mã sv thì sẽ bt tên, tuổi, địa chỉRB2: khi svien thi 1 môn học thì phải lưu điểm{masv, mamh}->{điểm} Phụ thuộc hàng hiển nhiên: X->Y	ABC->{A,B,C,AB,AC,BC,ABC}phụ thuộc hàm nguyên tố X->Y là PTH nguyên tố khi k tồn tại X'->Y----------'	R(A1,A2,A3,A4,A5)	F1:{A1,A2,A3}->A5: k phải là phụ thuộc hàm nguyên tố vì có {A2,A3}->A5	F2:{A2, A5}->A4:là phụ thuộc hàm nguyên tố	F3:{A2,A5}->A5:là phụ thuộc hàm nguyên tố	---Hệ tiên đề amstrong---1. tính phản xạ: Nếu Y _C X thì --> X->Y2. bt: R(A,B,C,D,E,G,H)	F={AB->C,B->D,CD->E,CE->GH,G->A}			CMR: AB->E		AB->C => AB-> CB(TC GIA TĂNG)	B->D => CB->CD (TC GIA TĂNG) 	=> AB->CD(TC BẮC CẦU)	CÓ CD->E 	=> AB -> E (TC BẮC CẦU)	VDSLIDE:	GI->H => GI ->GH (TC GIA TĂNG)	E->G => EI ->GI (TC GIA TĂNG)	=> EI -> GH (TC BẮC CẦU)	BE->I => BE->EI(TC GIA TĂNG)	=> BE->GH(TC BẮC CẦU)	AB->E => AB->BE (TC GIA TĂNG)	=> AB ->GH(TC BẮC CẦU)