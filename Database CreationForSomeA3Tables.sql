
--to create some tables of assignment 3


Drop TABLE AcquisitionRequest
Drop TABLE Reservations
Drop TABLE Loan
Drop TABLE Students
Drop TABLE Staffs
Drop TABLE Members
Drop TABLE Course_offering
Drop TABLE Privileges
Drop TABLE Moveable
Drop TABLE Immoveable
Drop TABLE Resources
Drop TABLE Category
Drop TABLE Locations
go

CREATE TABLE Category (
    category_code    VARCHAR(10) NOT NULL,
	name      VARCHAR(20),
    Descriptions  varchar(50),
	maxTime_borrow_book   INT   Not Null,

	PRIMARY KEY (category_code),
	);
go

CREATE TABLE Locations  (
    location_id     VARCHAR(20) NOT NULL,
	room      Varchar(20),
	building  Varchar(20),
	campus    Varchar(20),

	PRIMARY KEY (location_id),
	);
go


Create Table Resources(
    resource_id      VARCHAR (10) NOT NULL,
	description   VARCHAR(50) NOT NULL, 
	status        VARCHAR(20) DEFAULT 'available' CHECK (status IN ('available', 'occupied', 'damaged'))NOT NULL, 
	location_id		 VARCHAR(20),
	category_id      VARCHAR(10),	

	PRIMARY KEY (resource_id),
	FOREIGN KEY (category_id) REFERENCES Category(Category_code) ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (location_id) REFERENCES locations(Location_id)  ON UPDATE CASCADE ON DELETE NO ACTION 
	);

go

CREATE TABLE Moveable (
    resource_id      VARCHAR (10) NOT NULL,
	name            VARCHAR (20), 
	make          VARCHAR(10), 
	manufacturer  VARCHAR(30), 
	model         VARCHAR(30),
	year		DATETIME2,
	asset_value		VARCHAR(15),
    max_borrowing_time  INT,

	PRIMARY KEY (resource_id),
	FOREIGN KEY (resource_id) REFERENCES resources(resource_id) ON UPDATE CASCADE ON DELETE NO ACTION

	);
go

CREATE TABLE Immoveable (
    resource_id      VARCHAR (10) NOT NULL,
	name            VARCHAR (20), 
	capacity		INT,
    max_borrowing_time   INT,

	PRIMARY KEY (resource_id),
	FOREIGN KEY (resource_id) REFERENCES resources(resource_id) ON UPDATE CASCADE ON DELETE NO ACTION

	);
go


CREATE TABLE Members (
    member_id      VARCHAR(10) NOT NULL, 
	name          VARCHAR(20) NOT NULL, 
	address			VARCHAR(20),
	phone       INT,
	email         VARCHAR(20) NOT NULL, 
	status        VARCHAR(8) DEFAULT 'active' CHECK (Status IN ('active', 'expire')) NOT NULL, 
	comments_field	VARCHAR(20),

	PRIMARY KEY (member_id),
	);
go

CREATE TABLE Privileges (
	course_id	VARCHAR(10) NOT NULL,
	name          VARCHAR(20) NOT NULL, 
	description		VARCHAR(20),
	category_code	VARCHAR(10),
	max_resources	INT,

	PRIMARY KEY (course_id),
	FOREIGN KEY (category_code) REFERENCES Category(category_code) ON UPDATE CASCADE ON DELETE NO ACTION
	);
go


CREATE TABLE Course_offering (
    offering_id      VARCHAR(10) NOT NULL, 
	course_id	VARCHAR(10) NOT NULL,
	name          VARCHAR(20) NOT NULL, 
	semester_offered	INT,
	year_offered	DATE,
	date_begins	DATETIME2,
	date_ends	DATETIME2,

	PRIMARY KEY (offering_id),
	FOREIGN KEY (course_id) REFERENCES Privileges(course_id) ON UPDATE CASCADE ON DELETE NO ACTION
	);
go


CREATE TABLE Students (
    member_id        VARCHAR(10) NOT NULL, 
	offering_id		VARCHAR(10) NOT NULL,
	points        INT,

	PRIMARY KEY (member_id),
	Foreign Key (member_id) references Members(member_id) On Update Cascade On Delete NO ACTION,
	Foreign Key (offering_id) references Course_offering(offering_id) On Update Cascade On Delete NO ACTION
	);
go

CREATE TABLE Staffs (
    member_id        VARCHAR(10) NOT NULL, 
	number_items	INT NOT NULL,

	PRIMARY KEY (member_id),
	Foreign Key (member_id) references Members(member_id) On Update Cascade On Delete NO ACTION
	);
go


CREATE TABLE Loan (
    member_id        VARCHAR(10) NOT NULL,
	resource_id       VARCHAR(10) NOT NULL,
    dateTimeLoaned DATE NOT NULL, 	
	dateTimeDue      DATE NOT NULL,
	dateReturned DATE,

	PRIMARY KEY (dateTimeLoaned),
	FOREIGN KEY (member_id) REFERENCES Members ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (resource_id) REFERENCES Moveable ON UPDATE CASCADE ON DELETE NO ACTION,
    );
go

CREATE TABLE Reservations (
    member_id        VARCHAR(10) NOT NULL,
	resource_id       VARCHAR(10) NOT NULL,
    dateTimeRequested DATETIME NOT NULL, 	
	dateTimeDue      DATETIME NOT NULL,

	PRIMARY KEY (dateTimeRequested),
	FOREIGN KEY (member_id) REFERENCES Members ON UPDATE CASCADE ON DELETE NO ACTION,
	FOREIGN KEY (resource_id) REFERENCES Resources ON UPDATE CASCADE ON DELETE NO ACTION,
    );
go

CREATE TABLE AcquisitionRequest (
	acquisitiion_id		VARCHAR(10) NOT NULL,
    member_id        VARCHAR(10) NOT NULL,
	itemName	VARCHAR(20) NOT NULL,
	make		VARCHAR(15) NOT NULL,
	manufacturer	VARCHAR(20) NOT NULL,
	model		VARCHAR(20),
	year		DATETIME2,
	description		VARCHAR(20),
	urgency		VARCHAR(15),
	admin_note	VARCHAR(20),

	PRIMARY KEY (acquisitiion_id),
	FOREIGN KEY (member_id) REFERENCES Members ON UPDATE CASCADE ON DELETE NO ACTION
    );
go




--Data creation


INSERT INTO locations VALUES 
('Robotics Lab','101','ES','Callaghan'),
('AC Storage' ,'102','CT','Callaghan'),
('Optical Store','103','ICT','Callaghan')

go

INSERT INTO Category VALUES
('C1','MATH2001','math','7'),
('C2' ,'COMP2002','computer','14'),
('C3','CIVL2003','civil','5'),
('C4','camera','computer','14')

go

INSERT INTO Resources VALUES 
('MR00001', 'bluetooth 50W speaker ','available','Robotics Lab','C2'),
('MR00002', 'wireless speaker','available','AC Storage','C1'),
('MR00003', 'high-end headphone','available','Optical Store','C3'),
('MR00004', 'high-end camera','available','Optical Store','C4'),
('R001', 'Lab','available','Robotics Lab','C3'),
('R002', 'Lecture','available','Robotics Lab','C2'),
('R003', 'Libary','available','Robotics Lab','C1')
go

INSERT INTO Moveable VALUES 
('MR00001','50W speaker','A','SONY','SX11','2020','$97','7'),
('MR00002','speaker','B','Philips','WE69','2009','$34','5'),
('MR00003','headphone','A','Philips','HD380','2019','$189','4'),
('MR00004','camera','B','cannon','HD1080','2020','$300','2')
go



INSERT INTO Immoveable VALUES 
('R001','Lab','30','4'),
('R002','Lecture','200','5'),
('R003','Libary','120','2')

go


INSERT INTO Privileges VALUES 
('SENG1050','Data Structure','IT','C2','5'),
('MATH2050','Math Advance','civil enginnering','C3','10'),
('COMP1140','Data Management','Software enginnering','C4','20')

go

INSERT INTO Course_offering VALUES 
('S2018','SENG1050','IT','1','2018','2018-09-01','2022-06-01'),
('S2019','MATH2050','civil enginnering','2','2019','2019-09-01','2023-06-01'),
('S2020','COMP1140','Software enginnering','2','2020','2020-09-01','2024-06-01')

go


INSERT INTO Members VALUES 
 ('M009', 'Sophia S','Waterside Dr',0408888331,'11111@gmail.com','active','fees paid'),
 ('M010', 'Aiyana H','City Dr',0406666331,'2222222@gmail.com', 'active','fees paid'),
 ('M011', 'Oliver Z','Wallsend Dr',0405555331,'33333@gmail.com','active','fees paid'),
 ('M012', 'John A','Wallsend Dr',0405555331,'33333@gmail.com','active','fees paid'),
 ('M013', 'George B','Wallsend Dr',0405555331,'33333@gmail.com','active','fees paid'),
 ('M014', 'Shandra C','Wallsend Dr',0405555331,'33333@gmail.com','active','fees paid')

 go

INSERT INTO Staffs VALUES
 ('M009', 12),
 ('M010', 0),
 ('M011', 8)

 go
 

 INSERT INTO Students VALUES
 ('M012', 'S2018','8'),
 ('M013', 'S2019','6'),
 ('M014', 'S2020','10')

 go


 INSERT INTO Loan VALUES
 ('M012', 'MR00001','2019-05-25','2019-06-02', '2019-06-01'),
 ('M012', 'MR00001','2020-01-01','2020-01-03', '2020-01-03'),

 ('M013', 'MR00003','2020-02-20','2020-02-24', '2020-02-22'), 
 ('M013', 'MR00003','2020-11-01','2020-11-05', '2020-11-04'),

 ('M014', 'MR00004','2019-03-01','2019-03-05', '2019-03-05'),
 ('M014', 'MR00004','2020-11-02','2020-11-04', '2020-11-03'),
 ('M014', 'MR00004','2020-11-03','2020-1-05','2020-11-04')
 go




INSERT INTO Reservations VALUES ('M011','R003','2019-07-02 08:00:00','2019-07-06 10:00:00');

INSERT INTO Reservations VALUES ('M009','R001','2020-05-01 08:00:00','2019-05-01 12:00:00');

INSERT INTO Reservations VALUES ('M009','R002','2020-06-05 08:00:00','2019-06-10 13:00:00');

INSERT INTO Reservations VALUES ('M010','R002','2020-09-19 08:00:00','2020-09-19 13:00:00');
INSERT INTO Reservations VALUES ('M011','R003','2020-09-19 08:00:00','2020-09-19 10:00:00');
INSERT INTO Reservations VALUES ('M011','R003','2020-09-19 10:00:00','2020-09-19 12:00:00');


INSERT INTO AcquisitionRequest VALUES
('a001','M009','Lab Top','2018','Sony','VS888','2018-05-14 14:00:00','color: black','very','approved'),
('a002','M010','keyboard','2019','Sony','SE888','2019-05-14 15:30:00','color: red','very','approved'),
('a003','M010','monitor','2020','Sony','FE888','2020-05-14 10:10:00','color: blue','very','approved'),
('a004','M011','PHONE','2020','iphone','12 pro','2020-05-14 11:10:00','color: blue','very','approved'),
('a005','M011','PHONE2','2020','iphone','11 pro','2020-05-14 12:10:00','color: yellow','very','approved')
go

DELETE FROM Locations
DELETE FROM Category
DELETE FROM Resources
DELETE FROM Moveable
DELETE FROM Immoveable
DELETE FROM Privileges
DELETE FROM Course_offering
DELETE FROM Members
DELETE FROM Staffs
DELETE FROM Students
DELETE FROM Loan
DELETE FROM Reservations
DELETE FROM AcquisitionRequest



SELECT* FROM Locations
SELECT* FROM Category
SELECT* FROM Resources
SELECT* FROM Moveable
SELECT* FROM Immoveable
SELECT* FROM Privileges
SELECT* FROM Course_offering
SELECT* FROM Members
SELECT* FROM Staffs
SELECT* FROM Students
SELECT* FROM Loan
SELECT* FROM Reservations
SELECT* FROM AcquisitionRequest



---Q1: Print the name of student(s) who has/have enrolled in the course with course id xxx.


SELECT s.member_id, m.name, c.course_id
FROM Members m,Students s, Course_offering c 
WHERE m.member_id = s.member_id AND s.offering_id = c.offering_id

--Q2: Print the maximal number of speakers that the student with name xxx can borrow.

SELECT m.name, MAX(p.max_resources) AS maximal_number_of_speakers 
FROM Members m,Students s, Course_offering c , Privileges p,Category ca, Resources r
WHERE m.member_id = s.member_id AND s.offering_id = c.offering_id AND c.course_id = p.course_id AND p.category_code = ca.category_code AND ca.category_code = r.category_id 
AND r.description LIKE '%speaker%'
GROUP BY m.name


--Q3: For a staff member with id number xxx, print his/her name and phone number, the total
--number of acquisition requests and the total number of reservations that the staff had
--made in 2019.


SELECT m.member_id, m.name,m.phone,COUNT(DISTINCT a.acquisitiion_id) AS total_AcquisitionRequest, COUNT(DISTINCT r.dateTimeRequested) AS total_AcquisitionRequest
FROM Members m, Staffs st, AcquisitionRequest a,Reservations r
WHERE m.member_id = st.member_id AND st.member_id = a.member_id AND a.member_id = r.member_id AND r.dateTimeRequested LIKE '%2019%'
GROUP BY m.member_id, m.name,m.phone


--Q4: Print the name(s) of the student member(s) who has/have borrowed the category with
--the name of camera, of which the model is xxx, in this year. Note: camera is a category,
--and model attribute must be in movable table.

SELECT m.name, ca.name,mo.model,L.dateTimeLoaned
FROM Members m,Students s,Course_offering c, Privileges p, Category ca, Resources r ,Moveable mo, Loan l
WHERE m.member_id = s.member_id AND s.offering_id = c.offering_id AND c.course_id = p.course_id AND p.category_code = ca.category_code 
AND ca.category_code = r.category_id AND r.resource_id = mo.resource_id AND mo.resource_id = l.resource_id AND ca.name LIKE '%camera%'
AND l.dateTimeLoaned LIKE '%2020%'


--Q5: Find the moveable resource that is the mostly loaned in the current month. Print the
--resource id and resource name.

SELECT l.resource_id,m.name, COUNT(*) AS mostly_loaned_current_month
FROM Loan l, Moveable m
WHERE l.resource_id = m.resource_id AND l.dateTimeLoaned  BETWEEN '2020-11-01' AND '2020-11-30'
GROUP BY l.resource_id,m.name

HAVING COUNT(m.resource_id)>=
		ALL (SELECT COUNT(*)
		FROM Loan l, Moveable m 
		WHERE l.resource_id = m.resource_id AND l.dateTimeLoaned  BETWEEN '2020-11-01' AND '2020-11-30'
		GROUP BY l.resource_id,m.name)

--Q6: For each of the three days, including May 1, 2020, June 5, 2020 and September 19,
--2020, print the date, the name of the room with name xxx, and the total number of
--reservations made for the room on each day.



SELECT  
	 r.dateTimeRequested,
	i.name,
	COUNT(CASE WHEN r.dateTimeRequested BETWEEN '2020-09-19 00:00:00' AND '2020-09-19 23:00:00' then 1 ELSE NULL END) as '2020-09-19',
	COUNT(CASE WHEN r.dateTimeRequested BETWEEN '2020-06-05 00:00:00' AND '2020-06-05 23:00:00' then 1 ELSE NULL END) as '2020-06-05',
	COUNT(CASE WHEN r.dateTimeRequested BETWEEN '2020-05-01 00:00:00' AND '2020-05-01 23:00:00' then 1 ELSE NULL END) as '2020-05-01'
	
FROM Reservations r, Immoveable i
WHERE r.resource_id = i.resource_id and ((r.dateTimeRequested BETWEEN '2020-09-19 00:00:00' AND '2020-09-19 23:00:00')
or ((r.dateTimeRequested BETWEEN '2020-06-05 00:00:00' AND '2020-06-05 23:00:00')or (r.dateTimeRequested BETWEEN '2020-05-01 00:00:00' AND '2020-05-01 23:00:00')))
GROUP BY r.dateTimeRequested,i.name 





