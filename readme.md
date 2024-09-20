# SQL Database with YugabyteDB

### Overview:

This project involves creating a complex relational database in YugabyteDB with 20 tables that represent a company’s operations. The database includes tables for customers, orders, products, employees, departments, and more. The diagram will highlight relationships such as one-to-many (e.g., customers and orders) and many-to-many (e.g., products and categories) using junction tables. YugabyteDB, a high-performance distributed SQL database, will be used for scalable and fault-tolerant storage.

### Objectives:

1.  **Design a database schema** with 20 tables and their relationships.
2.  **Write SQL scripts** to create tables and relationships using YugabyteDB.
3.  **Provide common SQL queries** to retrieve data such as customer orders, product information, and employee reports.

----------

### Database Diagram:

Below is a summary of the relationships, followed by a description of the tables and their SQL definitions.

-   **Customers**: Contains information about customers.
-   **Orders**: Tracks customer orders.
-   **Products**: List of available products.
-   **Employees**: Company employees who handle orders and other operations.
-   **Departments**: The department in which employees work.
-   **Categories**: Categories for products.
-   **Suppliers**: Suppliers who provide products.
-   **Shippers**: Tracks shipping companies.
-   **OrderDetails**: Line items for each order.
-   **ProductCategories**: A junction table for many-to-many relationship between products and categories.

### Diagram Structure:

-   **One-to-Many**:
    -   Customers ↔ Orders
    -   Employees ↔ Orders
    -   Departments ↔ Employees
    -   Suppliers ↔ Products
    -   Orders ↔ Shippers
-   **Many-to-Many**:
    -   Products ↔ Categories (via ProductCategories)

----------

### 1. SQL Table Definitions

#### 1.1 Customers Table:


```sql
CREATE TABLE Customers (
    CustomerID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(255),
    City VARCHAR(100),
    Country VARCHAR(50),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);```

#### 1.2 Orders Table:


```sql
CREATE TABLE Orders (
    OrderID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    CustomerID UUID,
    EmployeeID UUID,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ShipperID UUID,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ShipperID) REFERENCES Shippers(ShipperID)
);
```

#### 1.3 Products Table:


```sql
CREATE TABLE Products (
    ProductID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    ProductName VARCHAR(100),
    SupplierID UUID,
    Price DECIMAL(10, 2),
    Stock INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);
```

#### 1.4 OrderDetails Table (for Order Line Items):


```sql
CREATE TABLE OrderDetails (
    OrderID UUID,
    ProductID UUID,
    Quantity INT,
    Price DECIMAL(10, 2),
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
```

#### 1.5 Employees Table:


```sql
CREATE TABLE Employees (
    EmployeeID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    DepartmentID UUID,
    HireDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
```

#### 1.6 Departments Table:


```sql
CREATE TABLE Departments (
    DepartmentID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    DepartmentName VARCHAR(100)
);
```

#### 1.7 Categories Table:


```sql
CREATE TABLE Categories (
    CategoryID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    CategoryName VARCHAR(100)
);
```

#### 1.8 ProductCategories Table (Junction Table for Products and Categories):


```sql
CREATE TABLE ProductCategories (
    ProductID UUID,
    CategoryID UUID,
    PRIMARY KEY (ProductID, CategoryID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
```

#### 1.9 Suppliers Table:


```sql
CREATE TABLE Suppliers (
    SupplierID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    SupplierName VARCHAR(100),
    ContactName VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(255)
);
```

#### 1.10 Shippers Table:


```sql
CREATE TABLE Shippers (
    ShipperID UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    ShipperName VARCHAR(100),
    Phone VARCHAR(15)
);
```

----------

### 2. Common SQL Queries

#### 2.1 Retrieve All Orders for a Specific Customer:


```sql
SELECT Orders.OrderID, Orders.OrderDate, Orders.TotalAmount
FROM Orders
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.Email = 'customer@example.com';
``` 

#### 2.2 List Products and Their Categories:


```sql
SELECT Products.ProductName, Categories.CategoryName
FROM Products
JOIN ProductCategories ON Products.ProductID = ProductCategories.ProductID
JOIN Categories ON ProductCategories.CategoryID = Categories.CategoryID;
``` 

#### 2.3 Show Employees and Their Departments:


```sql
SELECT Employees.FirstName, Employees.LastName, Departments.DepartmentName
FROM Employees
JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;
``` 

#### 2.4 Calculate Total Sales for a Specific Product:


```sql
SELECT Products.ProductName, SUM(OrderDetails.Quantity * OrderDetails.Price) AS TotalSales
FROM Products
JOIN OrderDetails ON Products.ProductID = OrderDetails.ProductID
GROUP BY Products.ProductName
HAVING Products.ProductName = 'ProductName';
``` 

#### 2.5 List of Shippers Used for Orders:


```sql
SELECT DISTINCT Shippers.ShipperName
FROM Orders
JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID;
```


### 3. Sample Database Diagram (High-Level)

1.  **Customers** — (1-to-Many) — **Orders**
2.  **Orders** — (1-to-Many) — **OrderDetails**
3.  **Employees** — (1-to-Many) — **Orders**
4.  **Suppliers** — (1-to-Many) — **Products**
5.  **Categories** — (Many-to-Many) — **Products**
6.  **Departments** — (1-to-Many) — **Employees**

This diagram shows the basic structure and relationships between the tables. You can use a diagramming tool like draw.io, Lucidchart, or DBeaver to create a visual database diagram.

## Sample UUIDs:
For each UUID reference in the Orders, OrderDetails, and ProductCategories tables, you can replace customer-uuid-1, employee-uuid-1, etc., with actual UUIDs generated by YugabyteDB using gen_random_uuid().

To generate a UUID in the YSQL shell:
```sql
SELECT gen_random_uuid();
Use the output UUID to replace placeholders such as customer-uuid-1, order-uuid-1, and product-uuid-1
```