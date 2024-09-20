SELECT Orders.OrderID, Orders.OrderDate, Orders.TotalAmount
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.Email = 'customer@example.com';


SELECT Products.ProductName, Categories.CategoryName
FROM Products
JOIN ProductCategories ON Products.ProductID = ProductCategories.ProductID
JOIN Categories ON ProductCategories.CategoryID = Categories.CategoryID;


SELECT Employees.FirstName, Employees.LastName, Departments.DepartmentName
FROM Employees
JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;


SELECT Products.ProductName, SUM(OrderDetails.Quantity * OrderDetails.Price) AS TotalSales
FROM Products
JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY Products.ProductName
HAVING Products.ProductName = 'ProductName';


SELECT DISTINCT Shippers.ShipperName
FROM Orders
JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID;
