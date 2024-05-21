-- Crear el keyspace 'tienda' con la estrategia de replicación
CREATE KEYSPACE IF NOT EXISTS tienda WITH REPLICATION = {
    'class' : 'SimpleStrategy',
    'replication_factor' : 2
};

-- Crear la tabla Usuario
CREATE TABLE IF NOT EXISTS tienda.Usuario (
    email TEXT PRIMARY KEY
);

-- Crear la tabla Productos
CREATE TABLE IF NOT EXISTS tienda.Productos (
    idProducto UUID PRIMARY KEY,
    precio DECIMAL,
    stock INT
);

-- Crear la tabla Pedido
CREATE TABLE tienda.Pedido (
    idPedido UUID PRIMARY KEY,
    direccion TEXT,
    precioTotal DECIMAL,
    fechaEntrega TIMESTAMP,
    autor TEXT
);

-- Crear la tabla Pedido_Producto
CREATE TABLE IF NOT EXISTS tienda.Pedido_Producto (
    idPedido UUID,
    idProducto UUID,
    cantidad INT,
    PRIMARY KEY (idPedido, idProducto)
);

-- Insertar datos en la tabla Usuario
INSERT INTO tienda.Usuario (email) VALUES ('usuario1@example.com');
INSERT INTO tienda.Usuario (email) VALUES ('usuario2@example.com');
INSERT INTO tienda.Usuario (email) VALUES ('usuario3@example.com');

-- Insertar datos en la tabla Productos
INSERT INTO tienda.Productos (idProducto, precio, stock) VALUES (uuid(), 10.50, 100);
INSERT INTO tienda.Productos (idProducto, precio, stock) VALUES (uuid(), 25.00, 50);
INSERT INTO tienda.Productos (idProducto, precio, stock) VALUES (uuid(), 5.99, 200);

-- Insertar datos en la tabla Pedido
INSERT INTO tienda.Pedido (idPedido, direccion, precioTotal, fechaEntrega, autor) VALUES (uuid(), 'Calle 123', 21.00, '2024-05-15 12:00:00', 'usuario1@example.com');

-- Obtener los UUID generados para las filas recién insertadas en las tablas Pedido y Productos
SELECT idPedido FROM tienda.Pedido WHERE direccion = 'Calle 123' ALLOW FILTERING;
SELECT idProducto FROM tienda.Productos WHERE precio = 10.50 ALLOW FILTERING;

-- Insertar datos en la tabla Pedido_Producto utilizando los UUID obtenidos
-- INSERT INTO tienda.Pedido_Producto (idPedido, idProducto, cantidad) VALUES (cdac6603-4c23-4465-a76d-3d3ca7398a43, 7f29eb8c-d141-41ce-8911-4b1fccf73329, 2);
