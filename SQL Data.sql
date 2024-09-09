create table Reserve ( 
ReserveID char(3),
ResReserveerveName varchar (40), 
ReserveLocation varchar (40),
ReserveSize varchar(3),
primary key (ReserveID));

create table Vehicle(
VehicleID char(2),
ReserveID char(2),
VehicleType varchar(20),
VehicleCapacity varchar(2),
VehicleRegoNum varchar(20),
primary key(VehicleID,ReserveID),
foreign key(ReserveID) references Reserve(ReserveID));

create table Tour (
TourID char(2),
TourName varchar(30),
TourCost decimal(5,2),
TourDuration char(1),
primary key (TourID));

create table Staff(
StaffID char(2),
StaffName varchar(20),
StaffPosition varchar(20),
StaffSalary decimal(8,2),
primary key (StaffID));

create table VisitorGroup(
VisGroupID char(3),
VisGroupName varchar(20),
VisGroupCountry varchar(20),
VisGroupNumPeople varchar(2),
primary key (VisGroupID));


create table Booking(
BookingID char(3),
TourID char(2),
VehicleID char(2),
ReserveID char(2),
VisGroupID char(3),
StaffID char(2),
BookingDate date,
BookingTime time,
primary key (BookingID),
foreign key (TourID) references Tour(TourID),
foreign key (VehicleID,ReserveID) references Vehicle(VehicleID,ReserveID),
foreign key (StaffID) references Staff(StaffID),
foreign key (VisGroupID) references VisitorGroup(VisGroupID));

-- Submit your insert value statements below:
-- inserting values for RESERVE 
insert into Reserve values ('R1','Dwesa-Cwebe Nature Reserve','Eastern Cape Province','545');
insert into Reserve values ('R2', 'Caledon Nature Reserve', 'Free State','230');
insert into Reserve values ('R3','Hluhluwe-Umfolozi Game Reserve','KwaZulu-Natal','960');
insert into Reserve values ('R4','Kruger National Park','Mpumalanga','999');
insert into Reserve values ('R5','De Hoop Nature Reserve','Overberg','340');
insert into Reserve values ('R6','Pilanesberg National Park','North West Province','572');
insert into Reserve values ('R7','Blyde River Canyon Nature Reserve','Mpumalanga','290');
-- inserting values for table VEHICLE 
insert into Vehicle values ('V1','R1','Bus','15','AVH287');
insert into Vehicle values ('V1','R2','Off-road 4WD','8','FNG552');
insert into Vehicle values ('V1','R3','Off-road 4WD','8','MQR858');
insert into Vehicle values ('V1','R4','Off-road 4WD','8','LMV199');
insert into Vehicle values ('V1','R5','Van','10','KEV022');
insert into Vehicle values ('V2','R1','Ute with cage','6','JQB042');
insert into Vehicle values ('V2','R3','Van','10','BGC222');
insert into Vehicle values ('V2','R4','Van','10','HTP587');
insert into Vehicle values ('V2','R5','Ute with cage','6','HMG835');
insert into Vehicle values ('V3','R3','Bus','15','ZZB964');
insert into Vehicle values ('V3','R4','Bus','15','UFB445');
-- inserting values for table TOUR
insert into Tour values ('T1','Premium Tour Package','500.00','6');
insert into Tour values ('T2','Standard Tour Package','420.00','5');
insert into Tour values ('T3','Whale Watching','200.00','3');
insert into Tour values ('T4','Hiking and Biking','150.00','1');
insert into Tour values ('T5','Safari','250.00','2');
insert into Tour values ('T6','Lake Cruise','300.00','2');
insert into Tour values ('T7','Shark Diving','250.00','2');
-- inserting values for Staff table 
insert into Staff values ('S1','Blake Lively','Reserve Manager','120000.00');
insert into Staff values ('S2','Heath Ledger','Tour Guide','70000.00');
insert into Staff values ('S3','Sheldon Cooper','Tour Guide','70000.00');
insert into Staff values ('S4','Jessica Chastain','Senior Tour Guide','80000.00');
insert into Staff values ('S5','Joaquin Phoenix','Junior Tour Guide','90000.00');
-- inserting values for VisitorGroup table 
insert into VisitorGroup values ('VG1', 'Hugh Jackman', 'Australia', 1);
insert into VisitorGroup values ('VG2', 'Zoe Bell', 'New Zealand', 7);
insert into VisitorGroup values ('VG3', 'Nicole Kidman', 'Australia', 5);
insert into VisitorGroup values ('VG4', 'Jackie Chan', 'Hong Kong', 8);
insert into VisitorGroup values ('VG5', 'Kim SooHyun', 'Korea', 14);
insert into VisitorGroup values ('VG6', 'Parkmin Young', 'Korea', 10);
insert into VisitorGroup values ('VG7', 'Maggie Cheung', 'Hong Kong', 3);
insert into VisitorGroup values ('VG8', 'JunJi Hyun', 'Korea', 6);
-- inserting values for Booking table 
Insert into Booking values('B01','T4','V1','R2','VG2','S3','2024-03-29','10:28:00');
Insert into Booking values('B02','T4','V2','R1','VG3','S3','2024-07-14','07:23:00');
Insert into Booking values('B03','T5','V2','R5','VG1','S4','2023-11-04','07:40:00');
Insert into Booking values('B04','T1','V2','R4','VG4','S5','2024-06-23','06:42:00');
Insert into Booking values('B05','T1','V3','R3','VG5','S2','2024-11-25','07:13:00');
Insert into Booking values('B06','T7','V2','R5','VG1','S3','2024-07-08','10:55:00');
Insert into Booking values('B07','T5','V1','R1','VG8','S3','2024-09-04','06:06:00');
Insert into Booking values('B08','T3','V1','R2','VG7','S4','2023-10-14','06:37:00');
Insert into Booking values('B09','T2','V3','R3','VG6','S5','2024-01-01','09:07:00');
Insert into Booking values('B10','T3','V1','R1','VG8','S2','2024-01-18','08:35:00');






