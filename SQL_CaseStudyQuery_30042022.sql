/* 	



	Name of project: Case Study on E-Commers Website.

	Name:Tejas Bharat Gire
	Date :30/04/2022
	
	
	
	
*/





	DROP DATABASE IF EXISTS amazondb;
	CREATE DATABASE amazondb;
	Show databases;
	USE amazondb;
	
	CREATE TABLE account(acc_id INT PRIMARY KEY auto_increment, Name VARCHAR(20)NOT NULL  ,
	Country VARCHAR(20) NOT NULL ,CountryCode varchar(10) default (+91), mobileOrEmail varchar(25) NOT NULL,
	Password VARCHAR(20) NOT NULL );
	
	DESC account;
	
	INSERT INTO account VALUES
	(1,'Tejas Gire','India',+91,'8600859005','Tejas123@'),
	(2,'Prasad Badhe','India',+91,'9898554565','Prasad@300');
	SELECT ('Sign-in') as '   ' FROM DUAL;
	/* Loggin Account*/
	
	SELECT * FROM account WHERE mobileOrEmail=8600859005 AND Password='Tejas123@';
	
	CREATE TABLE account_info(acc_id INT PRIMARY KEY ,country VARCHAR(20),name VARCHAR(20) NOT NULL ,
	mobileno BIGINT UNIQUE NOT NULL ,pincode INT NOT NULL,flat_company VARCHAR(50) NOT NULL ,area VARCHAR(50) NOT NULL ,
	town_city VARCHAR(50) NOT NULL,FOREIGN KEY (acc_id) REFERENCES account(acc_id));/*Update account details*/
	
	INSERT INTO account_info VALUES(1,'India','Tejas Gire',8600859005,411046,'Mahavir Kunj A9','Katraj Dattanager Road','Pune');
	
	SELECT ('Your Account') as '   ' FROM dual;
	/*Create view for address details*/
	CREATE VIEW address AS SELECT name,mobileno,flat_company,area,town_city,pincode,country FROM account_info ; 
	
	SELECT * FROM address;
	
	CREATE TABLE department(deptid INT PRIMARY KEY,deptname VARCHAR(30) NOT NULL ,description VARCHAR(100) NOT NULL);
	
	INSERT INTO department VALUES 
	(1001,'Mobile,Computers','All Mobile phones, Accessories, Power Banks, Tablet'),
	(1002,'TV,Appliences,Electronics','Speakers,Headphones,Cameras,Accessories'),
	(1003,'Mens Fashon','Clothing , Watches,Shoes,Sunglases'),
	(1004,'Home,Kitchen,pets','Furniture,Decore,Lightning');
	
	SELECT * FROM department;
	
	/*Select ELECTRONICS Department*/
	SELECT * FROM department WHERE deptname='TV,Appliences,Electronics';
	
	CREATE TABLE productType (producttypeid VARCHAR(10) PRIMARY KEY,dept_id INT NOT NULL ,
	product_type VARCHAR(20)NOT NULL, FOREIGN KEY (dept_id) REFERENCES department (deptid));
	
	DESC productType;
	
	INSERT INTO productType VALUES 
	('Lap100',1002,'Laptop'),
	('Wat111',1003,'Watches'),
	('Head01',1002,'Headphones'),
	('Cam007',1002,'Cameras'),
	('Tab104',1001,'Tablets'),
	('Aud10',1002,'Speakers');
	
	SELECT * FROM productType;
	/*Select Laptop from  All Products*/
	
	SELECT * FROM productType WHERE product_type='Laptop';
	
	CREATE TABLE products(prodId VARCHAR(20) PRIMARY KEY,prodtypeid VARCHAR(20) NOT NULL,
	supplierid VARCHAR(20) UNIQUE,productName VARCHAR(50) NOT NULL,brand VARCHAR(20)NOT NULL,
	price INT NOT NULL,descr VARCHAR(100),CustReview INT CHECK(custReview<=5),
	FOREIGN KEY (prodtypeid) REFERENCES productType(producttypeid));
	
	INSERT INTO products VALUES
	('Vivobook14','Lap100','EAHS1001','Asus Vivobook 14','Asus',33990,'14(35.56 cm) FHD, Intel Core i3-1115G4 11th Gen(8GB/256GB SSD',3),
	('Vivobook14s','Lap100','AHS1475','Asus Vivobook 14','Asus',57990,'14(35.56 cm) FHD, Intel Core i3-1115G4 11th Gen(16GB/512GB SSD',4),
	('14s-dy2506TU','Lap100','JADHD01','HP 14S','HP',35990,'HP 14s 11th Gen Intel Core i3- 8GB RAM/256GB SSD 14 inch(35.6cm)IPS Display',3.9),
	('15s-du3517TU','Lap100','YDBS325','HP 15S','HP',52990,'11th Gen Intel Core i5-8GB RAM/512GB SSD',5);
	
	select * from products;
	SELECT ('CHOOSE LAPTOP WHOSE RATING IS 5');
	
	select * from products Where custReview>all(SELECT MAX(custReview) FROM products group By brand); 
		
	CREATE TABLE ordersReview(orderid Varchar(20) PRIMARY KEY,acc_id INT NOT NULL ,supplierid VARCHAR(20)UNIQUE NOT NULL,
	prodId VARCHAR(20) UNIQUE NOT NULL,paymentId VARCHAR(20) UNIQUE NOT NULL,orderDate Date NOT NULL,Qty INT DEFAULT (1),
	FOREIGN KEY(acc_id) REFERENCES account_info(acc_id),FOREIGN KEY (supplierid) REFERENCES products(supplierid),
	FOREIGN KEY(prodId) REFERENCES products(ProdId));
	
	INSERT INTO ordersReview VALUES
	('040-01145',1,'YDBS325','15s-du3517TU','404-14755','2022-05-03',1);
	
	SELECT * FROM ordersReview;
	
	CREATE TABLE cardpayment(paymentId VARCHAR(20) PRIMARY KEY ,acc_id INT, cardNo BIGINT UNIQUE NOT NULL,validfrom YEAR,
	validtill YEAR,FOREIGN KEY (paymentId) REFERENCES ordersReview (paymentID),FOREIGN KEY (acc_id) REFERENCES account_info(acc_id));
	
	INSERT INTO cardpayment VALUES('404-14755',1,'6428548845557455','2017','2027');
	
	CREATE VIEW orderDetails AS 
	SELECT ordersReview.orderid,account_info.acc_id,ordersReview.prodId,products.productName,products.brand,products.price,
	account_info.name,account_info.mobileno,account_info.flat_company,account_info.area,account_info.town_city,account_info.country,
	account_info.pincode FROM ((ordersReview INNER JOIN products ON ordersReview.prodId=products.prodId) 
	INNER JOIN account_info ON ordersReview.acc_id=account_info.acc_id);
	
	SELECT * FROM orderDetails;
	
	SELECT products.prodId,products.productName as Product,products.brand as Brand,products.price as Amount_to_pay ,
	ordersReview.orderDate as Order_Date from products inner join ordersReview on ordersReview.prodId=products.prodId;
	
	Select * from cardpayment;

	Select ("Payment SUCCESSFUL!") as 'Processing...' from dual; 
	----------------------------------------------------------------------------------------------------------------------------------