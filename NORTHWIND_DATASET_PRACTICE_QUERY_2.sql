/*
    Filename: NORTHWIND_DATASET_PRACTICE_QUERY_2.sql
    Author: RAVI CHANDRIKA B
    Date: 19/04/2022
    Description:This SQL file contains some queries for questions and answers on northwind dataset
	From the book 57 beginning, intermediate, and advanced challenges for you to solve using a "learn-by-doing" approach
	By Sylvia Moestl Vasilik

*/

--Introductory Problems

USE Northwind

--1. Which shippers do we have?
SELECT *
FROM dbo.Shippers

--2. Select certain fields from Categories
SELECT CategoryName,Description
FROM dbo.Categories


--3. Get FirstName,LastName,HireDate of the Sales Representatives from USA
SELECT FirstName,LastName,HireDate
FROM dbo.Employees
WHERE Title = 'Sales Representative' AND Country = 'USA'

--4. Find orders placed by specific EmployeeID
SELECT OrderID,OrderDate
FROM dbo.Orders
WHERE EmployeeID = 5

--5. Suppliers and ContactTitles of suppliers who are not 'Marketing Manager'
SELECT SupplierID,ContactName,ContactTitle
FROM Suppliers
WHERE ContactTitle <> 'Marketing Manager'

--6. Products with “queso” in ProductName
SELECT ProductID,ProductName
FROM Products
WHERE ProductName like '%queso%'

--7. Find orders shipping to France or Belgium
SELECT OrderID,CustomerID,ShipCountry
FROM Orders
WHERE ShipCountry = 'France' OR ShipCountry = 'Belgium'

--8. Orders shipping to any country in South America
SELECT OrderID,CustomerID,ShipCountry
FROM Orders
WHERE ShipCountry  IN ('Brazil','Mexico','Argentina','Venezuela')

--9. Employees, in order of age, Showing only the Date with a DateTime field
SELECT FirstName,LastName,Title,DateOnlyBirthDate = CONVERT(DATE, BirthDate)
FROM dbo.Employees
ORDER BY Birthdate

--10. Employees full name
SELECT FirstName,LastName, FullName = FirstName + ' ' + LastName
FROM dbo.Employees

--11. OrderDetails and amount per line item
SELECT OrderID,ProductID,UnitPrice,Quantity,TotalPrice = UnitPrice * Quantity
FROM dbo.[Order Details]
ORDER BY OrderID,ProductID

--12. How many customers are there in total?
SELECT TotalCustomers = COUNT(*)
FROM dbo.Customers

--13. Get the date of first order?
SELECT FirstOrder = MIN(CONVERT(DATE,OrderDate))
FROM dbo.Orders

--14. List of countries where there are customers are from
SELECT Country
FROM dbo.Customers
GROUP BY Country

--15. Count customers per each contact titles
SELECT ContactTitle,COUNT(*) AS TotalContactTitle
FROM dbo.Customers
GROUP BY ContactTitle
Order by COUNT(*) DESC

--16. Products and associated supplier names
SELECT ProductID,ProductName,CompanyName AS Supplier
FROM dbo.Products P
JOIN dbo.Suppliers S
ON P.SupplierID = S.SupplierID
ORDER BY CompanyName

--17. Orders and the Shipper that was used for OrderDate BETWEEN '1997-05-01' AND '1997-05-12'
SELECT OrderID, CONVERT(DATE, OrderDate) AS OrderDate,Shipper = CompanyName
FROM dbo.Orders
JOIN dbo.Shippers
ON Shippers.ShipperID = Orders.ShipVia
WHERE OrderDate BETWEEN '1997-05-01' AND '1997-05-12'
ORDER BY OrderID

--Intermediate Problems

--1. Categories, and the total products in each category

SELECT CategoryName,TotalProducts = count(*)
FROM Products
JOIN Categories
ON Products.CategoryID = Categories.CategoryID
GROUP BY
CategoryName
ORDER BY
COUNT(*) DESC

--2. Total customers per country/city
SELECT Country,City,TotalCustomer = COUNT(*)
FROM Customers
GROUP BY Country,City
ORDER BY COUNT(*) DESC

--3. Find products that need reordering
SELECT ProductID,ProductName,UnitsInStock,ReorderLevel
FROM Products
WHERE UnitsInStock <= ReorderLevel
ORDER BY ProductID

--3. Products that need reordering, continued
SELECT ProductID,ProductName,UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued
FROM Products
WHERE UnitsInStock + UnitsOnOrder <= ReorderLevel
AND Discontinued = 0
ORDER BY ProductID

--4. Customer list by region and get nulls at the bottom
SELECT CustomerID,CompanyName,Region
FROM Customers
ORDER BY 
CASE
WHEN Region IS NULL then 1
ELSE 0
END
,Region,CustomerID

--5. High freight charges for top 3 shipping countries
SELECT TOP 3 ShipCountry,AverageFreight = AVG(freight)
FROM Orders
GROUP BY ShipCountry
ORDER BY AverageFreight DESC




SELECT ShipCountry,AverageFreight = AVG(freight)
FROM Orders
GROUP BY ShipCountry
ORDER BY AverageFreight DESC
OFFSET 0 ROWS FETCH FIRST 3 ROWS ONLY


--6. High freight charges - 1997
SELECT TOP 3 ShipCountry,AverageFreight = AVG(freight)
FROM Orders
WHERE OrderDate >= '1997-01-01'
and OrderDate < '1998-01-01'
GROUP BY ShipCountry
ORDER BY AverageFreight DESC

SELECT TOP 3 ShipCountry,AverageFreight = AVG(freight)
FROM Orders
WHERE YEAR(OrderDate) = 1997
GROUP BY ShipCountry
ORDER BY AverageFreight DESC

--7. Get details of high freight charges
SELECT TOP 1 OrderID, SupplierID, CompanyName, ShipCity, ShipCountry, freight AS maxfreight
FROM Orders
INNER JOIN Suppliers
ON Orders.ShipVia = Suppliers.SupplierID
ORDER BY freight DESC

--8. High freight charges - last year
SELECT TOP (3) ShipCountry,AverageFreight = AVG(freight)
FROM Orders
WHERE OrderDate >= DATEADD(yy, -1, (Select MAX(OrderDate) from Orders))
GROUP BY ShipCountry
ORDER BY AverageFreight DESC

--9. Inventory list
SELECT Employees.EmployeeID,Employees.LastName,Orders.OrderID,Products.ProductName,[Order Details].Quantity
FROM Employees
JOIN Orders
ON Orders.EmployeeID = Employees.EmployeeID
JOIN [Order Details]
ON Orders.OrderID = [Order Details].OrderID
JOIN Products
ON Products.ProductID = [Order Details].ProductID
ORDER BY Orders.OrderID,Products.ProductID

--10. Customers with no orders
SELECT Customers_CustomerID = Customers.CustomerID,Orders_CustomerID = Orders.CustomerID
FROM Customers
LEFT JOIN Orders
ON Orders.CustomerID = Customers.CustomerID
WHERE Orders.CustomerID IS NULL

SELECT CustomerID
FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders)


SELECT CustomerID
FROM Customers
WHERE NOT EXISTS
(
SELECT CustomerID
FROM Orders
WHERE
Orders.CustomerID = Customers.CustomerID
)

--11. Customers with no orders for EmployeeID 4
SELECT Customers.CustomerID,Orders.CustomerID
FROM Customers
LEFT JOIN Orders
ON Orders.CustomerID = Customers.CustomerID
AND Orders.EmployeeID = 4
WHERE
Orders.CustomerID is null


SELECT CustomerID
FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders WHERE EmployeeID = 4)



SELECT CustomerID
FROM Customers
WHERE NOT EXISTS
(
SELECT CustomerID
FROM Orders
WHERE Orders.CustomerID = Customers.CustomerID
AND EmployeeID = 4
)


--Advanced Problems
--1. High-value customers
SELECT 
Customers.CustomerID
,Customers.CompanyName
,Orders.OrderID
,TotalOrderAmount = SUM(Quantity * UnitPrice)
FROM Customers
JOIN Orders
ON Orders.CustomerID = Customers.CustomerID
JOIN [Order Details]
ON Orders.OrderID = [Order Details].OrderID
WHERE
OrderDate >= '1996-01-01'
AND OrderDate < '1999-01-01'
GROUP BY
Customers.CustomerID
,Customers.CompanyName
,Orders.Orderid
HAVING SUM(Quantity * UnitPrice) > 10000
ORDER BY TotalOrderAmount DESC


--2. High-value customers - total orders
SELECT
Customers.CustomerID
,Customers.CompanyName
,TotalOrders = SUM(Quantity)
FROM Customers
JOIN Orders
ON Orders.CustomerID = Customers.CustomerID
JOIN [Order Details]
ON Orders.OrderID = [Order Details].OrderID
WHERE
OrderDate >= '1996-01-01'
AND OrderDate < '1999-01-01'
GROUP BY
Customers.CustomerID
,Customers.CompanyName
HAVING SUM(Quantity) >=1000
ORDER BY TotalOrders DESC

--3. High-value customers - with discount
SELECT
Customers.CustomerID
,Customers.CompanyName
,TotalOrders = SUM(Quantity)
,TotalsWithoutDiscount = SUM(Quantity * UnitPrice)
,TotalsWithDiscount = SUM(Quantity * UnitPrice * (1- Discount))
FROM Customers
JOIN Orders
ON Orders.CustomerID = Customers.CustomerID
JOIN [Order Details]
ON Orders.OrderID = [Order Details].OrderID
WHERE
OrderDate >= '1996-01-01'
AND OrderDate < '1999-01-01'
GROUP BY
Customers.CustomerID
,Customers.CompanyName
HAVING SUM(Quantity * UnitPrice * (1- Discount))> 15000
ORDER BY TotalsWithDiscount DESC;

--4. Month-end orders for employees in 1998
SELECT
EmployeeID
,OrderID
,OrderDate
FROM Orders
WHERE OrderDate = EOMONTH(OrderDate )
AND YEAR(OrderDate) = 1998
ORDER BY EmployeeID,OrderID

--5. Orders with many line items
SELECT TOP 10 WITH TIES
Orders.OrderID
,TotalOrderDetails = COUNT(*)
FROM Orders
JOIN [Order Details]
ON Orders.OrderID = [Order Details].OrderID
GROUP BY Orders.OrderID
ORDER BY COUNT(*) DESC

--6. Orders - random assortment
SELECT TOP 2 PERCENT
OrderID
FROM Orders
ORDER BY NewID()

--7. Orders - accidental double-entry
SELECT
OrderID
FROM [Order Details]
WHERE Quantity >= 60
GROUP BY
OrderID
,Quantity
HAVING COUNT(*) > 1

--8. Orders - accidental double-entry details

WITH PotentialDuplicates AS (
SELECT
OrderID
FROM [Order Details]
WHERE Quantity >= 60
GROUP BY OrderID, Quantity
HAVING COUNT(*) > 1
)
SELECT
OrderID
,ProductID
,UnitPrice
,Quantity
,Discount
FROM [Order Details]
WHERE
OrderID IN (SELECT OrderID FROM PotentialDuplicates)
ORDER BY
OrderID
,Quantity

--9. Orders Shipped Late

SELECT
OrderID
,OrderDate = CONVERT(DATE, OrderDate)
,RequiredDate = CONVERT(DATE, RequiredDate)
,ShippedDate = CONVERT(DATE, ShippedDate)
FROM Orders
WHERE
RequiredDate <= ShippedDate

--10. Which salespeople have the most orders arriving late?

SELECT
Employees.EmployeeID
,LastName
,TotalLateOrders = COUNT(*)
FROM Orders
JOIN Employees
ON Employees.EmployeeID = Orders.EmployeeID
WHERE
RequiredDate <= ShippedDate
GROUP BY Employees.EmployeeID
,Employees.LastName
ORDER BY TotalLateOrders DESC

--11. For each employee compare Late orders vs. total orders
WITH LateOrders AS 
(
SELECT EmployeeID,TotalOrders = COUNT(*)
FROM Orders
WHERE RequiredDate <= ShippedDate
GROUP BY EmployeeID
),
AllOrders AS
(
SELECT EmployeeID,TotalOrders = COUNT(*)
FROM Orders
GROUP BY EmployeeID
)
SELECT Employees.EmployeeID, LastName
,AllOrders = AllOrders.TotalOrders
,LateOrders = LateOrders.TotalOrders
FROM Employees
JOIN AllOrders
ON AllOrders.EmployeeID = Employees.EmployeeID
JOIN LateOrders
ON LateOrders.EmployeeID = Employees.EmployeeID

--12. Late orders vs. total orders - percentage
WITH LateOrders AS
(
SELECT EmployeeID,TotalOrders = COUNT(*)
FROM Orders
WHERE RequiredDate <= ShippedDate
GROUP BY EmployeeID
),
AllOrders AS (
SELECT EmployeeID,TotalOrders = COUNT(*)
FROM Orders
GROUP BY EmployeeID
)
SELECT Employees.EmployeeID,LastName
,AllOrders = AllOrders.TotalOrders
,LateOrders = LateOrders.TotalOrders
,PercentLateOrders = ROUND(LateOrders.TotalOrders*100,2 )/ AllOrders.TotalOrders
FROM Employees
JOIN AllOrders
on AllOrders.EmployeeID = Employees.EmployeeID
LEFT JOIN LateOrders
ON LateOrders.EmployeeID = Employees.EmployeeID

--13. Customer grouping
WITH Orders1996 AS
(
SELECT Customers.CustomerID,Customers.CompanyName
,TotalOrderAmount = SUM(Quantity * UnitPrice)
FROM Customers
JOIN Orders
ON Orders.CustomerID = Customers.CustomerID
JOIN [Order Details]
ON Orders.OrderID = [Order Details].OrderID
WHERE OrderDate >= '1996-01-01'and OrderDate < '1997-01-01'
GROUP BY
Customers.CustomerID,Customers.CompanyName
)
SELECT CustomerID,CompanyName
,TotalOrderAmount,
CustomerGroup =
CASE
WHEN TotalOrderAmount BETWEEN 0 AND 1000 THEN 'Low'
WHEN TotalOrderAmount BETWEEN 1001 AND 5000 THEN 'Medium'
WHEN TotalOrderAmount BETWEEN 5001 AND 10000 THEN 'High'
WHEN TotalOrderAmount > 10000 THEN 'Very High'
END
FROM Orders1996
ORDER BY CustomerGroup

--14. Customer grouping with percentage
WITH Orders1996 AS
(
SELECT Customers.CustomerID,Customers.CompanyName
,TotalOrderAmount = SUM(Quantity * UnitPrice)
FROM Customers
JOIN Orders
ON Orders.CustomerID = Customers.CustomerID
JOIN [Order Details]
ON Orders.OrderID = [Order Details].OrderID
WHERE OrderDate >= '1996-01-01'and OrderDate < '1997-01-01'
GROUP BY
Customers.CustomerID,Customers.CompanyName
)
,CustomerGrouping AS
(
SELECT CustomerID,CompanyName
,TotalOrderAmount,
CustomerGroup =
CASE
WHEN TotalOrderAmount BETWEEN 0 AND 1000 THEN 'Low'
WHEN TotalOrderAmount BETWEEN 1001 AND 5000 THEN 'Medium'
WHEN TotalOrderAmount BETWEEN 5001 AND 10000 THEN 'High'
WHEN TotalOrderAmount > 10000 THEN 'Very High'
END
FROM Orders1996
)
SELECT CustomerGroup, TotalInGroup = COUNT(*), 
PercentageInGroup = COUNT(*) * 100/ (SELECT COUNT(*) FROM CustomerGrouping)
FROM CustomerGrouping
GROUP BY CustomerGroup
ORDER BY TotalInGroup DESC

--15. Countries with suppliers or customers
SELECT Country FROM Customers
UNION
SELECT Country FROM Suppliers
ORDER BY Country

--16. Countries with suppliers or customers, version 2
WITH SupplierCountries AS
(SELECT DISTINCT Country FROM Suppliers)
,CustomerCountries AS
(SELECT DISTINCT Country FROM Customers)
SELECT
SupplierCountry = SupplierCountries .Country
,CustomerCountry = CustomerCountries .Country
FROM SupplierCountries
FULL OUTER JOIN CustomerCountries
ON CustomerCountries.Country = SupplierCountries.Country

--17. Countries with suppliers or customers - version 3
WITH SupplierCountries AS
(SELECT Country , Total = COUNT(*) FROM Suppliers GROUP BY Country)
,CustomerCountries AS
(SELECT Country , Total = COUNT(*) FROM Customers GROUP BY Country)
SELECT
Country = ISNULL( SupplierCountries.Country, CustomerCountries.Country)
,TotalSuppliers= ISNULL(SupplierCountries.Total,0)
,TotalCustomers= ISNULL(CustomerCountries.Total,0)
FROM SupplierCountries
FULL OUTER JOIN CustomerCountries
ON CustomerCountries.Country = SupplierCountries.Country

--18. First order in each country
WITH OrdersByCountry AS
(
SELECT ShipCountry,CustomerID,OrderID
,OrderDate = CONVERT(DATE, OrderDate)
,RowNumberPerCountry =
ROW_NUMBER()
OVER (PARTITION BY ShipCountry ORDER BY ShipCountry, CONVERT(DATE, OrderDate))
FROM Orders
)
SELECT ShipCountry,CustomerID,OrderID,OrderDate
FROM OrdersByCountry
WHERE RowNumberPerCountry = 1
ORDER BY ShipCountry

--19. Customers with multiple orders in 5 day period
SELECT 
InitialOrder.CustomerID
,InitialOrderID = InitialOrder.OrderID
,InitialOrderDate = CONVERT(DATE, InitialOrder.OrderDate)
,NextOrderID = NextOrder.OrderID
,NextOrderDate = CONVERT(DATE, NextOrder.OrderDate)
,DaysBetween = DATEDIFF(dd, InitialOrder.OrderDate, NextOrder.OrderDate)
FROM Orders InitialOrder
JOIN Orders NextOrder
ON InitialOrder.CustomerID = NextOrder.CustomerID
WHERE
InitialOrder.OrderID < NextOrder.OrderID
AND DATEDIFF(dd, InitialOrder.OrderDate, NextOrder.OrderDate) <= 5
ORDER BY
InitialOrder.CustomerID
,InitialOrder.OrderID

--20. Customers with multiple orders in 5 day period, version
WITH NextOrderDate AS 
(
SELECT CustomerID
,OrderDate = CONVERT(DATE, OrderDate)
,NextOrderDate = CONVERT(DATE,LEAD(OrderDate,1)
OVER (PARTITION BY CustomerID ORDER BY CustomerID, OrderDate)
)
FROM Orders
)
SELECT CustomerID, OrderDate, NextOrderDate
,DaysBetweenOrders = DateDiff (dd, OrderDate, NextOrderDate)
FROM NextOrderDate
WHERE DateDiff (dd, OrderDate, NextOrderDate) <= 5