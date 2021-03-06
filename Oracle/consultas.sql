-- ALTERACIÓN DE TABLAS
--1

    ALTER TABLE VENDEDORES ADD TIPO VARCHAR2(30);

--2

    ALTER TABLE VENDEDORES ADD CONSTRAINT CH_VENDEDORTIPO CHECK (TIPO IN ('Franquicia','Autonomo'));

    INSERT INTO VENDEDORES VALUES ('1','Juan','ESPAÑA','Franquicia');
    INSERT INTO VENDEDORES VALUES ('2','Pedro','ESPAÑA','Autonomo');
    INSERT INTO VENDEDORES VALUES ('3','Maria','ESPAÑA','Ninguno');

--3 

    ALTER TABLE VENDEDORES DROP COLUMN PAIS;

--4 

    ALTER TABLE ARTICULOS ADD CONSTRAINT CH_ARTICULOCODIGO CHECK (REGEXP_LIKE(CODIGO,'^([0-9])+$'));

    INSERT INTO ARTICULOS VALUES ('1','Pantalones','1',1.5,'Nuevo',10.0);
    INSERT INTO ARTICULOS VALUES ('ABC','Pantalones','1',1.5,'Nuevo',10.0);

--5 

    ALTER TABLE VENDEDORES DROP CONSTRAINT CH_VENDEDORPAIS;

    INSERT INTO VENDEDORES VALUES ('3','Pepe','españa','Franquicia');

--6 

    ALTER TABLE TIENDAS DISABLE CONSTRAINT CH_TIENDANOMBRE;

    INSERT INTO TIENDAS VALUES ('Tienda1', 'Madrid', 'Productos variados', 28000);

    ALTER TABLE TIENDAS ENABLE CONSTRAINT CH_TIENDANOMBRE;

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

    SELECT avg(P.CANTIDAD) AS "Media de pedidos" FROM TIENDAS T, PEDIDOS P WHERE T.NOMBRE=P.NOM_TIENDA;

--10 

    SELECT A.NOMBRE, V.NOMBRE FROM VENDEDORES V right join ARTICULOS A on V.CODIGO=A.COD_VENDEDOR ORDER BY V.NOMBRE;

--11 

    SELECT T.NOMBRE, P.CODIGO, P.FECHA_PEDIDO FROM TIENDAS T, PEDIDOS P WHERE T.NOMBRE=P.NOM_TIENDA AND P.CANTIDAD=(SELECT MAX(P.CANTIDAD) FROM TIENDAS T, PEDIDOS P WHERE T.NOMBRE=P.NOM_TIENDA);

--12 

    SELECT V.NOMBRE, V.PAIS, A.NOMBRE FROM VENDEDORES V, ARTICULOS A WHERE V.CODIGO=A.COD_VENDEDOR AND A.PRECIO_VENTA=(SELECT MAX(A.PRECIO_VENTA) FROM VENDEDORES V, ARTICULOS A WHERE V.CODIGO=A.COD_VENDEDOR);

--13  

    SELECT T.NOMBRE, NVL(AVG(P.CANTIDAD),0) AS "Media de pedidos" FROM TIENDAS T LEFT JOIN PEDIDOS P ON T.NOMBRE=P.NOM_TIENDA GROUP BY T.NOMBRE;

--14

    CREATE TABLE PEDIDOS_RECHAZADOS (
        CODIGO VARCHAR2(10) PRIMARY KEY,
        NOM_TIENDA VARCHAR2(10),
        COD_ARTICULO VARCHAR2(4),
        FECHA_PEDIDO DATE,
        CANTIDAD NUMBER (3)
    );

    INSERT INTO PEDIDOS_RECHAZADOS  SELECT * FROM PEDIDOS WHERE FECHA_PEDIDO>=to_date('2022-01-01','yyyy-mm-dd');

--15

    --
        SELECT NOM_TIENDA FROM PEDIDOS MINUS SELECT NOM_TIENDA FROM PEDIDOS_RECHAZADOS;
    --
        SELECT NOM_TIENDA FROM PEDIDOS UNION SELECT NOM_TIENDA FROM PEDIDOS_RECHAZADOS;
    --
        SELECT NOM_TIENDA FROM PEDIDOS INTERSECT SELECT NOM_TIENDA FROM PEDIDOS_RECHAZADOS;        


--16 

    SELECT * FROM ARTICULOS A WHERE A.PRECIO_VENTA=(SELECT MAX(A2.PRECIO_VENTA) FROM ARTICULOS A2 WHERE A2.COD_VENDEDOR=A.COD_VENDEDOR);

--17 

    SELECT NOM_TIENDA, CANTIDAD FROM PEDIDOS GROUP BY NOM_TIENDA,CANTIDAD HAVING CANTIDAD>=2;

--Funciones
--1 

    CREATE OR REPLACE FUNCTION COUNT_ARTICULOS_ESTADO(P_ESTADO ARTICULOS.ESTADO%TYPE) 
    RETURN NUMBER 
    IS
    V_CANTIDAD NUMBER; 
    
    BEGIN 
        SELECT COUNT(*) INTO V_CANTIDAD FROM ARTICULOS WHERE P_ESTADO=ESTADO; 
        RETURN V_CANTIDAD;
    END;
    /

    CREATE OR REPLACE PROCEDURE P_COUNT_ARTICULOS_ESTADO(P_ESTADO ARTICULOS.ESTADO%TYPE)
    IS
        V_CANTIDAD Number;
    BEGIN
        V_CANTIDAD := COUNT_ARTICULOS_ESTADO(P_ESTADO);
        DBMS_OUTPUT.PUT_LINE('Hay '||V_CANTIDAD||' artículos '||P_ESTADO);
    END;
    /

--2 
    
    CREATE OR REPLACE FUNCTION COUNT_PEDIDOS_CATEGORIA(P_CATEGORIA TIENDAS.CATEGORIAS%TYPE)
    RETURN PEDIDOS.CANTIDAD%TYPE
    IS
        V_CANTIDAD PEDIDOS.CANTIDAD%TYPE;
    BEGIN
        SELECT SUM(P.CANTIDAD) INTO V_CANTIDAD
        FROM PEDIDOS P, TIENDAS T
        WHERE T.CATEGORIAS = P_CATEGORIA
        AND P.NOM_TIENDA = T.NOMBRE;
        RETURN V_CANTIDAD;
    END;
    /

    CREATE OR REPLACE PROCEDURE TEST_PEDIDOS_CATEGORIA(P_CATEGORIA TIENDAS.CATEGORIAS%TYPE)
    IS
        V_CANTIDAD PEDIDOS.CANTIDAD%TYPE;
    BEGIN
        V_CANTIDAD := COUNT_PEDIDOS_CATEGORIA(P_CATEGORIA);
        DBMS_OUTPUT.PUT_LINE('Cantidad de pedidos de la categoría '||P_CATEGORIA|| ': '||V_CANTIDAD);
    END;
    /

--Procedimientos
--1 

    CREATE OR REPLACE PROCEDURE P_ARTICULOS_VENDEDOR(P_VENDEDOR VENDEDORES.NOMBRE%TYPE)
    IS
        CURSOR C_ARTICULOS IS 
            SELECT NOMBRE FROM ARTICULOS WHERE COD_VENDEDOR = 
            (SELECT CODIGO FROM VENDEDORES WHERE NOMBRE=P_VENDEDOR);

    BEGIN  

        FOR V_ARTICULOS IN C_ARTICULOS LOOP
            DBMS_OUTPUT.PUT_LINE(V_ARTICULOS.NOMBRE);
        END LOOP;
    END;
    /

--2 

    CREATE OR REPLACE PROCEDURE P_PEDIDOS_FECHA(P_FECHA PEDIDOS.FECHA_PEDIDO%TYPE)
    IS
        CURSOR C_PEDIDOS IS
            SELECT NOM_TIENDA, CANTIDAD FROM PEDIDOS WHERE FECHA_PEDIDO = P_FECHA;
    BEGIN
        FOR V_PEDIDOS IN C_PEDIDOS LOOP
            DBMS_OUTPUT.PUT_LINE(V_PEDIDOS.NOM_TIENDA||' '||V_PEDIDOS.CANTIDAD);
        END LOOP;
    END;
    /

--3 
    
    CREATE OR REPLACE PROCEDURE P_PRECIO_VENTA_ESTADO(P_ESTADO ARTICULOS.ESTADO%TYPE)
    IS 
        V_PRECIO_VENTA_MAX NUMBER;
        V_PRECIO_VENTA_MIN NUMBER;
        V_PRECIO_VENTA_MED NUMBER;
    BEGIN
        SELECT MAX(PRECIO_VENTA) INTO V_PRECIO_VENTA_MAX FROM ARTICULOS WHERE ESTADO=P_ESTADO;
        SELECT MIN(PRECIO_VENTA) INTO V_PRECIO_VENTA_MIN FROM ARTICULOS WHERE ESTADO=P_ESTADO;
        SELECT AVG(PRECIO_VENTA) INTO V_PRECIO_VENTA_MED FROM ARTICULOS WHERE ESTADO=P_ESTADO;
        DBMS_OUTPUT.PUT_LINE('Precio de venta máximo: '||V_PRECIO_VENTA_MAX);
        DBMS_OUTPUT.PUT_LINE('Precio de venta mínimo: '||V_PRECIO_VENTA_MIN);
        DBMS_OUTPUT.PUT_LINE('Precio de venta medio: '||V_PRECIO_VENTA_MED);
    END;
    /

--Informes PL/SQL:

--1 Elabora un informe que muestre el nombre de la tienda y el nombre de todos los artículos que vende.

--2 Elabora un informe que muestre el precio de venta máximo, el precio de venta mínimo y el precio de venta medio de cada uno de los artículos.

--Trigger:

--1 

    CREATE OR REPLACE TRIGGER TR_FECHA_PEDIDO
    BEFORE INSERT ON PEDIDOS
    FOR EACH ROW
    BEGIN
        IF :NEW.FECHA_PEDIDO < SYSDATE THEN
            RAISE_APPLICATION_ERROR(-20001, 'La fecha de pedido no puede ser anterior a la fecha de hoy');
        END IF;
    END; 
    /

    INSERT INTO PEDIDOS VALUES ('3552','Babobibo','586',to_date('2019-05-18','YYYY-MM-DD'),1);

--2 

    CREATE OR REPLACE TRIGGER TR_CATEGORIA
    BEFORE INSERT ON TIENDAS
    FOR EACH ROW
    BEGIN
        IF :NEW.CATEGORIAS = 'Restauración' OR :NEW.CATEGORIAS = 'Ocio' THEN
            RAISE_APPLICATION_ERROR(-20001, 'La categoría no puede ser Restauración u Ocio');
        END IF;
    END;
    /

    INSERT INTO TIENDAS VALUES ('Babobibo','Sevilla','Restauración',41700);

--3 

    CREATE TABLE AUDITORIA (
        NOMBRE VARCHAR2(30),
        FECHA_MODIFICACION DATE,
        CONSTRAINT PK_AUDITORIA PRIMARY KEY (NOMBRE,FECHA_MODIFICACION)
    );

    CREATE OR REPLACE TRIGGER TR_AUDITORIA
    BEFORE UPDATE ON PEDIDOS
    FOR EACH ROW
    BEGIN
        INSERT INTO AUDITORIA VALUES (USER, SYSDATE);
    END;
    /

    UPDATE PEDIDOS SET CANTIDAD = 2 WHERE NOM_TIENDA = 'Babobibo';

--4 INTEGRIDAD DE DATOS. Realiza un trigger que permita únicamente a la tienda Letters vender el artículo "Cuadernos".

    CREATE OR REPLACE TRIGGER TR_CUADERNOS
    BEFORE INSERT ON PEDIDOS
    FOR EACH ROW
    DECLARE
        V_COD_CUADERNOS ARTICULOS.CODIGO%TYPE;
    BEGIN
        SELECT CODIGO INTO V_COD_CUADERNOS
        FROM ARTICULOS
        WHERE NOMBRE = 'Cuadernos';
        IF :NEW.NOM_TIENDA != 'Letters' AND :NEW.COD_ARTICULO = V_COD_CUADERNOS  THEN
            RAISE_APPLICATION_ERROR(-20001, 'Solo Letters puede vender Cuadernos');
        END IF;
    END;
    /

    INSERT INTO ARTICULOS VALUES ('1124','Cuadernos','359',0.5,'Nuevo',3);
    INSERT INTO PEDIDOS VALUES ('2830','Babobibo','1124',to_date('2022-07-18','YYYY-MM-DD'),5);

