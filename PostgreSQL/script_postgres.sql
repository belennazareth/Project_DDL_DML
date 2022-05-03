SET SERVEROUTPUT ON 

DROP TABLE TIENDAS;
CREATE TABLE TIENDAS 
(
    NOMBRE VARCHAR (20),
    POBLACION VARCHAR (20),
    CATEGORIAS VARCHAR (20) DEFAULT 'Productos variados',
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
    NOMBRE VARCHAR (40),
    COD_VENDEDOR VARCHAR (3),
    PESO NUMERIC (3,2),
    ESTADO VARCHAR (20),
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
    COD_ARTICULO VARCHAR (4),
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

INSERT INTO TIENDAS (NOMBRE,POBLACION,CODPOSTAL) VALUES ('DeSegunda','Sevilla',41700);
INSERT INTO TIENDAS VALUES ('VendeloYa123','Zaragoza','Videojuegos',50001);
INSERT INTO TIENDAS VALUES ('Babobibo','Madrid','Hogar',28002);
INSERT INTO TIENDAS VALUES ('Sanchez','Malaga','Antiguedades',29001);
INSERT INTO TIENDAS VALUES ('catsdogs','California','Mascotas',08811);
INSERT INTO TIENDAS VALUES ('Letters','Londres','Papeleria',79001);

INSERT INTO VENDEDORES VALUES ('175','Antonio','Francia');
INSERT INTO VENDEDORES VALUES ('175','Alejandro','TURQUIA');
INSERT INTO VENDEDORES VALUES ('246','Ivan','ESPAÑA');
INSERT INTO VENDEDORES VALUES ('790','Evelyn','CANADA');
INSERT INTO VENDEDORES VALUES ('359','Larry','JAPON');

INSERT INTO ARTICULOS VALUES ('1340','Auriculares','175',6,'Gastado',15.99);
INSERT INTO ARTICULOS VALUES ('1340','Caja','175',6,'Nuevo',-0.2);
INSERT INTO ARTICULOS VALUES ('1780','Guitarra','175',6,'Reacondicionado',15.99);
INSERT INTO ARTICULOS VALUES ('1099','PS5','246',5,'Usado',750);
INSERT INTO ARTICULOS VALUES ('5846','Lanyard','790',0.27,'Nuevo',2.50);
INSERT INTO ARTICULOS VALUES ('1564','Fósil','359',30,'Usado',1500);

INSERT INTO PEDIDOS VALUES ('3552','Babobibo','586',to_date('2019-05-18', 'YYYY-MM-DD'),-2);
INSERT INTO PEDIDOS VALUES ('3552','Babobibo','586',to_date('2017-05-18', 'YYYY-MM-DD'),3);
INSERT INTO PEDIDOS VALUES ('4652','Babobibo','5846',to_date('2019-05-18','YYYY-MM-DD'),3);
INSERT INTO PEDIDOS VALUES ('1827','Letters','1780',to_date('2021-12-03','YYYY-MM-DD'),1);
INSERT INTO PEDIDOS VALUES ('2801','DeSegunda','1099',to_date('2022-01-06','YYYY-MM-DD'),1);
INSERT INTO PEDIDOS VALUES ('5764','Sanchez','1564',to_date('2020-09-30','YYYY-MM-DD'),1);

INSERT INTO CLIENTES VALUES ('147','Babobibo','5846',to_date('2017-01-01','YYYY-MM-DD'));
INSERT INTO CLIENTES VALUES ('147','Babobibo','5846',to_date('2020-01-01','YYYY-MM-DD'));
INSERT INTO CLIENTES VALUES ('258','Sanchez','1564',to_date('2022-03-27','YYYY-MM-DD'));
INSERT INTO CLIENTES VALUES ('369','Letters','1780',to_date('2021-12-23','YYYY-MM-DD'));
INSERT INTO CLIENTES VALUES ('471','DeSegunda','1099',to_date('2022-02-28','YYYY-MM-DD'));