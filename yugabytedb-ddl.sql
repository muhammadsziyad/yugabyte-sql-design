CREATE TABLE Customers (
    CustomerID UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(255),
    City VARCHAR(100),
    Country VARCHAR(50),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Departments (
    DepartmentID UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
    DepartmentName VARCHAR(100)
);

CREATE TABLE Employees (
    EmployeeID UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    DepartmentID UUID,
    HireDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE Categories (
    CategoryID UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
    CategoryName VARCHAR(100)
);

CREATE TABLE ProductCategories (
    ProductID UUID,
    CategoryID UUID,
    PRIMARY KEY (ProductID, CategoryID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE Suppliers (
    SupplierID UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
    SupplierName VARCHAR(100),
    ContactName VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(255)
);

CREATE TABLE Shippers (
    ShipperID UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
    ShipperName VARCHAR(100),
    Phone VARCHAR(15)
);

CREATE TABLE Products (
    ProductID UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
    ProductName VARCHAR(100),
    SupplierID UUID,
    Price DECIMAL(10, 2),
    Stock INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

CREATE TABLE Orders (
    OrderID UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
    CustomerID UUID,
    EmployeeID UUID,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ShipperID UUID,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ShipperID) REFERENCES Shippers(ShipperID)
);


CREATE TABLE OrderDetails (
    OrderID UUID,
    ProductID UUID,
    Quantity INT,
    Price DECIMAL(10, 2),
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


---

INSERT INTO Customers (FirstName, LastName, Email, Phone, Address, City, Country)
VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890', '123 Elm St', 'New York', 'USA'),
('Jane', 'Smith', 'jane.smith@example.com', '2345678901', '456 Oak St', 'San Francisco', 'USA'),
('Mike', 'Johnson', 'mike.johnson@example.com', '3456789012', '789 Pine St', 'Los Angeles', 'USA'),
('Sara', 'Connor', 'sara.connor@example.com', '4567890123', '321 Maple St', 'Chicago', 'USA'),
('Tom', 'Brown', 'tom.brown@example.com', '5678901234', '654 Cedar St', 'Boston', 'USA'),
('Lucy', 'White', 'lucy.white@example.com', '6789012345', '987 Birch St', 'Houston', 'USA'),
('Peter', 'Parker', 'peter.parker@example.com', '7890123456', '111 Spider St', 'Queens', 'USA'),
('Bruce', 'Wayne', 'bruce.wayne@example.com', '8901234567', '222 Gotham St', 'Gotham', 'USA'),
('Clark', 'Kent', 'clark.kent@example.com', '9012345678', '333 Superman St', 'Metropolis', 'USA'),
('Diana', 'Prince', 'diana.prince@example.com', '0123456789', '444 Amazon St', 'Themyscira', 'Wonderland');

INSERT INTO Departments (DepartmentName)
VALUES
('Sales'),
('IT'),
('HR'),
('Marketing'),
('Finance'),
('Logistics'),
('Support'),
('Research'),
('Development'),
('Admin');

select  * from Departments d;

INSERT INTO Employees (FirstName, LastName, Email, Phone, DepartmentID)
VALUES
('James', 'Bond', 'james.bond@example.com', '1122334455', 'bc442528-7672-11ef-aab5-9f5be6a45595'),
('Ethan', 'Hunt', 'ethan.hunt@example.com', '2233445566', 'bc4425fa-7672-11ef-aab5-9f5be6a45595'),
('Lara', 'Croft', 'lara.croft@example.com', '3344556677', 'bc442014-7672-11ef-aab5-9f5be6a45595'),
('Indiana', 'Jones', 'indiana.jones@example.com', '4455667788', 'bc44258c-7672-11ef-aab5-9f5be6a45595'),
('Tony', 'Stark', 'tony.stark@example.com', '5566778899', 'bc4424ba-7672-11ef-aab5-9f5be6a45595'),
('Steve', 'Rogers', 'steve.rogers@example.com', '6677889900', 'bc43b21e-7672-11ef-aab5-9f5be6a45595'),
('Natasha', 'Romanoff', 'natasha.romanoff@example.com', '7788990011', 'bc44238e-7672-11ef-aab5-9f5be6a45595'),
('Bruce', 'Banner', 'bruce.banner@example.com', '8899001122', 'bc4421fe-7672-11ef-aab5-9f5be6a45595'),
('Thor', 'Odinson', 'thor.odinson@example.com', '9900112233', 'bc4422ee-7672-11ef-aab5-9f5be6a45595'),
('Wanda', 'Maximoff', 'wanda.maximoff@example.com', '0011223344', 'bc44242e-7672-11ef-aab5-9f5be6a45595');


select  * from Employees e;

INSERT INTO Categories (CategoryName)
VALUES
('Electronics'),
('Accessories'),
('Office Supplies'),
('Networking'),
('Home Appliances'),
('Audio'),
('Wearable Technology'),
('Computer Hardware'),
('Mobile Devices'),
('Gaming');

select * from categories c;

INSERT INTO Suppliers (SupplierName, ContactName, Phone, Address)
VALUES
('TechWorld', 'Alice Johnson', '1234567890', '123 Tech Lane, New York, USA'),
('MobileMart', 'Bob Smith', '2345678901', '456 Mobile Ave, San Francisco, USA'),
('GadgetPro', 'Carol Davis', '3456789012', '789 Gadget Blvd, Los Angeles, USA'),
('ScreenXperts', 'Dave Wilson', '4567890123', '321 Screen St, Chicago, USA'),
('InputSolutions', 'Eve Martin', '5678901234', '654 Keyboard Rd, Boston, USA'),
('MouseMasters', 'Frank White', '6789012345', '987 Mouse Ln, Houston, USA'),
('PrintWorld', 'Grace Harris', '7890123456', '111 Printer Blvd, Queens, USA'),
('SoundMasters', 'Henry Scott', '8901234567', '222 Headphones St, Gotham, USA'),
('CamVision', 'Ivy Roberts', '9012345678', '333 Webcam Ln, Metropolis, USA'),
('AudioHouse', 'Jack Turner', '0123456789', '444 Speaker Ave, Themyscira, Wonderland');

select  * from Suppliers;

INSERT INTO Shippers (ShipperName, Phone)
VALUES
('FastDelivery', '1234567890'),
('QuickShip', '2345678901'),
('ReliableTransport', '3456789012'),
('SpeedyShipping', '4567890123'),
('GlobalCourier', '5678901234'),
('ExpressShipping', '6789012345'),
('NextDayExpress', '7890123456'),
('PriorityShippers', '8901234567'),
('WorldwideLogistics', '9012345678'),
('EconomyDelivery', '0123456789');

INSERT INTO Products (ProductName, SupplierID, Price, Stock)
VALUES
('Laptop', '2ca9cb2e-7673-11ef-aab5-9f5be6a45595', 799.99, 50),
('Smartphone', '2ca9cb2e-7673-11ef-aab5-9f5be6a45595', 599.99, 200),
('Tablet', '2ca9ccc8-7673-11ef-aab5-9f5be6a45595', 399.99, 150),
('Monitor', '2ca9c854-7673-11ef-aab5-9f5be6a45595', 199.99, 100),
('Keyboard', '2ca9cd4a-7673-11ef-aab5-9f5be6a45595', 49.99, 500),
('Mouse', '2ca9ca98-7673-11ef-aab5-9f5be6a45595', 29.99, 600),
('Printer', '2ca95554-7673-11ef-aab5-9f5be6a45595', 99.99, 80),
('Headphones', '2ca9cdd6-7673-11ef-aab5-9f5be6a45595', 79.99, 400),
('Webcam', '2ca9cc46-7673-11ef-aab5-9f5be6a45595', 49.99, 300),
('Speaker', '2ca9c9c6-7673-11ef-aab5-9f5be6a45595', 89.99, 250);
