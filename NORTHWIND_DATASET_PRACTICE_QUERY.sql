/*
    Filename: NORTHWIND_DATASET_PRACTICE_QUERY.sql
    Author: RAVI CHANDRIKA B
    Date: 08/04/2022
    Description:This SQL file contains some queries for questions and answers on northwind dataset
*/

USE Northwind

-- 1.	Create a report that shows the CategoryName and Description from the categories table sorted by CategoryName.
SELECT CategoryName, Description
FROM dbo.Categories
ORDER BY CategoryName

--2.	Create a report that shows the ContactName, CompanyName, ContactTitle and Phone number from the customers table sorted by Phone.
SELECT ContactName, CompanyName, ContactTitle, Phone
From dbo.Customers
ORDER BY Phone

--3.	Create a report that shows the capitalized FirstName and capitalized LastName renamed as FirstName and Lastname respectively 
-- and HireDate from the employees table sorted from the newest to the oldest employee.
SELECT UPPER(FirstName) AS FirstName, UPPER( LastName) AS LastName, HireDate
FROM dbo.Employees
ORDER BY HireDate

--4.	Create a report that shows the top 10 OrderID, OrderDate, ShippedDate, CustomerID, Freight from the orders table sorted by Freight in descending order.
SELECT TOP 10 OrderID, OrderDate, ShippedDate, CustomerID, Freight
FROM dbo.Orders
ORDER BY Freight Desc

--5.	Create a report that shows all the CustomerID in lowercase letter and renamed as ID from the customers table.
SELECT lower(CustomerID) AS ID
FROM dbo.Customers

-- 6.	Create a report that shows the CompanyName, Fax, Phone, Country, HomePage from the suppliers table 
-- sorted by the Country in descending order then by CompanyName in ascending order.

SELECT CompanyName, Fax, Phone, Country, HomePage
FROM dbo.Suppliers
ORDER BY Country DESC,CompanyName ASC

--7.	Create a report that shows CompanyName, ContactName of all customers from ‘Buenos Aires' only.
SELECT CompanyName, ContactName
FROM dbo.Customers
WHERE City='Buenos Aires'

--8.	Create a report showing ProductName, UnitPrice, QuantityPerUnit of products that are out of stock.
SELECT  ProductName, UnitPrice, QuantityPerUnit
FROM dbo.Products
WHERE UnitsInStock = 0

--9.	Create a report showing all the ContactName, Address, City of all customers not from Germany, Mexico, Spain.
SELECT   ContactName, Address, City
FROM dbo.Customers
WHERE Country NOT IN ('Germany','Mexico','Spain')

--10.	Create a report showing OrderDate, ShippedDate, CustomerID, Freight of all orders placed on 21 May 1997.
SELECT CAST(OrderDate AS  DATE) AS OrderDate, ShippedDate, CustomerID, Freight
FROM dbo.Orders
WHERE CAST(OrderDate AS  DATE)='1997-05-21'

--11.	Create a report showing FirstName, LastName, Country from the employees not from United States.
SELECT FirstName, LastName, Country
FROM dbo.Employees
WHERE Country NOT LIKE 'USA'

--12.	Create a report that shows the EmployeeID, OrderID, CustomerID, RequiredDate, ShippedDate from all orders shipped later than the required date.
SELECT EmployeeID, OrderID, CustomerID, RequiredDate, ShippedDate
FROM Orders
WHERE CAST( ShippedDate AS  DATE) > CAST(RequiredDate AS  DATE) 

--13.	Create a report that shows the City, CompanyName, ContactName of customers from cities starting with A or B.
SELECT City, CompanyName, ContactName
FROM dbo.Customers
WHERE City LIKE 'A%' OR City LIKE 'B%'
ORDER BY City

--14.	Create a report showing all the even numbers of OrderID from the orders table.
SELECT *
FROM dbo.Orders
WHERE OrderID%2=0

--15.	Create a report that shows all the orders where the Freight cost more than $500.
SELECT *
FROM dbo.Orders
WHERE Freight > 500

--16.	Create a report that shows the ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel of all products that are up for reorder.
SELECT *
FROM dbo.Products
WHERE ReorderLevel=0

--17.	Create a report that shows the CompanyName, ContactName, Phone number of all customer that have no fax number and sorted by ContactName.
SELECT CompanyName, ContactName, Phone
FROM dbo.Customers
WHERE Fax IS Null
ORDER BY ContactName

--18.	Create a report that shows the FirstName, LastName of all employees that do not report to anybody.
SELECT *
FROM dbo.Employees
WHERE ReportsTo IS Null

--19.	Create a report showing all the odd numbers of OrderID from the orders table.
SELECT *
FROM dbo.Orders
WHERE OrderID%2=1

--20.	Create a report that shows the City, CompanyName, ContactName of customers from cities that has letter L in the name sorted by ContactName.
SELECT City, CompanyName, ContactName
FROM dbo.Customers
WHERE City LIKE '%L%' 
ORDER BY ContactName

--21.	Create a report that shows the FirstName, LastName, BirthDate of employees born in the 1950s.
SELECT FirstName, LastName, BirthDate
FROM dbo.Employees
WHERE DATEPART(YEAR, BirthDate) BETWEEN 1950 AND 1959


--22.	Create a report that shows the FirstName, LastName, the year of Birthdate as birth year from the employees table.
SELECT FirstName, LastName, DATEPART(YEAR,BirthDate) AS 'Birth Year'
FROM dbo.Employees

--23.	Create a report showing OrderID, total number of Order ID as NumberofOrders from the orderdetails table grouped by OrderID and sorted by NumberofOrders in descending order. HINT: you will need to use a Groupby statement.
SELECT CustomerID, COUNT(CustomerID) as NumberofOrders 
FROM dbo.Orders
GROUP BY CustomerID
ORDER BY NumberofOrders DESC

--24.	Create a report that shows the SupplierID, ProductName, CompanyName from all product Supplied by Exotic Liquids, Specialty Biscuits, Ltd., Escargots Nouveaux sorted by the supplier ID
SELECT s.SupplierID, p.ProductName, s.CompanyName
FROM dbo.Suppliers s
JOIN dbo.Products p 
ON s.SupplierID =p.SupplierID
WHERE s.CompanyName IN ('Specialty Biscuits, Ltd.','Exotic Liquids','Escargots Nouveaux')
ORDER BY s.SupplierID

--25.	Create a report that shows the ShipPostalCode, OrderID, OrderDate, RequiredDate, ShippedDate, ShipAddress of all orders with ShipPostalCode beginning with "98124".
SELECT ShipPostalCode, OrderID, OrderDate, RequiredDate, ShippedDate, ShipAddress
FROM dbo.Orders
WHERE ShipPostalCode LIKE '98124%'

--26.	Create a report that shows the ContactName, ContactTitle, CompanyName of customers that the has no "Sales" in their ContactTitle.
SELECT ContactName, ContactTitle, CompanyName
FROM dbo.Customers
WHERE ContactTitle NOT LIKE '%Sales%'

--27.	Create a report that shows the LastName, FirstName, City of employees in cities other "Seattle";
SELECT LastName, FirstName, City
FROM dbo.Employees
WHERE CITY NOT LIKE 'Seattle'

--28.	Create a report that shows the CompanyName, ContactTitle, City, Country of all customers in any city in Mexico or other cities in Spain other than Madrid.
SELECT CompanyName, ContactTitle, City, Country
FROM dbo.Customers
WHERE Country IN ('Mexico','Spain') AND City NOT LIKE 'Madrid'

--29.	Create a select statement that outputs the following:
--'ABC can be reached on 123' as ContactInfo
SELECT CONCAT(ContactName, ' can be reached at ',Phone) AS ContactInfo
FROM dbo.Customers

--30.	Create a report that shows the ContactName of all customers that do not have letter A as the second alphabet in their Contactname.
SELECT ContactName
FROM dbo.Customers
WHERE ContactName NOT LIKE '_A%'

--31.	Create a report that shows the average UnitPrice rounded to the next whole number, total number of UnitsInStock and maximum number of orders from the products table. All saved as AveragePrice, TotalStock and MaxOrder respectively.
SELECT 
ROUND(AVG(UnitPrice),0) AS AveragePrice, 
SUM(UnitsInStock) AS TotalStock,
MAX(UnitsOnOrder) AS MaxOrder
FROM dbo.Products

--32.	Create a report that shows the SupplierID, CompanyName, CategoryName, ProductName and UnitPrice from the products, suppliers and categories table.
SELECT s.SupplierID, s.CompanyName, c.CategoryName, p.ProductName, p.UnitPrice
FROM dbo.Suppliers s
JOIN dbo.Products p
ON s.SupplierID = p.SupplierID
JOIN dbo.Categories c
ON P.CategoryID = c.CategoryID

--33.	Create a report that shows the CustomerID, sum of Freight, from the orders table with sum of freight greater $200, grouped by CustomerID. HINT: you will need to use a Groupby and a Having statement.
SELECT CustomerID, SUM(Freight) AS FreightSum
FROM dbo.Orders
GROUP BY CustomerID
HAVING SUM(Freight) > 200

--34.	Create a report that shows the OrderID ContactName, UnitPrice, Quantity, Discount from the order details, orders and customers table with discount given on every purchase.
SELECT o.OrderID, c.ContactName, od.UnitPrice, od.Quantity, od.Discount
FROM dbo.Customers c
JOIN dbo.Orders o
ON c.CustomerID = o.CustomerID
JOIN dbo.[Order Details] od
ON o.OrderID = od.OrderID
WHERE od.Discount != 0 

--35.	Create a report that shows the EmployeeID, the LastName and FirstName as employee, and the LastName and FirstName of who they report to as manager from the employees table sorted by Employee	ID. HINT: This is a SelfJoin.
SELECT 
e.EmployeeID,
e.FirstName + ' ' + e.LastName AS Employee,
m.FirstName + ' ' + m.LastName AS Manager
FROM dbo.Employees e
INNER JOIN dbo.Employees m 
ON m.EmployeeID = e.ReportsTo
ORDER BY e.EmployeeID


--36.	Create a report that shows the average, minimum and maximum UnitPrice of all products as AveragePrice, MinimumPrice and MaximumPrice respectively.
SELECT AVG(UnitPrice) AS AveragePrice, 
MIN(UnitPrice) AS MinimumPrice, 
MAX(UnitPrice) AS MaximumPrice
FROM dbo.Products

--37.	Create a view named CustomerInfo that shows the CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Country, Phone, OrderDate, RequiredDate, ShippedDate from the customers and orders table. HINT: Create a View.
CREATE VIEW
CustomerInfo AS 
SELECT c.CustomerID, c.CompanyName, c.ContactName, c.ContactTitle, c.Address, 
c.City,c.Country,c.Phone,o.OrderID, o.OrderDate, o.RequiredDate, o.ShippedDate
FROM dbo.Orders o
JOIN dbo.Customers c
ON o.CustomerID = c.CustomerID

--38.	Change the name of the view you created from customerinfo to customer details.
sp_rename 'CustomerInfo', 'CustomerDetails'

--39.	Create a view named ProductDetails that shows the ProductID, CompanyName, ProductName, CategoryName, Description, QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder, ReorderLevel, Discontinued from the supplier, products and categories tables. HINT: Create a View
CREATE VIEW ProductDetails 
AS 
SELECT p.ProductID,s.CompanyName, p.ProductName, c.CategoryName, c.Description, 
p.QuantityPerUnit, p.UnitPrice, p.UnitsInStock, p.UnitsOnOrder, p.ReorderLevel, p.Discontinued
FROM dbo.Suppliers s
JOIN dbo.Products p 
ON s.SupplierID = p.SupplierID 
JOIN dbo.Categories c
ON c.CategoryID = p.CategoryID

--40.	Drop the customer details view.
DROP VIEW IF EXISTS CustomerDetails

--41.	Create a report that fetch the first 5 character of categoryName from the category tables and renamed as ShortInfo
SELECT CategoryName, SUBSTRING(CategoryName, 1, 5) AS ShortInfo
FROM dbo.Categories

--42.	Create a copy of the shipper table as shippers_duplicate. Then insert a copy of shippers data into the new table HINT: Create a Table, use the LIKE Statement and INSERT INTO statement.

---Use Transact-SQL
-----To duplicate a table in Query Editor
-----Make sure you are connected to the database in which you want to create the table and that the database is selected in Object Explorer.
--------------Right-click the table you wish to duplicate, point to Script Table as, then point to CREATE to, and then select New Query Editor Window.
--------------Change the name of the table.
--------------Remove any columns that are not needed in the new table.
--------------Select Execute to create the new table.

--Even if the table schema is copies we still need to copy the contents separately.
SELECT *
FROM dbo.shippers_duplicate
--This returns null

--copy the data from one table to other
SET IDENTITY_INSERT dbo.shippers_duplicate ON;

INSERT INTO dbo.shippers_duplicate (ShipperID, CompanyName, Phone)
SELECT ShipperID, CompanyName, Phone
FROM dbo.Shippers

SET IDENTITY_INSERT dbo.shippers_duplicate OFF;

--
SELECT *
FROM dbo.shippers_duplicate
--now data is copied

----Use SQL Server Management Studio
------To duplicate a table
------Make sure you are connected to the database in which you want to create the table and that the database is selected in Object Explorer.

--Lets copy below table
SELECT *
FROM dbo.Region

------------In Object Explorer, right-click Tables and select New Table.
------------In Object Explorer right-click the table you want to copy and select Design.
------------Select the columns in the existing table and, from the Edit menu, select Copy.
------------Switch back to the new table and select the first row.
------------From the Edit menu, select Paste.
------------From the File menu, select Save table name.
------------In the Choose Name dialog box, type a name for the new table. Select OK.


SELECT *
FROM dbo.region_duplicate
--table is created need to insert contents

--insert values manually
INSERT INTO dbo.region_duplicate
(RegionID, RegionDescription)
VALUES
('5', 'northeast'),
('6','northwest'),
('7', 'southeast'),
('8','southwest')

SELECT *
FROM dbo.region_duplicate
--table is created with contents

--43.	Add Email to shippers_duplicate table:

--add a column Email
ALTER TABLE shippers_duplicate
ADD Email VARCHAR(100)


SELECT *
FROM dbo.shippers_duplicate

--insert values manually
UPDATE dbo.shippers_duplicate
SET Email = CASE ShipperID
                  WHEN '1' THEN 'speedyexpress@gmail.com'
                  WHEN '2' THEN 'unitedpackage@gmail.com'
				  WHEN '3' THEN 'federalshipping@gmail.com'
                END
WHERE ShipperID IN ('1', '2', '3')


--44.	Create a report that shows the CompanyName and ProductName from all product in the Seafood category.
SELECT p.ProductName,s.CompanyName
FROM dbo.Products P
JOIN dbo.Categories c 
ON p.CategoryID = c.CategoryID
JOIN dbo.Suppliers s 
ON p.SupplierID = s.SupplierID
WHERE c.CategoryName = 'Seafood'

--45.	Create a report that shows the CompanyName and ProductName from all product in the categoryID 5.
SELECT p.ProductName,s.CompanyName
FROM dbo.Products P
JOIN dbo.Categories c 
ON p.CategoryID = c.CategoryID
JOIN dbo.Suppliers s 
ON p.SupplierID = s.SupplierID
WHERE c.CategoryID = '5'

--46.	Delete the shippers_duplicate table and region_duplicate.
DROP TABLE IF EXISTS shippers_duplicate
DROP TABLE IF EXISTS region_duplicate

--47.	Create a select statement that ouputs the following from the employees table.
----NB: The age might differ depending on the year you are attempting this query.
DECLARE @currentdatetime DATETIME  

SET @currentdatetime  = GETDATE() --Current Datetime  

SELECT LastName, FirstName, Title, CONCAT(DATEDIFF(YEAR, BirthDate,@currentdatetime), ' Years')  AS Age
FROM dbo.Employees

--48.	Create a report that the CompanyName and total number of orders by customer renamed as number of orders since Decemeber 31, 1994. 
--Show number of Orders greater than 10.
SELECT c.CompanyName,COUNT(o.OrderID) AS totalorders
FROM dbo.Orders o
JOIN dbo.Customers c 
ON o.CustomerID = c.CustomerID
WHERE CAST(o.OrderDate AS  DATE) > '1996-12-31'
GROUP BY c.CompanyName
HAVING COUNT(o.OrderID) > 10  

--49.	Create a select statement that ouputs the following from the product table
--QuantityPerUnit of ProductName costs UunitPrice

SELECT CONCAT(QuantityPerUnit,' of ',ProductName,' costs ',UnitPrice,'$') AS ProductInfo, c.CategoryName
FROM dbo.Products p
JOIN dbo.Categories c
ON p.CategoryID = c.CategoryID


--50. Print an employee hierarchy for Employee ID 5

--similar with CTE
WITH CTE_EMPLOYEE_HEIRARCHY AS
(
    SELECT E.EmployeeID, E.ReportsTo AS Supervisor, E.FirstName, E.LastName
    FROM dbo.Employees E WHERE E.EmployeeID = 5
    
    UNION ALL

    SELECT E1.EmployeeID, E1.ReportsTo AS Supervisor, E1.FirstName, E1.LastName
    FROM CTE_EMPLOYEE_HEIRARCHY 
    JOIN EMPLOYEES E1
    ON E1.ReportsTo = CTE_EMPLOYEE_HEIRARCHY.EmployeeID 

)

SELECT * FROM CTE_EMPLOYEE_HEIRARCHY


