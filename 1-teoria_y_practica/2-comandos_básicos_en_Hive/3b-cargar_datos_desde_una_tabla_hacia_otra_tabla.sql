/*  CARGAR DATOS DESDE UNA TABLA HACIA OTRA TABLA
    =============================================

    En esta ocasión vamos a utilizar la forma CREATE TABLE AS SELECT:

    USE database1

    CREATE TABLE database1.tabla2
    AS
    SELECT *
    FROM database1.tabla1
    WHERE year = 2020;