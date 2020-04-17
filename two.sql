USE master
GO
IF (EXISTS(SELECT * FROM sys.sysdatabases WHERE name='QuanLySinhVien'))
DROP DATABASE QuanLySinhVien
go
create database QuanLySinhVien;
GO

USE QuanLySinhVien
GO

create table sinhvien (
	masv char(4) primary key,
	hoten nvarchar(30) not null,
	dienthoai nvarchar(12) not null,
	diachi nvarchar(30) not null
)
go
create table monhoc (
	mamon char(4) primary key,
	tenmon nvarchar(30) not null,
	sotinchi int not null
)
go
create table ketqua (
	masv char(4),
	mamon char(4),
	diemthi float,
	constraint pk_diem primary key (masv, mamon),
	constraint fk_masv_diem foreign key (masv) references sinhvien(masv),
	constraint fk_mamon_diem foreign key (mamon) references monhoc(mamon)
)
go

-- cau 2: Nhap du lieu cho 3 bang tren
insert into sinhvien values ('sv01', 'tran ngoc luc','0123456', 'hanam')
insert into sinhvien values ('sv02', 'tran van b','0121212', 'hanam')
insert into sinhvien values ('sv03', N'Lê Ngọc Huyền','0212546', 'namdinh')

insert into monhoc values ('m001', 'lap trinh can ban', 2)
insert into monhoc values ('m002', N'Lập trình Windows', 3)
insert into monhoc values ('m003', N'Cơ sở dữ liệu', 2)

insert into ketqua values ('sv01', 'm002', 9)
insert into ketqua values ('sv02','m002', 4)
insert into ketqua values ('sv03', 'm003', 8)
insert into ketqua values ('sv03', 'm002', 9)

-- cau3



--cau 4: 
update monhoc
set sotinchi = 3
where tenmon = N'Cơ sở dữ liệu'

--Phan 2:
-- cau 1:
select hoten, tenmon, sotinchi, diemthi from sinhvien inner join ketqua on sinhvien.masv = ketqua.masv
										inner join monhoc on monhoc.mamon = ketqua.mamon
										where diemthi < 5





--cau 2:

select * from monhoc where sotinchi < (select sotinchi from monhoc where tenmon = N'Cơ sở dữ liệu')



--cau 3:

select masv, hoten from sinhvien where masv not in (select masv from ketqua 
										   where mamon = (select mamon from monhoc where tenmon = N'Cơ sở dữ liệu') )











--cau 4:
select * from sinhvien where masv = (select sinhvien.masv from sinhvien inner join ketqua on sinhvien.masv = ketqua.masv
			group by sinhvien.masv
			having count(*) >=2)
			 