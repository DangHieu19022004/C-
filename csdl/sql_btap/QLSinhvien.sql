create database QLSinhvien;

create table KHOA
(Makh char(10) not null,
Vpkh char(20),
constraint KHOA_K primary key(Makh)
);

create table LOP
(Malop char(10) not null,
Makh char(10) foreign key references KHOA(Makh),
constraint LOP_K primary key(Malop)
);

create table SINHVIEN
(Masv char(10) not null,
Hosv nchar(20),
Tensv nchar(20),
Nssv date,
Dcsv nchar(30),

constraint SV_K primary key(Masv),
Malop char(10) foreign key references LOP(Malop)
);

drop table SINHVIEN;

create table MONHOC
(Mamh char(10) not null,
Tenmh nchar(30),
LT smallint,
TH smallint,
constraint MH_K primary key(Mamh)
);

create table CTHOC
(Malop char(10) foreign key references LOP(Malop),
HK char(2),
Mamh char(10) foreign key references MONHOC(Mamh),
constraint CTH_K primary key (Malop, Mamh)
);

create table DIEMSV
(Masv char(10) foreign key references SINHVIEN(Masv),
Mamh char(10) foreign key references MONHOC(Mamh),
Lan smallint,
Diem smallint,
constraint DIEMSV_K primary key(Masv, Mamh)
);

select * from KHOA;
select * from LOP; 
select * from MONHOC;
select * from CTHOC;

insert into KHOA(Makh, Vpkh) values('CNTT','A1');
insert into KHOA(Makh, Vpkh) values('KHMT','A2');
insert into KHOA(Makh, Vpkh) values('ANM','A3');

insert into LOP(Malop, Makh) values('TH1', 'CNTT');
insert into LOP(Malop, Makh) values('TH2', 'KHMT');
insert into LOP(Malop, Makh) values('TH3', 'ANM');

insert into MONHOC(Mamh, Tenmh, LT, TH) values('001',N'CSDL', 20, 30);
insert into MONHOC(Mamh, Tenmh, LT, TH) values('002',N'CNPM', 23, 28);
insert into MONHOC(Mamh, Tenmh, LT, TH) values('003',N'C++', 10, 25);

insert into CTHOC(Malop, HK, Mamh) values ('TH1','1','001');
insert into CTHOC(Malop, HK, Mamh) values ('TH2','2','002');
insert into CTHOC(Malop, HK, Mamh) values ('TH3','1','003');

insert into DIEMSV(Masv, Mamh, Lan, Diem) values();