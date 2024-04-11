create database qlibanhang;

create table Khach
(MaK char(5) not null,
TenK nchar(30),
diachi nchar(40),
dienthoai char(10),
constraint Khach_K primary key(MaK)
);
insert into Khach values('1',N'Hiếu',N'Hà Nội','0123');

create table Loaihang
(Maloai char(5) not null,
Tenloai nchar(30),
constraint LoaiH_K primary key(Maloai)
);
insert into Loaihang values('001', N'BIA 333');

create table Hang
(MaH char(5) not null,
TenH nchar(20),
Slton smallint,
Maloai char(5) foreign key references Loaihang(Maloai),
constraint Hang_K primary key(MaH)
);
insert into Hang values('12', N'BIA 333', 100, '001');

create table HoaDon
(SoHD char(10) not null,
ngayHD date,
constraint HoaDon_K primary key(SoHD),
MaK char(5) foreign key references Khach(MaK)
);

create table ChitietHD
(SoHD char(10) foreign key references HoaDon(SoHD),
MaH char(5) foreign key references Hang(MaH),
Slban smallint,
dgia money,
constraint ChitietHD_K primary key(SoHD,MaH)
);

select * from Loaihang;
insert into Loaihang values
('1', N'bàn chải');
insert into Hang values
('H2', N'Ma túy', 10, '1');

select * from Khach;
select * from Hang;
select * from HoaDon;
select * from ChitietHD;
insert into HoaDon(SoHD, ngayHD) values ('123', '2022/2/19');
insert into ChitietHD(SoHD,MaH,Slban,dgia) values ('123','H2', 50, 12500);
update Hang set TenH=N'Kem' where TenH=N'Ma túy';
-- xóa sản phẩm có lượng tồn >5000 và có mã loại là 1
insert into Loaihang values
('2', N'súng phun nước');
insert into Hang values
('H4', N'người yêu', 10000, '2');
delete from Hang where Slton>5000 and Maloai='2'

--btap
NHANVIEN(MANV,TENNV,LUONG,MAP)
1. cho biết lương cao nhất trong cty
2. cho biết p2 có bao nhiêu nhân viên
3. cho biết nhân viên có tên thu lương bn
4. cho biết tên nhân viên lương > 5000000
5. cho biết cty có bn nhân viên

select max(LUONG) from NHANVIEN;

select count(MaNV) from NHANVIEN;

select Luong from NHANVIEN where TenNV=N'Thu';

select TenNV from NHANVIEN where Luong>5000000;

select count(MaNV)*count(MaP) from Congty;
---
select TenK from Khach K, HoaDon HD where K.MaK=HD.MaK and year(ngayHD)=2020;

select TenK, TenH from HoaDon HD, ChitietHD CTHD, Khach K, Hang H where HD.SoHD=CTHD.SoHD and HD.MaK=K.MaK and CTHD.MaH=H.MaH;

select TenH from HoaDon HD, ChitietHD CTHD, Hang H where HD.SoHD=CTHD.SoHD and CTHD.MaH=H.MaH and ngayHD='2020/5/15';

select count(SoHD) as Solanmua from Khach K, HoaDon HD where K.MaK=HD.MaK and TenK=N'ĐỖ Mỹ Linh';

select TenK from Hang H, Khach K, ChitietHD CTHD, HoaDon HD, Loaihang LH 
where K.MaK=HD.MaK and HD.SoHD=CTHD.SoHD and CTHD.MaH=H.MaH and LH.Maloai=H.Maloai and Tenloai=N'kem';

select count(MaK) from Khach group by DiaChi;

select ngayHD, count(SoHD) as SoLuongHD from HoaDon group by NgayHD;

select ngayHD,sum(Slban) from ChitietHD CTHD, HoaDon HD where CTHD.SoHD=HD.SoHD group by NgayHD;

select DiaChi,count(MaK) as slk from Khach group by DiaChi having count(MaK)>2;

select MaK, sum(dgia*Slban) from HoaDon HD, ChitietHD CTHD where HD.SoHD=CTHD.SoHD group by MaK having sum(dgia*Slban)>10000;
---bt
--1.
select TenK from Khach K, HoaDon HD, ChitietHD CTHD, Hang H
where K.MaK=HD.MaK and HD.SoHD=CTHD.SoHD and CTHD.MaH=H.MaH and TenH=N'Bia 333';
--2.cho biết số đầu sản phẩm mỗi KH mua
select TenK, count(distinct CTHD.MaH) as Slmua from Khach K LEFT JOIN HoaDon HD ON K.MaK = HD.MaK
LEFT JOIN ChitietHD CTHD ON HD.SoHD = CTHD.SoHD group by TenK;
--3.cho biết số lượng hd bán ra trong tháng 5 năm 2020
select count(SoHD) as slhd from HoaDon 
where NgayHD>='2020-05-01' and NgayHD<='2020-05-31';
--4.cho bt doanh thu mỗi ngày
select NgayHD, sum(dgia) as doanhthu 
from HoaDon HD inner join ChitietHD CTHD on HD.SoHD=CTHD.SoHD group by NgayHD;
--5.cho biết ngày nào có doah thu >10000
select NgayHD, sum(dgia) as doanhthu 
from HoaDon HD inner join ChitietHD CTHD on HD.SoHD=CTHD.SoHD 
group by NgayHD having sum(dgia)>10000;
--6.cho biết mỗi ngày của hàng bán được bao nhiêu'sữa chua dâu'
select NgayHD, count(TenH) as slsuachua 
from HoaDon HD inner join ChitietHD CTHD on HD.SoHD=CTHD.SoHD inner join Hang H on CTHD.SoHD=H.MaH
where TenH=N'sữa chua dâu' group by NgayHD;

--Tên H có slton nhỏ nhất
select TenH from Hang where slton=(select min(slton) from Hang);
--tên nằm trong loại hàng kem
select TenH from Hang where Maloai=(select Maloai from Loaihang where Tenloai=N'Kem');
--tên K mua hàng vào năm 2020
select TenK from Khach where MaK in (select MaK from HoaDon where year(NgayHD)=2020);
--tên khách k mua hàng vào tháng 5, năm 2020
select TenK from Khach where MaK not in (select MaK from HoaDon 
where NgayHD>='2020/05/01' and NgayHD<='2020/05/31');
--TênH có tổng slban >100
select TenH from Hang 
where MaH in (select MaH from ChitietHD group by MaH having  sum(Slban)>100);
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