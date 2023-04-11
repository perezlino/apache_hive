/*  DIFERENCIA ENTRE ELIMINAR Y TRUNCAR UNA TABLA
    =============================================

    DROP Y TRUNCATE
    ---------------

    En esta sección, voy a discutir las diferencias entre eliminar (dropping) una tabla y truncar (truncating) una tabla, 
    y junto con eso, también voy a discutir el comando "purge". En primer lugar, eliminar tabla. DROP TABLE elimina los 
    metadatos y los datos de una tabla, lo que significa que tanto la estructura de la tabla como los datos dentro de la 
    tabla son eliminados. Pero esto sólo es válido para las tablas internas, ya que las tablas internas están completamente 
    gestionadas por Hive. En la tabla externa también se eliminan los metadatos y los datos, pero sólo de la tabla Hive, 
    aunque los datos seguirán presentes en la ubicación HDFS. Como los datos de la tabla externa están completamente 
    gestionados por HDFS, sólo se elimina el enlace entre Hive y HDFS.

    Pasemos a truncar. La diferencia entre truncar y eliminar es que truncar elimina sólo los datos de una tabla, los 
    metadatos o la estructura de la tabla no se eliminarán, permanecerán intactos tal cual. Así que, en primer lugar, te 
    mostraré la lista de tablas:
    
    
                                                            SHOW TABLES;
    
    table2
    table4
    table5
    table6


    Tengo la tabla 2, tabla 4, tabla 5 y tabla 6. Así que, en primer lugar, voy a tratar de eliminar una tabla: 
    
    
                                                        DROP TABLE tabla2; 
    
    
    Ahora de nuevo, usaré mostrar tablas:
    
    
                                                            SHOW TABLES;    
    
    table4
    table5
    table6

    Como puedes ver, la estructura de la tabla 2 también se ha perdido junto con los datos. Para los datos, también podemos 
    comprobar: 
    
    
                                                        SELECT * FROM tabla2; 
    
    
    Se muestra "tabla no encontrada". 


    Ahora el comando "TRUNCATE". Para truncar, estoy truncando la tabla 4: 
    
    
                                                        TRUNCATE TABLE table4; 
    
    
    Ahora muestra las tablas: 
    
    
                                                            SHOW TABLES; 
    
    table4
    table5
    table6

    Debería mostrarnos la tabla 4. Verás, los datos dentro de la tabla se perderán, pero la estructura o los metadatos de la 
    tabla 4 siguen presentes, y ahora intentaremos obtener los registros: 
    
    
                                                        SELECT * FROM tabla4;     
    

    Nos está mostrando 0 filas porque los datos dentro de la tabla 4 están completamente eliminados.