create database QLNhanVien;

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
--xem ttin bang
select * from DONVI;
select * from NHANVIEN;
select * from BACLUONG;

alter table NHANVIEN alter column Gioitinh nchar(10);

---3. them du lieu NHANVIEN
insert into NHANVIEN(MaNV, HoTen, CongViec, Luong, MaDV, MaPT) 
values ('NV001', N'Phạm Thị Nhàn', N'Thư ký', 500, '0001', 'NV001');
insert into NHANVIEN(MaNV, HoTen, CongViec, Luong, MaDV, MaPT) 
values ('NV002', N'Hoàng Thanh Vân', N'Giáo viên', 600, '0001', 'NV001');
insert into NHANVIEN(MaNV, HoTen, CongViec, Luong, MaDV, MaPT) 
values ('NV003', N'Hoàng Thị Lan', N'Giáo viên', 200, '0002', 'NV003');
insert into NHANVIEN(MaNV, HoTen, CongViec, Luong, MaDV, MaPT) 
values ('NV004', N'Đỗ Trung Dũng', N'Thư ký', 700, '0003', 'NV004');

--4.them du lieu DONVI
insert into DONVI values ('0001', N'KHTN');
insert into DONVI values ('0002', N'DHTL');
insert into DONVI values ('0003', N'DHQG');

--5. them du lieu BACLUONG
insert into BACLUONG values ('1', 400, 500);
insert into BACLUONG values ('2', 501, 600);
insert into BACLUONG values ('3', 601, 800);

--6. truy vấn dữ liệu nhân viên
select * from NHANVIEN;

--7. Đưa ra họ tên, cv, lg của nvien
select HoTen, CongViec, Luong from NHANVIEN;

--8. đưa ra cviec của nvien, các gtri k trùng lặp
select distinct CongViec from NHANVIEN;

--9. đưa ra họ tên, lương quý các nhân viên, lương quý = luong*3
select HoTen, Luong*3 as LuongQuy from NHANVIEN;

--10. Đưa ra họ tên, Lương sắp xếp theo tăng dần, giảm dần của lương
	-- tăng dần
select HoTen, Luong from NHANVIEN order by Luong asc;
	-- giảm dần
select HoTen, Luong from NHANVIEN order by Luong desc;

--11. Đưa ra Hoten, Luong của các nhân viên có Luong>300. 
select HoTen, Luong from NHANVIEN where Luong>300;

--12.Đưa ra Hoten, Luong của các nhân viên có Luong>300 và làm công việc là Giáo viên
select HoTen, Luong from NHANVIEN where Luong>300 and CongViec=N'Giáo viên';

--13.Đưa ra những nhân viên có lương hoặc 200, 300, 600.
select * from NHANVIEN where Luong=200 or Luong=300 or Luong=600;

--14. Đưa ra những nhân viên có Lương trong khoảng 300 đến 600. 
select * from NHANVIEN where Luong>=300 and Luong<=600;

--15. Đưa ra Hoten, Congviec của các nhân viên có Họ tên bắt đầu bằng chữ ‘Hoàng’. select HoTen, CongViec from NHANVIEN where HoTen like N'Hoàng %';--16.Đưa ra lương trung bình, lương lớn nhất, nhỏ nhất của tất cả các nhân viên trong bảng NHANVIEN. 	--Luong trung binhselect AVG(Luong) as LuongTB from NHANVIEN;	--Luong lớn nhấtselect * from NHANVIEN where Luong=(select MAX(Luong) from NHANVIEN);
	--Luong nhỏ nhất
select * from NHANVIEN where Luong=(select MIN(Luong) from NHANVIEN);

--17.Đưa ra Côngviệc, Lương trung bình của từng loại công việc. 
select CongViec, AVG(Luong) as LuongTB from NHANVIEN group by CongViec;

--18.Đưa ra Côngviệc, Lương trung bình của tất cả các nhân viên có Luong>200 theo từng loại công việc.
select CongViec, AVG(Luong) as LuongTB from NHANVIEN where Luong >200 group by CongViec;

--19.Đưa ra tổng lương của từng nhóm công việc trong từng đơn vị. 
select MaDV, CongViec, SUM(Luong) as TongLuong from NHANVIEN group by CongViec,MaDV;

--20.Đưa ra những Congviec và trung bình lương của các công việc có trung bình lương >=300
select CongViec, AVG(Luong) as LuongTB from NHANVIEN group by CongViec having AVG(Luong)>=300;

--21.Đưa ra những đơn vị và lương lớn nhất của các đơn vị có lương lớn nhất >=300. select MaDV, MAX(Luong) as LuongmaxDV from NHANVIEN group by MaDV having MAX(Luong)>=300;--22.Đưa ra Hoten, Congviec, TenDV của tất cả nhân viên. select HoTen, CongViec, TenDV from NHANVIEN inner join DONVI on NHANVIEN.MaDV=DONVI.MaDV;--23.Lấy ra họ tên, công việc, tên đơn vị mà nhân viên đang làm--24.Đưa ra Hoten, Congviec, MaBac của tất cả nhân viênSelect hoten, congviec, mabac from nhanvien, bacluong where nhanvien.luong<=BACLUONG.baccao and nhanvien.luong>=bacluong.bacthap;--25.Đưa ra HoTen, Congviec, TenDV, Luong của những nhân viên có Luong>=500. select HoTen, CongViec, TenDV, Luong from NHANVIEN NV, DONVI DVwhere NV.MaDV=DV.MaDV and Luong>=500;--26. đưa ra mã nvien, họ tên, của những nhân viên phụ trách và những nvien thường--có lương cao hơn lương nhân viên phụ trách--27. Đưa ra những công việc trong đơn vị 1 có MaDV là 0001 và đơn vị 2 có MaDV là 0002. Select CongViec from nhanvien where MaDV='0001' 
intersect 
select CongViec from nhanvien where MaDV='0002';

--28. Đưa ra Hoten, TenDV, Congviec, Luong của những người có lương lớn hơn lương 
--trung bình của toàn bộ nhân viên.
select HoTen, TenDV, CongViec, Luong
from NHANVIEN NV, DONVI DV 
where NV.MaDV=DV.MaDV and Luong > (select AVG(Luong) from NHANVIEN);

--29.Đưa ra những nhân viên có lương lớn hơn người có lương lớn nhất 
--trong đơn vị có tên là DHTL. 
select HoTen from NHANVIEN NV, DONVI DV
where NV.MaDV = DV.MaDV and Luong > (
select max(Luong) from NHANVIEN NV, DONVI DV 
where NV.MaDV=DV.MaDV and TenDV=N'DHTL' );

--30.Đưa ra Hoten, MaDV, Luong của các nhân viên có 
--Luong=Luong thấp nhất trong đơn vị của họ. 
select HoTen, MaDV, Luong from NHANVIEN
where Luong in (
select MIN(Luong) from NHANVIEN
group by MaDV
);

--31.Đưa ra Hoten, MaDV, Luong của các nhân viên 
--có Luong=Luong thấp nhất trong một đơn vị nào đó. select HoTen, MaDV, Luong from NHANVIENwhere Luong = (select MIN(Luong) from NHANVIEN NV, DONVI DVwhere NV.MaDV=DV.MaDV and TenDV='DHTL');--32.Đưa ra Hoten, Luong của các nhân viên có 
--Luong lớn nhất của đơn vị có mã đơn vị là 0002select HoTen, Luong from NHANVIENwhere Luong in (select MAX(Luong) from NHANVIEN NV, DONVI DVwhere NV.MaDV=DV.MaDV and NV.MaDV='0002');--33.Đưa ra MaDV, AVG(Luong) của đơn vị có 
--trung bình lương lớn hơn lương nhỏ nhất của đơn vị có mã đơn vị là 0003
select NV.MaDV, AVG(Luong) as TBL from NHANVIEN NV, DONVI DV 
group by NV.MADV having AVG(Luong) > (
select MIN(Luong) from NHANVIEN where MaDV='0003'
);

--****---
select AVG(Luong) from NHANVIEN NV, DONVI DV where NV.MaDV=DV.MaDV;

select madv, AVG(luong) from NHANVIEN group by MaDV having avg(Luong) > (select avg(luong) from nhanvien);