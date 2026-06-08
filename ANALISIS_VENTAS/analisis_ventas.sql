CREATE DATABASE if NOT EXSISTS pintureria_pro;
USE pintureria_pro;

CREATE TABLE marcas (
    id_marca INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    origen VARCHAR(50) NOT NULL
);
CREATE TABLE productos (
    id_producto INT AUTO INCREMENT PRIMARY KEY,
    id_marca INT ,
    unidad_,medida VARCHAR(20) NOT NULL,
    capacidad_unidad DECIMAL(10,2) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock_actual INT NOT NULL,
    FOREIGN KEY (id_marca) REFERENCES marcas(id_marca)

);
CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    fecha_venta DATE NOT NULL,
    cantidad_vendida INT NOT NULL,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)

);
#iNSERCIÓN DE DATOS
INSTERT INTO marcas (nombre, origen)VALUES
('Alba', 'Nacional'),
('Sherwin-Williams', 'Importado'),
('PlastiTek', 'Nacional');

INSERT INTO productos (id_marca, unidad_medida, capacidad_unidad, precio, stock_actual) VALUES
(1, 'Litros', 10.00, 1500.00, 50),
(2, 'Litros', 20.00, 3000.00, 30),
(3, 'Litros', 5.00, 800.00, 100);

INSERT INTO ventas (id_producto, fecha_venta, cantidad_vendida) VALUES
(1, '2023-10-01', 5),
(2, '2023-10-15', 3),
(3, '2023-11-05', 10),
(1, '2023-11-20', 8);

# CONSULTAS DE ANÁLISIS DE DATOS

SELECT  
    m.nombre AS Marca,
    COUNT(v.id_ventas) AS total_ventas,
    SUM(p.precio*v.cantidad_vendida) AS total_facturado
    FROM venats v
    JOIN productos p ON v.id_producto = p.id_producto
    JOIN marcas m ON p.id_marca = m.id_marca
    GROUP BY m.nombre_marca
ORDER BY Facturacion_Total DESC;

SELECT 
    p.nombre_producto AS Producto,
    m.nombre_marca AS Marca,
    p.stock_actual AS Stock_Disponible
FROM productos p
JOIN marcas m ON p.id_marca = m.id_marca
WHERE p.stock_actual <= 3
ORDER BY p.stock_actual ASC;

SELECT 
    p.nombre_producto AS Producto,
    p.unidad_medida AS Unidad_Original,
    p.stock_actual AS Unidades_Stock,
    CASE 
        WHEN p.unidad_medida = 'Galones' THEN ROUND((p.stock_actual * p.capacidad_unidad * 3.78), 2)
        ELSE ROUND((p.stock_actual * p.capacidad_unidad), 2)
    END AS Total_Litros_En_Deposito
FROM productos p; 


