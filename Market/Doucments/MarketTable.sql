-- Use Market
-- Go

--[1] Category 
CREATE TABLE Categories
(
	CategoryID Int Identity(1,1) Not Null Primary Key,
	CategoryName VarChar(50),

	SuperCategory Int Null References Categories(CategoryID),
	Align SmallInt Default(0)
)
GO


Insert Into Categories Values('����ũ��', 1, 0)
Go
Insert Into Categories Values('��Ʈ��', 1, 1)
Go
Insert Into Categories Values('�Ｚ', 5, 0)
Go
Insert Into Categories Values('LG', 5, 1)
Go

--Category ���
Select * From Categories Order by CategoryID DESC
GO

--��з� ���
Select CategoryID, CategoryName From Categories Where SuperCategory Is Null
Go


--[2] ��ǰ
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

Insert Into Products Values (1, 'COM-01', '������ǻ��', '�츮��', 10000, 8000, 
'NEW', 'COM-01.JPG', '������ǻ���Դϴ�.', '������ǻ���Դϴ�...', 'Text', 100, GetDate(), 0, 0)
Go
Insert Into Products Values (2, 'BOOK-01', '������ǻ��', '�츮��', 10000, 8000, 
'HIT', 'BOOK-01.JPG', '������ǻ���Դϴ�.', '������ǻ���Դϴ�...', 'Text', 100, GetDate(), 0, 0)
Go
Insert Into Products Values (3, 'SOFTWARE-01', '������ǻ��', '�츮��', 10000, 8000, 
'BEST', 'SOFTWARE-01.JPG', '������ǻ���Դϴ�.', '������ǻ���Դϴ�...', 'Text', 100, GetDate(), 0, 0)
Go

Select * From Products
Go

--[3] ��ǰ��
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

--[4] ��ٱ���
Create Table ShoppingCart
(
	RecordID Int Identity(1,1) Primary Key Not Null,
	CartID VarChar(50),
	ProductID Int Not Null References Products(ProductID),
	Quantity Int Not Null,
	DateCreated DateTime Default(GetDate())
)
Go

--[5] �� : ȸ�� �Ǵ� ��ȸ�� �� ��ǰ�� ������ ���
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
	Zip VarChar(7),					--�����ȣ
	[Address] VarChar(100),
	AddressDetail VarChar(100),
	Ssn1 Char(6),				--�ֹι�ȣ ���ڸ�
	Ssn2 Char(7),				--�ֹι�ȣ ���ڸ�
	EmailAddress VarChar(50),
	MemberDivision Int
)
Go

--[6] ȸ�� : ȸ�� ������ �ؾ߸� ���� ���̺� ������ ��ϵ�
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

--[7] �����ȣ
Create Table Zip
(
	ZipCode NVarChar(8) Not Null,
	Si NVarChar(150),
	Gu NVarChar(150),
	Dong NVarChar(255),
	PostEtc NVarChar(255)
)
Go

--[8] �ֹ�
Create Table Orders
(
	OrderID Int Identity(1,1) Primary Key,
	CustomerID Int Not Null,
	OrderDate DateTime Not Null,
	ShipDate DateTime Not Null,
	TotalPrice Int Null,
	OrderStatus VarChar(20),
	Payment VarChar(20),			--�������
	PaymentPrice Int,					--�����ݾ�
	PaymentInfo VarChar(20),
	PaymentEndDate DateTime,
	DeliveryInfo Int,
	DeliveryStatus VarChar(20),
	DeliveryEndDate DateTime,
	OrderIP VarChar(15),
	[Password] VarChar(20)
)
Go


--[9] �ֹ���
Create Table OrderDetails
(
	OrderID Int,
	ProductID Int,
	Quantity Int Not Null,
	SellPrice Int Not Null,
	Price Int,
	Mileage Int,
	Primary Key(OrderID, ProductID)
)
Go


--[10] ����� ����
Create Table Delivery
(
	OrderID Int Not Null References Orders(OrderID),
	CustomerName VarChar(50),
	TelePhone VarChar(20),
	MobilePhone VarChar(20),
	ZipCode VarChar(7),
	[Address] VarChar(100),
	AddressDetail VarChar(50),
	Primary Key (OrderID)
)
Go


--[11] �޸�(����� ������) : Orders ���̺� �����ص� ����
Create Table Message
(
	OrderID Int Not Null References Orders(OrderID),
	[Message] VarChar(150),
	Primary Key(OrderID)
)
Go


--[12] ������
Create Table AdminMessage
(
	OrderID Int Not Null,
	AdminMessage VarChar
)
Go


--[13] ���� �Ա� : �ɼ�
Create Table OnlineBanking
(
	DepositDate DateTime Not Null Default(GetDate()),
	DepositNum Int Not Null Identity(1,1),
	BankName VarChar(50),
	Name VarChar(50),
	Price Int,
	OrderID Int,
	Primary Key(DepositDate, DepositNum)
)
Go

-- =============================================================
-- create the stored procedures
-- =============================================================

--[1] ��ǰ ��� : ProductAdd.aspx���� ���
--ProductsAdd : Products���̺� ������ �Է� �� 
--���� �Էµ� ���ڵ��� ProductID���� ��ȯ
Create Procedure dbo.ProductsAdd
(
    @CategoryID Int,
    @ModelNumber VarChar(50) ,
    @ModelName VarChar(50) ,
    @Company VarChar(50),
    @OriginPrice Int,
    @SellPrice Int,
    @EventName VarChar(50),
    @ProductImage VarChar(50) ,
    @Explain VarChar(400),
    @Description VarChar(8000), -- Text
    @Encoding VarChar(10),
    @ProductCount Int,
    @Mileage Int,
    @Absence Int,
    @ProductID Int OUTPUT -- OUTPUT �Ű�����
)
As
	Insert Products
	(
		CategoryID, 
		ModelNumber, 
		ModelName, 
		Company, 
		OriginPrice, 
		SellPrice, 
		EventName, 
		ProductImage, 
		Explain, 
		Description, 
		Encoding, 
		ProductCount, 
		Mileage, 
		Absence
	) 
	Values
	(
		@CategoryID, 
		@ModelNumber, 
		@ModelName, 
		@Company, 
		@OriginPrice, 
		@SellPrice, 
		@EventName, 
		@ProductImage, 
		@Explain, 
		@Description, 
		@Encoding, 
		@ProductCount, 
		@Mileage, 
		@Absence
	)

	Select @ProductID = @@Identity
Go

--[2] ��ǰ ī�װ� ����Ʈ : CategoryList.ascx���� ���
CREATE Procedure ProductCategoryList
AS
	SELECT 
		CategoryID,
		CategoryName
	FROM 
		Categories
	ORDER BY 
		CategoryName ASC
Go

--[3] ī�װ��� ���� ��ǰ����Ʈ : ProductsList.aspx���� ���
CREATE Procedure ProductsByCategory
(
    @CategoryID Int
)
AS
	SELECT 
		ProductID,
		ModelName,
		SellPrice, 
		ProductImage
	FROM 
		Products
	WHERE 
		CategoryID = @CategoryID
	ORDER BY 
		ModelName, 
		ModelNumber
Go

--[4] ��ǰ �� : ProductDetails.aspx���� ���
CREATE Procedure ProductDetail
(
    @ProductID    Int,
    @ModelNumber  VarChar(50) OUTPUT,
    @ModelName    VarChar(50) OUTPUT,
    @Company		VarChar(50) OUTPUT,
    @ProductImage VarChar(50) OUTPUT,
    @OriginPrice     Int OUTPUT,
    @SellPrice     Int OUTPUT,
    @Description  NVarChar(4000) OUTPUT,
    @ProductCount     Int OUTPUT
)
AS
	SELECT 
		@ProductID		= ProductID,
		@ModelNumber	= ModelNumber,
		@ModelName		= ModelName,
		@Company		= Company,
		@ProductImage	= ProductImage,
		@OriginPrice	= OriginPrice,
		@SellPrice		= SellPrice,
		@Description	= -- Description,      -- SQL2000/2005 ���� ����
			Convert(NVarChar, Description),
		@ProductCount	= ProductCount
	FROM 
		Products
	WHERE 
		ProductID = @ProductID
Go

--[!] ��ü ��ǰ ����Ʈ : ProductPages.ascx���� ���
Create Proc dbo.GetProducts -- SQL Server 2005 ����
	@Page Int
As
	Select Top 10 * From Products 
	Where 
		ProductID Not In 
		(
			Select Top (10 * @Page) ProductID From Products 
			Order By ProductID Desc
		)
	Order By ProductID Desc
Go
Alter Proc dbo.GetProducts	-- SQL Server 2000 �̻� ����
	@Page Int
As
	Declare @strSql VarChar(1000)
	Set @strSql = '
		Select Top 10 * From Products 
		Where 
			ProductID Not In 
			(
				Select Top ' + Cast((10 *  + @Page) As VarChar) 
					+ ' ProductID From Products Order By ProductID Desc
			)
		Order By ProductID Desc
	'
	Exec(@strSql)
Go

--[5] ��ǰ�� ����Ʈ : ReviewList.ascx���� ���
CREATE Procedure ReviewsList
(
    @ProductID Int
)
AS
	SELECT 
		ReviewID, 
		CustomerName, 
		Rating, 
		Comments
	FROM 
		Reviews
	WHERE 
		ProductID = @ProductID
Go

--[6] ��ǰ�� �߰� : ReviewList.ascx���� ���
CREATE Procedure ReviewsAdd
(
    @ProductID     Int,
    @CustomerName  VarChar(50),
    @CustomerEmail VarChar(50),
    @Rating        Int,
    @Comments      VarChar(3850),
    @ReviewID      Int OUTPUT
)
AS
	INSERT INTO Reviews
	(
		ProductID, 
		CustomerName, 
		CustomerEmail, 
		Rating, 
		Comments
	)
	VALUES
	(
		@ProductID, 
		@CustomerName, 
		@CustomerEmail, 
		@Rating, 
		@Comments
	)

	SELECT 
		@ReviewID = @@Identity
Go

--[7] ����īƮ ������ �߰��ϱ� : AddToCart.aspx���� ���
CREATE Procedure ShoppingCartAddItem
(
    @CartID VarChar(50),
    @ProductID Int,
    @Quantity Int
)
As
	--(1) ���� ���� �ִ� ��ǰ�� �̹� ����ִ��� Ȯ��
	DECLARE @CountItems Int
	
	SELECT
		@CountItems = Count(ProductID)
	FROM
		ShoppingCart
	WHERE
		ProductID = @ProductID	/* ��ٱ��Ͽ� �������� ��ǰ */
	AND
		CartID = @CartID	/* ���� ������ : ȸ�� �Ǵ� ��ȸ�� */
	
	--(2) �̹� �ش� ��ǰ�� ����� �ִٸ�, ����
	IF @CountItems > 0  

		UPDATE
			ShoppingCart
		SET
			Quantity = (@Quantity + ShoppingCart.Quantity)
		WHERE
			ProductID = @ProductID
		AND
			CartID = @CartID

	--(3) ó�� �����ϴ� ��ǰ�̶��, �Է�
	ELSE  

		INSERT INTO ShoppingCart
		(
			CartID,
			Quantity,
			ProductID
		)
		VALUES
		(
			@CartID,
			@Quantity,
			@ProductID
		)
Go

--[8] ����īƮ ������ ���� : ShoppingCart.aspx���� ���
CREATE Procedure ShoppingCartItemCount
(
    @CartID    VarChar(50),	--����������
    @ItemCount Int OUTPUT	--��ǰī��Ʈ
)
AS
	SELECT 
		@ItemCount = COUNT(ProductID)
	FROM 
		ShoppingCart
	WHERE 
		CartID = @CartID
Go

--[9] ����īƮ ����Ʈ
CREATE Procedure ShoppingCartList
(
    @CartID VarChar(50)	--����������
)
AS
	SELECT 
		Products.ProductID,	--��ǰ������ȣ 
		Products.ModelName,	--��ǰ��
		Products.ModelNumber,	--�𵨹�ȣ
		ShoppingCart.Quantity,	--����
		Products.SellPrice,	--�ǸŰ���
		Cast((Products.SellPrice * ShoppingCart.Quantity) As Int) 
			As ExtendedAmount	--�Ұ�
	FROM 
		Products,
		ShoppingCart
	WHERE 
		Products.ProductID = ShoppingCart.ProductID
	AND 
		ShoppingCart.CartID = @CartID
	ORDER BY 
		Products.ModelName, 
		Products.ModelNumber
Go

--[10] ����īƮ ������Ʈ : ��ٱ��� ������
CREATE Procedure ShoppingCartUpdate
(
    @CartID    VarChar(50),	--����������
    @ProductID Int,		--��ǰ������ȣ
    @Quantity  Int		--����
)
AS
	UPDATE ShoppingCart
	SET 
		Quantity = @Quantity
	WHERE 
		CartID = @CartID 
	AND 
		ProductID = @ProductID
Go

--[11] ����īƮ ������ ����� : ���õ� ��ٱ��� �����
CREATE Procedure ShoppingCartRemoveItem
(
    @CartID VarChar(50),
    @ProductID Int
)
AS
	DELETE FROM ShoppingCart
	WHERE 
		CartID = @CartID
	AND
		ProductID = @ProductID
Go

--[12] ���� ����īƮ �� ���
CREATE Procedure ShoppingCartTotal
(
    @CartID    VarChar(50),
    @TotalCost Int OUTPUT
)
AS
	SELECT 
		@TotalCost = SUM(Products.SellPrice * ShoppingCart.Quantity)
	FROM 
		ShoppingCart,
		Products
	WHERE
		ShoppingCart.CartID = @CartID
	  AND
		Products.ProductID = ShoppingCart.ProductID
Go

--[13] ����īƮ ���ΰ�ħ : ��ȸ�� -> ȸ��
CREATE Procedure ShoppingCartMigrate
(
    @OriginalCartId VarChar(50),--����ID
    @NewCartId      VarChar(50)	--��ID
)
AS
	UPDATE 
		ShoppingCart
	SET 
		CartId = @NewCartId 
	WHERE 
		CartId = @OriginalCartId
Go

--[14] ����īƮ ����
CREATE Procedure ShoppingCartEmpty
(
    @CartID VarChar(50)	--����������
)
AS
	DELETE FROM ShoppingCart
	WHERE 
		CartID = @CartID
Go

--[15] �Ϸ簡 ���� ����īƮ ����� : ������ ��忡�� ���
CREATE Procedure ShoppingCartRemoveAbandoned
AS
	DELETE FROM ShoppingCart
	WHERE 
		DATEDIFF(dd, DateCreated, GetDate()) > 1
Go

--[!] ���ݱ��� ���� ��Ҵ���?
--Select DateDiff(dd, '1980-02-05', GetDate())

--[16] �� ��� : Register.aspx���� ���
CREATE Procedure CustomerAdd
(
	@CustomerName	VarChar(50),
	@Phone1			VarChar(4),
	@Phone2			VarChar(4),
	@Phone3			VarChar(4),
	@Mobile1		VarChar(4),
	@Mobile2		VarChar(4),
	@Mobile3		VarChar(4),
	@Zip VarChar(7),
	@Address	VarChar(100),
	@AddressDetail	VarChar(100),
	@Ssn1	VarChar(6),
	@Ssn2	VarChar(7),
	@EmailAddress      VarChar(50),
	@MemberDivision		Int,    
	--
	@UserID	VarChar(25),
	@Password   VarChar(100),
	@BirthYear	VarChar(4),
	@BirthMonth	VarChar(2),
	@BirthDay	VarChar(2),
	@BirthStatus	VarChar(2),
	@Gender	Int,
	@Job	VarChar(20),
	@Wedding	Int,
	@Hobby	VarChar(100),
	@Homepage	VarChar(100),
	@Intro	VarChar(400),
	@Mailing Int,
	@Mileage Int,
	--    
	@CustomerID Int OUTPUT
)
AS
	BEGIN TRAN CustomerAdd 
	
		INSERT INTO Customers
		(
			CustomerName,
			Phone1,
			Phone2,
			Phone3,
			Mobile1,
			Mobile2,
			Mobile3,
			Zip,
			Address,
			AddressDetail,
			Ssn1,
			Ssn2,
			EmailAddress,
			MemberDivision
		)
		VALUES
		(
			@CustomerName,
			@Phone1,
			@Phone2,
			@Phone3,
			@Mobile1,
			@Mobile2,
			@Mobile3,
			@Zip,
			@Address,
			@AddressDetail,
			@Ssn1,
			@Ssn2,
			@EmailAddress,
			@MemberDivision
		)
		
		SELECT @CustomerID = @@Identity
		
		INSERT INTO MemberShip
		VALUES
		(
			@CustomerID,
			@UserID,
			@Password,
			@BirthYear,
			@BirthMonth,
			@BirthDay,
			@BirthStatus,
			@Gender,
			@Job,
			@Wedding,
			@Hobby,
			@Homepage,
			@Intro,
			@Mailing,
			0,
			GetDate(),
			@Mileage,
			GetDate()			
		)
		
		SELECT @CustomerID

	COMMIT TRAN CustomerAdd
Go

--[17] �� ������ : ȸ������Ʈ(ȸ������, ������ ������)
CREATE Procedure CustomerDetail
(
    @CustomerID Int
)
AS
	SELECT TOP 1 
			Customers.CustomerName,
			Customers.Phone1,
			Customers.Phone2,
			Customers.Phone3,
			Customers.Mobile1,
			Customers.Mobile2,
			Customers.Mobile3,
			Customers.Zip,
			Customers.Address,
			Customers.AddressDetail,
			Customers.Ssn1,
			Customers.Ssn2,
			Customers.EmailAddress,
			Customers.MemberDivision,
			--
			MemberShip.UserID,
			MemberShip.Password,
			MemberShip.BirthYear,
			MemberShip.BirthMonth,
			MemberShip.BirthDay,
			MemberShip.BirthStatus,
			MemberShip.Gender,
			MemberShip.Job,
			MemberShip.Wedding,
			MemberShip.Hobby,
			MemberShip.Homepage,
			MemberShip.Intro,
			MemberShip.Mailing,
			MemberShip.VisitCount,
			MemberShip.LastVisit,
			MemberShip.Mileage,
			MemberShip.JoinDate								
	FROM 
		Customers
	INNER JOIN MemberShip ON Customers.CustomerID = MemberShip.CustomerID
	WHERE 
	    Customers.CustomerID = @CustomerID
Go

--[18] ȸ�� �α���
CREATE Procedure CustomerLogin
(
	@UserID      VarChar(50),
	@Password   VarChar(50),
	@CustomerID Int OUTPUT
)
AS
	SELECT 
		@CustomerID = CustomerID
	FROM 
		MemberShip
	WHERE 
		UserID = @UserID
	AND 
		Password = @Password
		
	IF @@Rowcount < 1 
	SELECT 
		@CustomerID = 0
Go

--[19] �ֹ� �߰� : Checkout.aspx���� ���
CREATE Procedure OrdersAdd
(
	@CustomerID Int,
	@OrderDate  DateTime,        
	@ShipDate   DateTime,
	@TotalPrice	Int,
	@OrderStatus	VarChar(20),
	@Payment	VarChar(20),
	@PaymentPrice	Int,
	@PaymentInfo	VarChar(20),
	@PaymentEndDate	DateTime,
	@DeliveryInfo	Int,
	@DeliveryStatus	VarChar(20),
	@DeliveryEndDate	DateTime,
	@OrderIP	VarChar(15),
	@Password	VarChar(20),    
	--
	@CartID     VarChar(50),
	--
	@Message	VarChar(150),
	--
	@CustomerName VarChar(50) ,
	@TelePhone VarChar(20) ,
	@MobilePhone VarChar(20) ,
	@ZipCode VarChar(7) ,
	@Address VarChar(100) ,
	@AddressDetail VarChar(50) ,	
	--
	@OrderID    Int OUTPUT
)
AS
	BEGIN TRAN AddOrder

	/* Orders ���̺� ���� ���� ��� */
	INSERT INTO Orders
	(
		CustomerID, 
		OrderDate, 
		ShipDate,
		TotalPrice,
		OrderStatus,
		Payment,
		PaymentPrice,
		PaymentInfo,
		PaymentEndDate,
		DeliveryInfo,
		DeliveryStatus,
		DeliveryEndDate,
		OrderIP,
		Password
	)
	VALUES
	(   
		@CustomerID, 
		@OrderDate, 
		@ShipDate,
		@TotalPrice,
		@OrderStatus,
		@Payment,
		@PaymentPrice,
		@PaymentInfo,
		@PaymentEndDate,
		@DeliveryInfo,
		@DeliveryStatus,
		@DeliveryEndDate,
		@OrderIP,
		@Password		
	)

	SELECT
		@OrderID = @@Identity    

	/* ���� �ֹ���ȣ�� ���� ����īƮ ������ OrdersDetail ���̺�� ���� */
	INSERT INTO OrderDetails
	(
		OrderID, 
		ProductID, 
		Quantity, 
		SellPrice,
		Price,
		Mileage
	)
	SELECT 
		@OrderID, 
		ShoppingCart.ProductID, 
		Quantity, 
		Products.SellPrice,
		(Products.SellPrice * ShoppingCart.Quantity) As Price,
		Products.Mileage
	FROM 
		ShoppingCart INNER JOIN Products 
        ON ShoppingCart.ProductID = Products.ProductID	  
	WHERE 
		CartID = @CartID

	/* �ֹ� ���� �� ���� īƮ ���̵� �ش��ϴ� ����īƮ ���� ����� */
	EXEC ShoppingCartEmpty @CartId

	/* ����� ���� �� ���� */
	INSERT INTO Message
	(
		OrderID,
		Message
	)
	VALUES
	(
		@OrderID,
		@Message
	)

	/* Delivery ���̺� ���� ���� ��� */
	INSERT INTO Delivery
	(
		OrderID,
		CustomerName,
		TelePhone,
		MobilePhone,
		ZipCode,
		Address,
		AddressDetail
	)
	VALUES
	(
		@OrderID,
		@CustomerName,
		@TelePhone,
		@MobilePhone,
		@ZipCode,
		@Address,
		@AddressDetail
	)
	
	COMMIT TRAN AddOrder
Go

--[20] ��ȸ�� �� ��� : CustomersDB.cs / CheckOut.aspx
CREATE Procedure NonCustomerAdd
(
	@CustomerName	VarChar(50),
	@Phone1			VarChar(4),
	@Phone2			VarChar(4),
	@Phone3			VarChar(4),
	@Mobile1		VarChar(4),
	@Mobile2		VarChar(4),
	@Mobile3		VarChar(4),
	@Zip VarChar(7),
	@Address	VarChar(100),
	@AddressDetail	VarChar(50),
	@Ssn1	VarChar(6),
	@Ssn2	VarChar(7),
	@EmailAddress      VarChar(50),
	@MemberDivision		Int,    
	--    
	@CustomerID Int OUTPUT
)
AS
	BEGIN TRAN CustomerAdd 
	
		INSERT INTO Customers
		(
			CustomerName,
			Phone1,
			Phone2,
			Phone3,
			Mobile1,
			Mobile2,
			Mobile3,
			Zip,
			Address,
			AddressDetail,
			Ssn1,
			Ssn2,
			EmailAddress,
			MemberDivision
		)
		VALUES
		(
			@CustomerName,
			@Phone1,
			@Phone2,
			@Phone3,
			@Mobile1,
			@Mobile2,
			@Mobile3,
			@Zip,
			@Address,
			@AddressDetail,
			@Ssn1,
			@Ssn2,
			@EmailAddress,
			@MemberDivision
		)
		
		SELECT @CustomerID = @@Identity
		
	COMMIT TRAN CustomerAdd
Go

--[21] �ֹ� ����Ʈ(ȸ��) : OrdersList.aspx
CREATE Procedure OrdersList
(
	@CustomerID Int
)
As
	SELECT  
		Orders.OrderID,
		Cast(Sum(Orderdetails.Quantity * OrderDetails.SellPrice) As Int) 
			As TotalPrice,
		Orders.OrderDate, 
		Orders.ShipDate
	FROM    
		Orders 
	INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
	GROUP BY    
		CustomerID, 
		Orders.OrderID, 
		Orders.OrderDate, 
		Orders.ShipDate
	HAVING  
		Orders.CustomerID = @CustomerID
Go

--[22] �ֹ� ����Ʈ(��ȸ��)
CREATE Procedure OrdersListNonCustomer
(
	@OrderID Int,		--�ֹ���ȣ
	@Password VarChar(20)	--��й�ȣ
)
As
	SELECT  
		Orders.OrderID,
		Cast(Sum(OrderDetails.Quantity * OrderDetails.SellPrice) As Int) 
			As TotalPrice,
		Orders.OrderDate, 
		Orders.ShipDate
	FROM    
		Orders 
	INNER JOIN OrderDetails On Orders.OrderID = OrderDetails.OrderID
	GROUP BY    
		Password, 
		Orders.OrderID, 
		Orders.OrderDate, 
		Orders.ShipDate
	HAVING  
		Orders.OrderID = @OrderID And Orders.Password = @Password
Go

--[23] �ֹ� ��
CREATE Procedure OrdersDetail
(
	@OrderID    Int,
	@OrderDate  DateTime OUTPUT,
	@ShipDate   DateTime OUTPUT,
	@TotalPrice Int OUTPUT
)
AS
	/* ���� ���� ���� �ֹ��ϰ� ����Ͽ� ���� �������� ��ȯ */
	SELECT 
		@OrderDate = OrderDate,
		@ShipDate = ShipDate
	FROM    
		Orders
	WHERE   
		OrderID = @OrderID

	IF @@Rowcount = 1
	BEGIN

	/* ó������ �� ������ Output �Ű������� ��ȯ */
	SELECT  
		@TotalPrice = Cast(SUM(OrderDetails.Quantity * OrderDetails.SellPrice) As Int)
	FROM    
		OrderDetails
	WHERE   
		OrderID= @OrderID
	/* �׷�����, �ֹ� �� ������ ��ȯ */
	SELECT  
		Products.ProductID, 
		Products.ModelName,
		Products.ModelNumber,
		OrderDetails.SellPrice,
		OrderDetails.Quantity,
		(OrderDetails.Quantity * OrderDetails.SellPrice) As ExtendedAmount
	FROM
		OrderDetails
	INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID
	WHERE   
		OrderID = @OrderID
	END
Go

--[24] ���� �̹� ������ ��ǰ : AlsoBought.aspx
CREATE Procedure CustomerAlsoBought
(
	@ProductID Int
)
As
	SELECT  TOP 5 
		OrderDetails.ProductID,
		Products.ModelName,
		SUM(OrderDetails.Quantity) as TotalNum
	FROM    
		OrderDetails
	INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID
	WHERE   OrderID IN 
	(
		/* ProductID�� �ش��ϴ� ��� �ֹ��� ���� OrderID �� ��ȯ */
		SELECT DISTINCT OrderID 
		FROM OrderDetails
		WHERE ProductID = @ProductID
	)
	AND OrderDetails.ProductID != @ProductID 
	GROUP BY OrderDetails.ProductID, Products.ModelName 
	ORDER BY TotalNum DESC
Go

--[25] ��ǰ �˻� : SearchResults.aspx
CREATE Procedure ProductSearch
(
	@Search VarChar(255)  -- �˻���
)
AS
	SELECT 
		ProductID,
		ModelName,
		ModelNumber,
		SellPrice, 
		ProductImage
	FROM 
		Products
	WHERE 
		ModelNumber LIKE '%' + @Search + '%' 
	OR
		ModelName LIKE '%' + @Search + '%'
	OR
		Description LIKE '%' + @Search + '%'
Go

--[26] �ֱٿ� �� �ȸ��� ��ǰ����Ʈ 5��
CREATE Procedure ProductsMostPopular
AS
	SELECT TOP 5 
		OrderDetails.ProductID, 
		SUM(OrderDetails.Quantity) as TotalNum, 
		Products.ModelName
	FROM    
		OrderDetails
	INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID
	GROUP BY 
		OrderDetails.ProductID, 
		Products.ModelName
	ORDER BY 
		TotalNum DESC
Go

--[27] ȸ�� ����(�ɼ�)
CREATE Procedure CustomerModify	
(
	@CustomerName	VarChar(50),
	@Phone1		VarChar(4),
	@Phone2		VarChar(4),
	@Phone3		VarChar(4),
	@Mobile1		VarChar(4),
	@Mobile2		VarChar(4),
	@Mobile3		VarChar(4),
	@Zip			VarChar(7),
	@Address		VarChar(100),
	@AddressDetail		VarChar(100),
	@Ssn1		VarChar(6),
	@Ssn2		VarChar(7),
	@EmailAddress      	VarChar(50),
	@MemberDivision	Int,    
	--
	@UserID		VarChar(25),
	@Password 	  	VarChar(100),
	@BirthYear		VarChar(4),
	@BirthMonth		VarChar(2),
	@BirthDay		VarChar(2),
		@BirthStatus		VarChar(2),
	@Gender		Int,
	@Job		VarChar(20),
	@Wedding	Int,
	@Hobby		VarChar(100),
	@Homepage	VarChar(100),
	@Intro		VarChar(400),
	@Mailing		 Int,
	@Mileage		 Int,
	--    
	@CustomerID Int
)
AS
	BEGIN TRAN CustomerModify	
		Update Customers		
		Set
			CustomerName = @CustomerName,
			Phone1 = @Phone1 ,
			Phone2 = @Phone2,
			Phone3 = @Phone3,
			Mobile1 = @Mobile1,
			Mobile2 = @Mobile2,
			Mobile3 = @Mobile3,
			Zip = @Zip,
			Address = @Address,
			AddressDetail =@AddressDetail,
			Ssn1 = @Ssn1,
			Ssn2 = @Ssn2,
			EmailAddress = @EmailAddress,
			MemberDivision = @MemberDivision			
		Where CustomerID = @CustomerID	
		
		Update MemberShip
		Set
			CustomerID = @CustomerID,
			UserID = @UserID,
			Password =@Password,
			BirthYear =@BirthYear,
			BirthMonth =@BirthMonth,
			BirthDay =@BirthDay,
			BirthStatus =@BirthStatus,
			Gender =@Gender,
			Job =@Job,
			Wedding=@Wedding,
			Hobby =@Hobby,
			Homepage =@Homepage,
			intro =@Intro,
			Mailing =@Mailing,
			Mileage =@Mileage		
		Where CustomerID = @CustomerID			
	COMMIT TRAN CustomerModify	
Go

-- =============================================================
-- create the user defined function
-- =============================================================

--[1] ���� ī�װ��� �ش��ϴ� ��� ī�װ��� ����ϴ� �Լ�
Create Function dbo.GetSuperCategory
(
	@SuperCategory As Int
)
Returns @CategoryTable Table
(
    CategoryID Int,
    CategoryName VarChar(50),
    SuperCategory Int,
    Align SmallInt
)
As
Begin
	Insert Into @CategoryTable
		Select * From Categories Where CategoryID = @SuperCategory
	
	Declare @CurrentCategory As Int

	Select @CurrentCategory = Min(CategoryID) From Categories
	Where SuperCategory = @SuperCategory

	While @CurrentCategory Is Not Null
	Begin
		Insert @CategoryTable
			Select * From GetSuperCategory(@CurrentCategory)
		Select @CurrentCategory = Min(CategoryID) From Categories
		Where SuperCategory = @SuperCategory And CategoryID > @CurrentCategory
	End
	Return
End