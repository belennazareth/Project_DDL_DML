# Proyecto DDL y DML

Estas tablas son en base a una franquicia de tiendas de venta de productos de segunda mano:

>En negrita aparecerán las claves primarias, mientras que en cursiva aparecerán las claves ajenas.

| TIENDAS |     |     |
| --- | --- | --- |
| **NOMBRE** | Cadena de caracteres, tamaño 20 | Solo puede tener letras y será de valor único |
| POBLACIÓN | Cadena de caracteres, tamaño 20 |     |
| PROVINCIA | Cadena de caracteres, tamaño 20 | La primera siempre en mayúsculas |
| CATEGORÍAS | Cadena de caracteres, tamaño 20 | Por defecto será 'Productos variados' |
| CODPOSTAL | Numérico, tamaño hasta cinco cifras |     |


| VENDEDORES |     |     |
| --- | --- | --- |
| **CÓDIGO** | Cadena de caracteres, tamaño 3 |     |
| NOMBRE | Cadena de caracteres, tamaño 15 | No puede ser nulo |
| PAIS | Cadena de caracteres, tamaño 20 | Siempre en mayúsculas |


| ARTÍCULOS |     |     |
| --- | --- | --- |
| **CÓDIGO** | Cadena de caracteres, tamaño 5 |     |
| NOMBRE | Cadena de caracteres, tamaño 15 |     |
| _COD_VENDEDOR_ | Cadena de caracteres, tamaño 3 |     |
| PESO | Numérico, tamaño hasta tres cifras y dos decimales |     |
| ESTADO | Cadena de caracteres, tamaño 10 | Sólo podrá ser 'Nuevo', 'Reacondicionado' o 'Usado' |
| PRECIO_VENTA | Numérico, tamaño hasta seis cifras y dos decimales | Tendrá que ser mayor que cero |


| PEDIDOS |     |     |
| --- | --- | --- |
| **CÓDIGO** | Cadena de caracteres, tamaño 10 |     |
| _NOM_TIENDA_ | Cadena de caracteres, tamaño 10 |     |
| _COD_ARTICULO_ | Cadena de caracteres, tamaño 5 |     |
| FECHA_PEDIDO | De tipo fecha | El año deberá ser a partir del 2018 |
| CANTIDAD | Numérico, tamaño hasta tres cifras | No puede ser menor que cero |
 

| CLIENTES |     |     |
| --- | --- | --- |
| **CÓDIGO** | Cadena de caracteres, tamaño 10 |     |
| _NOM_TIENDA_ | Cadena de caracteres, tamaño 10 |     |
| _COD_ARTICULO_ | Cadena de caracteres, tamaño 5 |     |
| FECHA_COMPRA | De tipo fecha | A partir del 17 de marzo del 2018 |

