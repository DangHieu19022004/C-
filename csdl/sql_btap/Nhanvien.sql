create database NhanVien;

create table NhanVien
(MaNV char(5) not null,
Ho nchar(10),
Hodem nchar(10),
Ten nchar(10),
NgaySinh date,
Diachi nchar(40),
Gioitinh nchar(10),
Luong money,
constraint NhanVien_K primary key(MaNV)
);

create table Phongban
(MaPhong char(5) not null,
TenPhong nchar(10),
NgayBDQL date,
MaNQL char(5) foreign key references NhanVien(MaNV),
constraint Phongban_K primary key(MaPhong)
);

alter table NhanVien add constraint QL_K foreign key(MaNV) references NhanVien(MaNV);
alter table NhanVien add MaPhong char(5);
alter table NhanVien add constraint MP_K foreign key(MaPhong) references Phongban(MaPhong);

create table Phong_Diachi
(MaPhong char(5) foreign key references Phongban(MaPhong),
Diachi nchar(40)
);

create table DuAn
(MaDA char(5) not null,
TenDA nchar(30),
DiachiDA nchar(40),
MaPhong char(5) foreign key references Phongban(MaPhong)
);

alter table DuAn add constraint DA_K primary key(MaDA);

create table NV_DA
(MaNV char(5) foreign key references NhanVien(MaNV),
MaDA char(5) foreign key references DuAn(MaDA),
SoGio smallint
);

create table NguoiPT
(MaNV char(5) foreign key references NhanVien(MaNV),
TenNPT nchar(20),
GioitinhNPT nchar(10),
Nsinh char(4),
Moiquanhe nchar(10)
);
