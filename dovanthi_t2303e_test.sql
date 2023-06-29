-- Do Van Thi - T2303E

-- cau 1
CREATE DATABASE SellingPoint;

-- cau 2
CREATE TABLE Categories (
    CateID CHAR(6) primary key,
    CateName nvarchar(100) NOT NULL,
    Description nvarchar(200)
);


CREATE TABLE Parts (
    PartID INT primary key IDENTITY(1,1),
    PartName nvarchar(100) NOT NULL,
    CateID CHAR(6) foreign key references Categories(CateID),
    Description nvarchar(1000),
    Price MONEY NOT NULL DEFAULT 0,
    Quantity INT DEFAULT 0,
    Warranty INT DEFAULT 1,
    Photo nvarchar(200) DEFAULT 'photo/nophoto.png'
);


-- cau 3
INSERT INTO Categories (CateID, CateName, Description)
VALUES ('RAM001', 'RAM', N'Random access memory'),
       ('CPU001', 'CPU', N'Central processing unit'),
       ('SSD001', 'SSD', N'Solid state drive');

INSERT INTO Parts (PartName, CateID, Description, Price, Quantity, Warranty)
VALUES ('8GB RAM', 'RAM001', N'Random access memory', 20, 100, 36),
       ('Core i9', 'CPU001', N'Central processing unit', 500, 200, 12),
       ('500GB SSD', 'SSD001', N'Solid state drive', 100, 300, 24),
	   ('5GB RAM', 'RAM001', N'Random access memory', 10, 50, 36),
       ('Core i10', 'CPU001', N'Central processing unit', 800, 100, 12),
       ('200GB SSD', 'SSD001', N'Solid state drive', 80, 200, 24);

-- Cau 4
SELECT * FROM Parts WHERE Price > 100;

-- Cau 5 --cach 1
SELECT p.* FROM Parts p
INNER JOIN Categories c ON p.CateID = c.CateID
WHERE c.CateName = 'CPU';
-- Cau 5 --cach 2
SELECT * FROM Parts p WHERE p.CateID
in (SELECT CateID FROM Categories c WHERE c.CateName = 'CPU') ;

-- cau 6
CREATE VIEW v_Parts AS
SELECT p.PartID, p.PartName, c.CateName, p.Price, p.Quantity
FROM Parts p
INNER JOIN Categories c ON p.CateID = c.CateID;
SELECT * FROM v_Parts;

-- cau 7
CREATE VIEW v_TopParts AS
SELECT TOP 5 PartID, PartName, CateName, Price, Quantity
FROM v_Parts
ORDER BY Price DESC;
SELECT * FROM v_TopParts;
