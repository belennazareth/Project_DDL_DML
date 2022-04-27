SET SERVEROUTPUT ON 

DROP TABLE TIENDAS;
CREATE TABLE TIENDAS 
(
    NOMBRE VARCHAR (20),
    POBLACION VARCHAR (20),
    CATEGORIAS VARCHAR (20),
    CODPOSTAL NUMERIC (5),
    CONSTRAINT PK_TIENDAS PRIMARY KEY (NOMBRE),
    CONSTRAINT CH_TIENDANOMBRE CHECK (REGEXP_LIKE(NOMBRE,'^([[:alpha:]])+$'))
);

DROP TABLE VENDEDORES;
CREATE TABLE VENDEDORES
(
    CODIGO VARCHAR (3),
    NOMBRE VARCHAR (15) NOT NULL,
    PAIS VARCHAR (20),
    CONSTRAINT PK_VENDEDORES PRIMARY KEY (CODIGO),
    CONSTRAINT CH_VENDEDORPAIS CHECK (PAIS LIKE UPPER(PAIS))
);

DROP TABLE ARTICULOS;
CREATE TABLE ARTICULOS
(
    CODIGO VARCHAR (10),
    NOMBRE VARCHAR (15),
    COD_VENDEDOR VARCHAR (3),
    PESO NUMERIC (3,2),
    ESTADO VARCHAR (10),
    PRECIO_VENTA NUMERIC (6,2),
    CONSTRAINT PK_ARTICULOS PRIMARY KEY (CODIGO),
    CONSTRAINT FK_CODV_ARTICULOS FOREIGN KEY (COD_VENDEDOR) REFERENCES VENDEDORES (CODIGO),
    CONSTRAINT CH_ARTICULOSESTADO CHECK (ESTADO IN ('Nuevo', 'Reacondicionado', 'Usado')),
    CONSTRAINT CH_ARTICULOSPRECIOV CHECK (PRECIO_VENTA>0)
);

DROP TABLE PEDIDOS;
CREATE TABLE PEDIDOS
(
    CODIGO VARCHAR (10),
    NOM_TIENDA VARCHAR (10),
    COD_ARTICULO VARCHAR (3),
    FECHA_PEDIDO DATE,
    CANTIDAD NUMERIC (3),
    CONSTRAINT PK_PEDIDOS PRIMARY KEY (CODIGO),
    CONSTRAINT FK_NOMT_PEDIDOS FOREIGN KEY (NOM_TIENDA) REFERENCES TIENDAS (NOMBRE),
    CONSTRAINT FK_CODART_PEDIDOS FOREIGN KEY (COD_ARTICULO) REFERENCES ARTICULOS (CODIGO),
    CONSTRAINT CH_DATE CHECK (FECHA_PEDIDO>to_date('2018-01-01','YYYY-MM-DD')),
    CONSTRAINT CH_CANTIDAD CHECK (CANTIDAD>0)
);

DROP TABLE CLIENTES;
CREATE TABLE CLIENTES
(
    CODIGO VARCHAR (10),
    NOM_TIENDA VARCHAR (10),
    COD_ARTICULO VARCHAR (10),
    FECHA_COMPRA DATE,
    CONSTRAINT PK_CLIENTES PRIMARY KEY (CODIGO),
    CONSTRAINT FK_NOMT_CLIENTES FOREIGN KEY (NOM_TIENDA) REFERENCES TIENDAS (NOMBRE),
    CONSTRAINT FK_CODART_CLIENTES FOREIGN KEY (COD_ARTICULO) REFERENCES ARTICULOS (CODIGO),
    CONSTRAINT CH_FECHACOMP CHECK (FECHA_COMPRA>to_date('2018-03-17','YYYY-MM-DD'))
);