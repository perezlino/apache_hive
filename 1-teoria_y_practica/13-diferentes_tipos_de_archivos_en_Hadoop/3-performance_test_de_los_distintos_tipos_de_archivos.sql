/*  PERFORMANCE TEST DE LOS DISTINTOS TIPOS DE ARCHIVOS
    ===================================================

    Comparar los resultados de las pruebas de lectura/escritura en los distintos tipos de archivos
    ----------------------------------------------------------------------------------------------

    En las dos clases anteriores, aprendimos acerca de los diferentes tipos de archivos que están disponibles en el ecosistema 
    Hadoop, y también llegamos a conocer las características que proporcionan. Ahora en esta lección, vamos a comparar los 
    resultados de las pruebas de lectura y escritura de estos tipos de archivos. Esta prueba no es hipotética, sino que fue 
    realizada por un tercero. 
    
    ¿Cuál fue el punto de referencia? Una tabla con:

    ● 700 columnas
    ● 2.5 millones de filas
    ● Consultas Hive

    La prueba se realizó sobre datos de 700 columnas con 2,5 millones de filas, no recuerdo la naturaleza de los datos, pero 
    supongo que de las 700 columnas, la mayoría eran relativas a alguna encuesta. En realidad era el resultado del join de unas 
    cuantas tablas, por eso son 700 columnas. En cuanto a la tecnología, se utilizó Hive para comprobar el rendimiento de lectura 
    y escritura.

    Querys:

    LECTURA: SELECT * FROM test_table WHERE month_col = 'October';

    ESCRITURA: INSERT INTO TABLE test_table SELECT * FROM source_table;

    Como consulta de texto de lectura, se seleccionaron las filas en las que el mes era igual a octubre. Y para escritura, se 
    midió cuánto tardaba Hive en insertar datos de una tabla a otra. Veamos ahora los resultados. Estos son los resultados de 
    la consulta de escritura, y se alinean con lo que hemos aprendido acerca de estos archivos:

    WRITE                                    READ
    -----                                    ----  

    1.- Textfile  (50 segundos)              1.- ORC       (60 segundos)
    2.- Sequence  (65 segundos)              2.- Parquet   (70 segundos)
    3.- Avro      (85 segundos)              3.- Avro      (90 segundos)
    4.- Parquet   (115 segundos)             4.- Sequence  (115 segundos)
    5.- ORC       (125 segundos)             5.- Textfile  (130 segundos)

    Estos son los resultados de un solo benchmark, es decir, con estas 700 columnas, 2,5 millones de filas, y consultas 
    particulares solamente. Pero si cambias los datos, cambias la consulta, o incluso cambias la tecnología, como si usas 
    Impala en lugar de Hive, entonces los resultados pueden diferir. Siempre que la diferencia de tiempo sea marginal, esos 
    lugares pueden intercambiarse. Por ejemplo, es posible que si utilizamos Impala en esta prueba, con una consulta más 
    complicada, entonces parque puede venir como un mejor rendimiento de escritura. Pero, por supuesto, el archivo de texto 
    nunca vendrá en la parte superior de escritura, no tanto cambio drástico grande.