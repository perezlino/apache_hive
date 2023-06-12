/*  CARGAR DATOS DE UN ARCHIVO TXT EN UNA TABLA ALMACENADA COMO ORC
    ===============================================================

    ¿Cómo cargar datos de un archivo .txt en una tabla almacenada como ORC en Hive?

    LOAD DATA sólo copia los archivos en archivos de datos Hive. Hive no realiza ninguna transformación al cargar los 
    datos en las tablas.

    Por lo tanto, en este caso, el archivo de entrada /user/bigdata/filesdata/textdata.txt debe estar en formato ORC si 
    desea cargarlo en una tabla ORC.

    Una posible solución es crear una tabla temporal con STORED AS TEXT, luego LOAD DATA en ella, y luego copiar los datos 
    de esta tabla a la tabla ORC. 

    Ejemplo
    -------

    CREATE TABLE test_details_txt (visit_id INT, store_id SMALLINT)   
    ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
    STORED AS TEXTFILE;

    CREATE TABLE test_details_orc (visit_id INT, store_id SMALLINT)
    STORED AS ORC;

    DESCRIBE FORMATTED test_details_txt;  <------------- DESCRIBE EXTENDED test_details_txt (lo mismo)
    DESCRIBE_FORMATTED test_details_orc;  <------------- DESCRIBE EXTENDED test_details_orc (lo mismo)

    SELECT * FROM test_details_text;
    SELECT * FROM test_details_orc;

    nano textdata.txt
    101,10
    102,20

    hdfs dfs -copyFromLocal textdata.txt /user/bigdata/filesdata  <--------- Copiamos el archivo creado al directorio   

    -- Cargar a la tabla de texto
    LOAD DATA INPATH '/user/bigdata/filesdata/textdata.txt' INTO TABLE test_details_txt;

    -- Copiar a la tabla ORC
    INSERT INTO TABLE test_details_orc SELECT * FROM test_details_txt; 

    SELECT * FROM test_details_text;
    SELECT * FROM test_details_orc;       