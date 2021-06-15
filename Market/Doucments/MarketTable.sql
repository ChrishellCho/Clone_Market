-- Use Market
-- Go

--[1] Category 
CREATE TABLE Categories
(
	CategoryID Int Identity(1,1) Not Null Primary Key,
	CategoryName VarChar(50),

	SuperCategory Int Null,
	--References Categories(CategoryID),
	Align SmallInt Default(0)
)
GO


Insert Into Categories Values('데스크톱', 1, 0)
Go
Insert Into Categories Values('노트북', 1, 1)
Go
Insert Into Categories Values('삼성', 5, 0)
Go
Insert Into Categories Values('LG', 5, 1)
Go

--Category 출력
Select * From Categories Order by CategoryID DESC
GO

--대분류 출력
Select CategoryID, CategoryName From Categories Where SuperCategory Is Null
Go


--[2] 상품
Create Table Products
(
	ProductID Int Identity(1,1) Not Null Primary Key,
	CategoryID Int Not Null,
	ModelNumber VarChar(50),
	ModelName VarChar(50),
	Company VarChar(50),
	OriginPrice Int,
	SellPrice Int,
	EventName VarChar(50),

	ProductImage VarChar(50),
	Explain VarChar(400),
	[Description] Text,
	Encoding VarChar(10),
	ProductCount Int Default(0),
	RegistDate DateTime Default(GetDate()),
	Mileage Int,
	Absence Int
)
Go

Alter Table Products
Add Foreign Key(CategoryID) References Categories(CategoryID)
Go

Insert Into Products Values (1, 'COM-01', '좋은컴퓨터', '우리집', 10000, 8000, 
'NEW', 'COM-01.JPG', '좋은컴퓨터입니다.', '좋은컴퓨터입니다...', 'Text', 100, GetDate(), 0, 0)
Go
Insert Into Products Values (2, 'BOOK-01', '좋은컴퓨터', '우리집', 10000, 8000, 
'HIT', 'BOOK-01.JPG', '좋은컴퓨터입니다.', '좋은컴퓨터입니다...', 'Text', 100, GetDate(), 0, 0)
Go
Insert Into Products Values (3, 'SOFTWARE-01', '좋은컴퓨터', '우리집', 10000, 8000, 
'BEST', 'SOFTWARE-01.JPG', '좋은컴퓨터입니다.', '좋은컴퓨터입니다...', 'Text', 100, GetDate(), 0, 0)
Go

Select * From Products
Go

--[3] 상품평
Create Table Reviews
(
	ReviewID Int Identity(1,1) Not Null,
	ProductID Int Not Null,
	CustomerName VarChar(50),
	CustomerEmail VarChar(50),
	Rating TinyInt Not Null,
	Comments VarChar(3850),
	AddDate SmallDateTime Default(GetDate()),
	Foreign Key(ProductID) References Products(ProductID),
	Primary Key (ReviewID, ProductID)
)
Go

--[4] 장바구니
Create Table ShoppingCart
(
	RecordID Int Identity(1,1) Primary Key Not Null,
	CartID VarChar(50),
	ProductID Int Not Null References Products(ProductID),
	Quantity Int Not Null,
	DateCreated DateTime Default(GetDate())
)
Go

--[5] 고객 : 회원 또는 비회원 중 물품을 구매한 사람
Create Table Customers
(
	CustomerID Int Identity(1,1) Primary Key,
	CustomerName Varchar(50),
	Phone1 VarChar(4),
	Phone2 VarChar(4),
	Phone3 VarChar(4),
	Mobile1 VarChar(4),
	Mobile2 VarChar(4),
	Mobile3 VarChar(4),
	Zip VarChar(7),					--우편번호
	[Address] VarChar(100),
	AddressDetail VarChar(100),
	Ssn1 Char(6),				--주민번호 앞자리
	Ssn2 Char(7),				--주민번호 뒷자리
	EmailAddress VarChar(50),
	MemberDivision Int
)
Go

--[6] 회원 : 회원 가입을 해야만 현재 테이블에 데이터 기록됨
Create Table MemberShip
(
	CustomerID Int Primary Key,
	UserID VarChar(25) Not Null,
	[Password] VarChar(100) Not Null,
	BirthYear VarChar(4),
	BirthMonth VarChar(2),
	BirthDay VarChar(2),
	BirthStatus VarChar(2),
	Gender Int,
	Job VarChar(20),
	Wedding Int,
	Hobby VarChar(100),
	Homepage VarChar(100),
	Intro VarChar(400),
	Mailing Int,
	VisitCount Int Default 0,
	LastVisit DateTime Default GetDate(),
	Mileage Int,
	JoinDate DateTime Default GetDate()
)
Go

--[7] 우편번호
Create Table Zip
(
	ZipCode NVarChar(8) Not Null,
	Si NVarChar(150),
	Gu NVarChar(150),
	Dong NVarChar(255),
	PostEtc NVarChar(255)
)
Go