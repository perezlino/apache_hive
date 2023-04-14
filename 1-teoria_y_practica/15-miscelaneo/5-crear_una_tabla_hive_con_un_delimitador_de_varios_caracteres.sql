/*  CREAR UNA TABLA HIVE CON UN DELIMITADOR DE VARIOS CARACTERES
    ============================================================

    ¿Cómo crear una tabla HIVE con un delimitador de varios caracteres?

    FIELDS TERMINATED BY no admite delimitadores de varios caracteres. Lo más sencillo es utilizar "MultiDelimitSerde".


    Ejemplo:
    --------

    USE sales;

    CREATE TABLE IF NOT EXISTS tableex (
    id INT,
    name STRING)
    ROW FORMAT SERDE 'org.apache.hadoop.hive.contrib.serde2.MultiDelimitSerde'
    WITH SERDEPROPERTIES("field.delim"="~*")
    STORED AS TEXTFILE;

    DESCRIBE tableex;

    nano tableex.txt     <---------- Creamos un archivo por medio de "nano"
    1~*SAM
    2~*NANCY   												 

    hdfs dfs -copyFromLocal tableex.txt /user/bigdata/filesdata  <--------- Copiamos el archivo creado al directorio

    hdfs dfs -ls /user/bigdata/filesdata

    LOAD DATA INPATH '/user/bigdata/filesdata/tableex.txt' INTO TABLE managedtable;

    SELECT * FROM tableex;    