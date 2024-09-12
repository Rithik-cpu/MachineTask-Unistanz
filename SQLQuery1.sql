create table Cars(
Company varchar(50),
ModelName varchar(100),
Price int

)

INSERT INTO Cars (Company, ModelName, Price)
VALUES 
('Honda', 'Civic', 22000),
('Ford', 'Mustang', 27000),
('Chevrolet', 'Malibu', 23000),
('BMW', '3 Series', 41000),
('Tesla', 'Model S', 80000);

select * from Cars

drop table Cars

create table Cars(
CarId int identity(1,1),
Company varchar(50),
ModelName varchar(100),
Price int

)

INSERT INTO Cars (Company, ModelName, Price)
VALUES 
('Honda', 'Civic', 22000),
('Ford', 'Mustang', 27000),
('Chevrolet', 'Malibu', 23000),
('BMW', '3 Series', 41000),
('Tesla', 'Model S', 80000);

select * from Cars

SELECT @@VERSION;

create proc GetAllCars
as 
begin 
select * from Cars
end

create proc GetCarById
@CarId int
as 
begin
select * from Cars where CarId=@CarId
end

create proc SaveCar
@Company varchar(50),
@ModelName varchar(100),
@Price int
as
begin
insert into Cars(Company,ModelName,Price)
values(@Company,@ModelName,@Price)
end

create proc UpdateCar
@CarId int,
@Company varchar(50),
@ModelName varchar(100),
@Price int
as
begin 
update Cars
set Company=@Company, ModelName=@ModelName, Price=@Price
where CarId=@CarId
end

create table Bikes(
BId int identity(1,1),
Company varchar (100),
ModName varchar (50),
Price int
)

INSERT INTO Bikes (Company, ModName, Price)
VALUES 
('Yamaha', 'YZF-R3', 5000),
('Honda', 'CBR500R', 7000),
('Kawasaki', 'Ninja 400', 5500),
('Suzuki', 'GSX250R', 4700),
('Ducati', 'Panigale V2', 16000),
('BMW', 'S1000RR', 19000)

select * from Bikes

create proc GetAllBikes
as 
begin 
select * from Bikes
end

create proc GetBikesById
@BId int
as 
begin 
select * from Bikes where BId=@BId
end

create proc SaveBikes
@Company varchar(100),
@ModName varchar(100),
@Price int
as 
begin 
insert into Bikes(Company, ModName, Price)
values(@Company,@ModName,@Price)
end

create proc UpdateBike
@BId int,
@Company varchar(100),
@ModName varchar(100),
@Price int
as
begin
update Bikes
set Company=@Company, Modname=@ModName, Price=@Price
where BId=@BId
end

CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    Stock INT
);

drop table Products

CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Stock INT
);

INSERT INTO Products (ProductName, Category, Stock)
VALUES 
('Laptop', 'Electronics', 50),
('Smartphone', 'Electronics', 100),
('Table', 'Furniture', 20),
('Chair', 'Furniture', 50),
('Headphones', 'Electronics',150);

create proc GetAllProducts
as
begin
select * from Products
end

create proc GetProductById
@ProductID int
as
begin
select * from Products where ProductID=@ProductID
end

create table DepartmentJn(
Dept_Id int primary key identity (1,1),
Dept_Name varchar (100))

create table EmployeeJn(
Emp_Id int primary key identity (1,1),
Emp_FName varchar (100),
Emp_LName varchar (100),
Dept_Id int, 
foreign key (Dept_Id) references DepartmentJn(Dept_Id)) 

insert into DepartmentJn values
('HR'),
('Admin'),
('Account')


insert into EmployeeJn values
('Oliv',' Yew',1),
('Aida',' Bugg',2),
('Simon',' Johnston',2),
('Benjamin','Lee',1),
('Wanda',' Ross',3),
('Ferguson',' Tracey',1),
('Leonard',' Sutherland',2),
('Forsyth','Deirdre',3)

select * from DepartmentJn
inner join EmployeeJn
on DepartmentJn.Dept_Id=EmployeeJn.Dept_Id

select * from DepartmentJn
left join  EmployeeJn
on DepartmentJn.Dept_Id=EmployeeJn.Dept_Id

select * from DepartmentJn
right join EmployeeJn
on DepartmentJn.Dept_Id=EmployeeJn.Dept_Id

select * from DepartmentJn
full outer join EmployeeJn
on DepartmentJn.Dept_Id=EmployeeJn.Dept_Id

select * from DepartmentJn
cross join EmployeeJn

--views practice --

CREATE TABLE EmployeesVw (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10, 2)
);

CREATE TABLE DepartmentsVw (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

INSERT INTO EmployeesVw(EmployeeID, EmployeeName, DepartmentID, Salary) VALUES
(1, 'John', 101, 50000),
(2, 'Jane', 102, 60000),
(3, 'Sam', 101, 55000),
(4, 'Sara', 103, 70000);

INSERT INTO DepartmentsVw (DepartmentID, DepartmentName) VALUES
(101, 'HR'),
(102, 'IT'),
(103, 'Finance');

create view EmployeeDepartmentView as
select e.EmployeeName , d.DepartmentName
from EmployeesVw e
inner join DepartmentsVw d on e.DepartmentID=d.DepartmentID

select * from EmployeeDepartmentView

CREATE TABLE OrdersM (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    ItemName VARCHAR(100),
    Quantity INT,
    Price DECIMAL(18,2),
    Deal_Type VARCHAR(10)
);

CREATE TABLE Purchases (
    PurchaseID INT IDENTITY(1,1) PRIMARY KEY,
    ItemName VARCHAR(100),
    Quantity INT,
    Price DECIMAL(18,2)
);

CREATE PROCEDURE InsertPurchaseAndOrder
    @ItemName VARCHAR(100),
    @Quantity INT,
    @Price DECIMAL(18,2)
AS
BEGIN

INSERT INTO Purchases (ItemName, Quantity, Price)
    VALUES (@ItemName, @Quantity, @Price);

	 DECLARE @PurchaseID INT = SCOPE_IDENTITY();

	 INSERT INTO OrdersM (ItemName, Quantity, Price, Deal_Type)
    VALUES (@ItemName, @Quantity, @Price, 'Buy');
END

INSERT INTO OrdersM (ItemName, Quantity, Price, Deal_Type)
VALUES
('Laptop', 5, 75000.00, 'Buy'),
('Smartphone', 10, 30000.00, 'Buy'),
('Tablet', 8, 20000.00, 'Buy'),
('Headphones', 15, 1500.00, 'Buy'),
('Monitor', 7, 8000.00, 'Buy');

select * from OrdersM