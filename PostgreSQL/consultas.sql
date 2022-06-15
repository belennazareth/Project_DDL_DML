-- ALTERACIÓN DE TABLAS
--1

ALTER TABLE VENDEDORES ADD TIPO VARCHAR(30);

--2

ALTER TABLE VENDEDORES ADD CONSTRAINT CH_VENDEDORTIPO CHECK (TIPO IN ('Franquicia','Autonomo'));

INSERT INTO VENDEDORES VALUES ('1','Juan','ESPAÑA','Franquicia');
INSERT INTO VENDEDORES VALUES ('2','Pedro','ESPAÑA','Autonomo');
INSERT INTO VENDEDORES VALUES ('3','Maria','ESPAÑA','Ninguno');
--3 

ALTER TABLE VENDEDORES DROP COLUMN PAIS;

--4 

ALTER TABLE ARTICULOS ADD CONSTRAINT CH_ARTICULOCODIGO CHECK (CODIGO ~ '^([0-9])+$');

INSERT INTO ARTICULOS VALUES ('1','Pantalones','1',1.5,'Nuevo',10.0);
INSERT INTO ARTICULOS VALUES ('ABC','Pantalones','1',1.5,'Nuevo',10.0);

--5 

ALTER TABLE VENDEDORES DROP CONSTRAINT CH_VENDEDORPAIS;

INSERT INTO VENDEDORES VALUES ('3','Pepe','Franquicia','españa');

--6 

ALTER TABLE TIENDAS DROP CONSTRAINT CH_TIENDANOMBRE;

INSERT INTO TIENDAS VALUES ('Tienda1', 'Madrid', 'Productos variados', 28000);

-- CONSULTAS
--1

SELECT NOMBRE,ESTADO FROM ARTICULOS;

--2

CREATE OR REPLACE VIEW VISTAPEDIDOS AS SELECT CODIGO,FECHA_PEDIDO FROM PEDIDOS;

--3 

SELECT V.NOMBRE, A.NOMBRE FROM VENDEDORES V, ARTICULOS A WHERE V.CODIGO=A.COD_VENDEDOR;  

--4 

SELECT T.*, P.CANTIDAD FROM TIENDAS T, PEDIDOS P WHERE T.NOMBRE=P.NOM_TIENDA; 

--5 

UPDATE ARTICULOS SET PRECIO_VENTA=(PRECIO_VENTA*0.9);

--6 

SELECT CODIGO FROM CLIENTES WHERE FECHA_COMPRA=(SELECT MAX(FECHA_PEDIDO) FROM PEDIDOS);

--7 

DELETE FROM ARTICULOS WHERE COD_VENDEDOR=(SELECT CODIGO FROM VENDEDORES WHERE NOMBRE='Larry');

--8 

SELECT V.NOMBRE,V.PAIS FROM VENDEDORES V, ARTICULOS A ORDER BY A.PRECIO_VENTA ASC;

--9 

SELECT avg(P.CANTIDAD) as 'Media de pedidos' FROM TIENDAS T, PEDIDOS P WHERE T.NOMBRE=P.NOM_TIENDA;

--10 

SELECT A.NOMBRE, V.NOMBRE FROM VENDEDORES V right join ARTICULOS A on V.CODIGO=A.COD_VENDEDOR ORDER BY V.NOMBRE;

--11 

SELECT T.NOMBRE, P.CODIGO, P.FECHA_PEDIDO FROM TIENDAS T, PEDIDOS P WHERE T.NOMBRE=P.NOM_TIENDA AND P.CANTIDAD=(SELECT MAX(P.CANTIDAD) FROM TIENDAS T, PEDIDOS P WHERE T.NOMBRE=P.NOM_TIENDA);

--12 

SELECT V.NOMBRE, V.PAIS, A.NOMBRE FROM VENDEDORES V, ARTICULOS A WHERE V.CODIGO=A.COD_VENDEDOR AND A.PRECIO_VENTA=(SELECT MAX(A.PRECIO_VENTA) FROM VENDEDORES V, ARTICULOS A WHERE V.CODIGO=A.COD_VENDEDOR);

--13

SELECT T.NOMBRE, AVG(P.CANTIDAD) AS "Media de pedidos" FROM TIENDAS T LEFT JOIN PEDIDOS P ON T.NOMBRE=P.NOM_TIENDA GROUP BY T.NOMBRE HAVING MIN(P.CANTIDAD)>2;

--14

CREATE TABLE PEDIDOS_RECHAZADOS (
    CODIGO VARCHAR(10) PRIMARY KEY,
    NOM_TIENDA VARCHAR(10),
    COD_ARTICULO VARCHAR(4),
    FECHA_PEDIDO DATE,
    CANTIDAD NUMERIC (3)
);

INSERT INTO PEDIDOS_RECHAZADOS  SELECT * FROM PEDIDOS WHERE FECHA_PEDIDO>='2022-01-01';

--15

    --
        SELECT NOM_TIENDA FROM PEDIDOS EXCEPT SELECT NOM_TIENDA FROM PEDIDOS_RECHAZADOS;
    --
        SELECT NOM_TIENDA FROM PEDIDOS UNION SELECT NOM_TIENDA FROM PEDIDOS_RECHAZADOS;
    --
        SELECT NOM_TIENDA FROM PEDIDOS INTERSECT SELECT NOM_TIENDA FROM PEDIDOS_RECHAZADOS; 

--16

SELECT * FROM ARTICULOS A WHERE A.PRECIO_VENTA=(SELECT MAX(A2.PRECIO_VENTA) FROM ARTICULOS A2 WHERE A2.COD_VENDEDOR=A.COD_VENDEDOR);