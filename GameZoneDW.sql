create database GameZoneDW;

USE GameZoneDW;
GO

CREATE TABLE DimFecha (
    FechaKey INT PRIMARY KEY,
    FechaCompleta DATE NOT NULL UNIQUE,
    Dia TINYINT NOT NULL,
    Mes TINYINT NOT NULL,
    NombreMes VARCHAR(20) NOT NULL,
    Trimestre TINYINT NOT NULL,
    Anio SMALLINT NOT NULL,
    DiaSemana VARCHAR(20) NOT NULL
);
GO

CREATE TABLE DimProducto (
    ProductoKey INT IDENTITY(1,1) PRIMARY KEY,
    NombreProducto VARCHAR(150) NOT NULL,
    Categoria VARCHAR(50) NOT NULL,
    Plataforma VARCHAR(50) NOT NULL,
    TipoProducto VARCHAR(50) NOT NULL,
    Clasificacion VARCHAR(20) NULL,
    PrecioLista DECIMAL(10,2) NOT NULL
);
GO

CREATE TABLE DimCliente (
    ClienteKey INT IDENTITY(1,1) PRIMARY KEY,
    NombreCliente VARCHAR(120) NOT NULL,
    Correo VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20) NULL,
    Ciudad VARCHAR(80) NOT NULL,
    Estado VARCHAR(80) NOT NULL
);
GO

CREATE TABLE DimEmpleado (
    EmpleadoKey INT IDENTITY(1,1) PRIMARY KEY,
    NombreEmpleado VARCHAR(120) NOT NULL,
    Puesto VARCHAR(60) NOT NULL,
    Turno VARCHAR(30) NOT NULL
);
GO

CREATE TABLE DimSucursal (
    SucursalKey INT IDENTITY(1,1) PRIMARY KEY,
    NombreSucursal VARCHAR(100) NOT NULL,
    Ciudad VARCHAR(80) NOT NULL,
    Estado VARCHAR(80) NOT NULL,
    Direccion VARCHAR(200) NOT NULL
);
GO


CREATE TABLE FactVentas (
    VentaKey INT IDENTITY(1,1) PRIMARY KEY,
    NumeroTicket VARCHAR(20) NOT NULL,

    FechaKey INT NOT NULL,
    ProductoKey INT NOT NULL,
    ClienteKey INT NOT NULL,
    EmpleadoKey INT NOT NULL,
    SucursalKey INT NOT NULL,

    Cantidad INT NOT NULL,
    PrecioUnitario DECIMAL(10,2) NOT NULL,
    Descuento DECIMAL(10,2) NOT NULL DEFAULT 0,

    TotalVenta AS ((Cantidad * PrecioUnitario) - Descuento) PERSISTED,

    CONSTRAINT FK_FactVentas_Fecha
        FOREIGN KEY (FechaKey) REFERENCES DimFecha(FechaKey),

    CONSTRAINT FK_FactVentas_Producto
        FOREIGN KEY (ProductoKey) REFERENCES DimProducto(ProductoKey),

    CONSTRAINT FK_FactVentas_Cliente
        FOREIGN KEY (ClienteKey) REFERENCES DimCliente(ClienteKey),

    CONSTRAINT FK_FactVentas_Empleado
        FOREIGN KEY (EmpleadoKey) REFERENCES DimEmpleado(EmpleadoKey),

    CONSTRAINT FK_FactVentas_Sucursal
        FOREIGN KEY (SucursalKey) REFERENCES DimSucursal(SucursalKey)
);
GO

USE GameZoneDW;
GO

INSERT INTO DimFecha
(FechaKey, FechaCompleta, Dia, Mes, NombreMes, Trimestre, Anio, DiaSemana)
VALUES
(20260601, '2026-06-01', 1, 6, 'Junio', 2, 2026, 'Lunes'),
(20260602, '2026-06-02', 2, 6, 'Junio', 2, 2026, 'Martes'),
(20260603, '2026-06-03', 3, 6, 'Junio', 2, 2026, 'Miércoles'),
(20260604, '2026-06-04', 4, 6, 'Junio', 2, 2026, 'Jueves'),
(20260605, '2026-06-05', 5, 6, 'Junio', 2, 2026, 'Viernes'),
(20260606, '2026-06-06', 6, 6, 'Junio', 2, 2026, 'Sábado'),
(20260607, '2026-06-07', 7, 6, 'Junio', 2, 2026, 'Domingo');
GO


SELECT * FROM DimFecha;


INSERT INTO DimProducto
(NombreProducto, Categoria, Plataforma, TipoProducto, Clasificacion, PrecioLista)
VALUES
('Grand Theft Auto V', 'Videojuego', 'PlayStation 5', 'Fisico', 'M', 899.00),
('EA Sports FC 26', 'Videojuego', 'Xbox Series X|S', 'Fisico', 'E', 1299.00),
('The Legend of Zelda: Tears of the Kingdom', 'Videojuego', 'Nintendo Switch', 'Fisico', 'E10+', 1199.00),
('Minecraft', 'Videojuego', 'PC', 'Digital', 'E10+', 599.00),
('PlayStation 5 Slim', 'Consola', 'PlayStation 5', 'Consola', NULL, 10999.00),
('Nintendo Switch OLED', 'Consola', 'Nintendo Switch', 'Consola', NULL, 7499.00),
('Control DualSense', 'Accesorio', 'PlayStation 5', 'Control', NULL, 1599.00),
('Control Xbox inalambrico', 'Accesorio', 'Xbox Series X|S', 'Control', NULL, 1499.00),
('Audifonos Gamer HyperX', 'Accesorio', 'PC', 'Audifonos', NULL, 1299.00),
('Tarjeta regalo GameZone $500', 'Accesorio', 'Multiplataforma', 'Tarjeta de regalo', NULL, 500.00);
GO

SELECT * FROM DimProducto;

INSERT INTO DimCliente
(NombreCliente, Correo, Telefono, Ciudad, Estado)
VALUES
('Carlos Méndez', 'carlos.mendez@email.com', '9991112233', 'Mérida', 'Yucatán'),
('Mariana López', 'mariana.lopez@email.com', '9992223344', 'Mérida', 'Yucatán'),
('José Ramírez', 'jose.ramirez@email.com', '9993334455', 'Kanasín', 'Yucatán'),
('Ana Torres', 'ana.torres@email.com', '9994445566', 'Valladolid', 'Yucatán'),
('Luis Herrera', 'luis.herrera@email.com', '9995556677', 'Progreso', 'Yucatán');
GO

SELECT * FROM DimCliente;


INSERT INTO DimEmpleado
(NombreEmpleado, Puesto, Turno)
VALUES
('Andrea Castillo', 'Vendedora', 'Matutino'),
('Diego Sánchez', 'Vendedor', 'Vespertino'),
('Fernanda Ruiz', 'Encargada de sucursal', 'Completo');
GO

SELECT * FROM DimEmpleado;

INSERT INTO DimSucursal
(NombreSucursal, Ciudad, Estado, Direccion)
VALUES
('GameZone Plaza Altabrisa', 'Mérida', 'Yucatán', 'Calle 7, Plaza Altabrisa'),
('GameZone Plaza Las Américas', 'Mérida', 'Yucatán', 'Calle 21, Plaza Las Américas'),
('GameZone Valladolid', 'Valladolid', 'Yucatán', 'Calle 40, Centro');
GO

SELECT * FROM DimSucursal;


INSERT INTO FactVentas
(NumeroTicket, FechaKey, ProductoKey, ClienteKey, EmpleadoKey, SucursalKey,
 Cantidad, PrecioUnitario, Descuento)
VALUES
('T-0001', 20260601, 1, 1, 1, 1, 1, 899.00, 0),
('T-0001', 20260601, 7, 1, 1, 1, 1, 1599.00, 100.00),

('T-0002', 20260602, 5, 2, 3, 2, 1, 10999.00, 500.00),
('T-0002', 20260602, 8, 2, 3, 2, 1, 1499.00, 0),

('T-0003', 20260603, 3, 3, 2, 3, 1, 1199.00, 0),
('T-0003', 20260603, 6, 3, 2, 3, 1, 7499.00, 300.00),

('T-0004', 20260604, 4, 4, 1, 1, 2, 599.00, 0),

('T-0005', 20260605, 9, 5, 2, 2, 1, 1299.00, 50.00),

('T-0006', 20260606, 2, 1, 3, 1, 1, 1299.00, 0),
('T-0006', 20260606, 10, 1, 3, 1, 1, 500.00, 0),

('T-0007', 20260607, 7, 2, 1, 2, 1, 1599.00, 0);
GO

SELECT * FROM FactVentas;


SELECT
    p.NombreProducto,
    SUM(f.Cantidad) AS TotalUnidadesVendidas,
    SUM(f.TotalVenta) AS IngresoTotal
FROM FactVentas f
INNER JOIN DimProducto p ON f.ProductoKey = p.ProductoKey
GROUP BY p.NombreProducto
ORDER BY IngresoTotal DESC;

SELECT
    s.NombreSucursal,
    SUM(f.TotalVenta) AS TotalVendido
FROM FactVentas f
INNER JOIN DimSucursal s ON f.SucursalKey = s.SucursalKey
GROUP BY s.NombreSucursal
ORDER BY TotalVendido DESC;


SELECT
    e.NombreEmpleado,
    SUM(f.TotalVenta) AS TotalVendido
FROM FactVentas f
INNER JOIN DimEmpleado e ON f.EmpleadoKey = e.EmpleadoKey
GROUP BY e.NombreEmpleado
ORDER BY TotalVendido DESC;


SELECT
    p.Categoria,
    SUM(f.Cantidad) AS ProductosVendidos,
    SUM(f.TotalVenta) AS IngresoTotal
FROM FactVentas f
INNER JOIN DimProducto p ON f.ProductoKey = p.ProductoKey
GROUP BY p.Categoria
ORDER BY IngresoTotal DESC;