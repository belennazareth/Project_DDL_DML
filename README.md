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

Con respecto a este esquema:

    1. Añade a la tabla vendedores una nueva columna llamada TIPO, será de tipo varchar.

    2. Modificaremos el campo TIPO de la tabla vendedores para que indique si el vendedor es de una franquicia, autónomo o ninguna de estas pudiendo ser null.

    3. Elimina la columna PAIS de la tabla vendedores.

    4. Añade una restricción a la tabla artículos donde el CODIGO solo pueda tener números.

    5. Elimina la restricción de la tabla vendedores donde indica que los países solo irán en mayúsculas.

    6. En la tabla tiendas desactiva la restricción descrita sobre el NOMBRE, introduce un nombre con números y vuelve a activarla.

Tras estas operaciones realiza las siguientes consultas:

    1. Mostrar por pantalla todos los artículos y su estado.

    2. Una vista donde aparezcan el código del pedido y la fecha del pedido.

    3. Mostrar los nombres de los vendedores y los articulos que venden.

    4. Mostrar toda la información de las tiendas y la cantidad de pedidos que realizan.

    5. En la tabla artículos aplica un 10% de descuento al precio de venta.

    6. Mostrar cada producto y el código del cliente donde la fecha sea la máxima registrada.

    7. Borra los artículos del vendedor Larry.

    8. Mostrar nombre y país de los vendedores ordenados por el precio de venta de sus artículos de forma ascendente.

    9. Mostrar la media de pedidos realizados. 

    10. Mostrar el nombre del artículo y el vendedor al que pertenece.

    11. Listar el nombre de cada tienda con el código y  fecha del producto con mayor cantidad de pedidos.

    12. Mostrar el nombre y país de los vendedores además del nombre del artículo donde el precio de venta sea el mayor.

    13. Mostrar la media de pedidos realizados por cada tienda, incluso los que no tienen pedidos. 

    14. Crea una tabla de pedidos rechazados con las mismas columnas que la tabla pedidos e inserta los pedidos realizados de 2022 en adelante como pedidos rechazados.

    15. Mostrar los nombres de las tiendas en los siguientes casos:
        - En las que los pedidos no han sido rechazados.
        - Donde se vean tanto las que tienen pedidos rechazados como las que no.
        - Las que se encuentren en ambas tablas.

    16. Mostrar información de los artículos cuyo precio de venta es igual que el máximo de esa misma tabla.

    17. Mostrar el nombre de la tienda y la cantidad de pedidos con más de dos pedidos realizados. 

A continuación, realiza:

    --Funciones:

        1. Elabora una función que reciba el estado y devuelva el número de artículos que existen en ese estado.

        2. Elabora una función que reciba una categoría y devuelva el nombre de la tienda y la cantidad total de pedidos de esa categoría.

    --Procedimientos:

        1. Elabora un procedimiento que reciba el nombre de un vendedor y muestre el nombre de todos los artículos que vende.

        2. Elabora un procedimiento que reciba como entrada la fecha del pedido y devuelva el número de pedidos que existen dentro de esa fecha y el nombre de la tienda.

        3. Crea un procedimiento que reciba de parámetro de entrada el estado y devuelva como salida:
            - El precio de venta máximo.
            - El precio de venta mínimo.
            - El precio de venta medio. 
    
    --Informes PL/SQL:

        1. Elabora un informe que muestre el nombre de la tienda y el nombre de todos los artículos que vende.

        2. Elabora un informe que muestre el precio de venta máximo, el precio de venta mínimo y el precio de venta medio de cada uno de los artículos.

    --Trigger:

        1. SISTEMA. Realiza un trigger que impida meter pedidos de fecha anterior a la fecha de hoy.

        2. SEGURIDAD. Realiza un trigger que impida que un usuario pueda modificar un pedido que no sea suyo.

        3. AUDITORÍA. Realiza un trigger que registre en una tabla de auditoría cada vez que se modifica un pedido y que muestre el nombre del usuario que lo modificó y la fecha de modificación.

        4. INTEGRIDAD DE DATOS. Realiza un trigger que permita únicamente a la tienda Letters vender el artículo "Cuadernos".

        5. INTEGRIDAD REFERENCIAL. Realiza un trigger que actualice en cascada el nombre del vendedor en la tabla artículos cuando se modifica el nombre del vendedor en la tabla vendedores.

        6. REPLICACIÓN DE TABLAS. Realiza un trigger que replique la tabla artículos en la tabla artículos_replica.

        7. CONTROL DE EVENTOS. Elabora un disparador a nivel de sentencia que se inicie cada vez que se ingrese, actualiza o elimina un pedido. El disparador debe registrar en una tabla de auditoría cada vez que se modifica un pedido y que muestre el nombre del usuario que lo modificó y la fecha de modificación. 

        8. CÁLCULO DE DATOS DERIVADOS. Elabora un disparador de actualización que evite que se actualice el campo "precio_venta" de la tabla artículos. 