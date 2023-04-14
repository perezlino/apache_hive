/*  CREAR UNA UNICA TABLA HIVE PARA ARCHIVOS PEQUEÑOS SIN DEGRADAR EL RENDIMIENTO EN HIVE
    =====================================================================================

    Supongamos que tengo un montón de pequeños archivos CSV presentes en el directorio /input en HDFS y quiero crear una 
    única tabla Hive correspondiente a estos archivos. Los datos de estos archivos están en el formato: {id, nombre, e-mail, 
    país}. Ahora, como sabemos, el rendimiento de Hadoop disminuye cuando usamos muchos archivos pequeños.

    Entonces, ¿cómo resolver este problema en el que queremos crear una única tabla Hive para muchos archivos pequeños sin 
    degradar el rendimiento del sistema?

    Uno puede utilizar el formato de archivo SEQUENCE que agrupará estos archivos pequeños para formar un único archivo de 
    secuencia. Los pasos a seguir para ello son los siguientes:

    CREATE TABLE IF NOT EXISTS temp_smalltable (
    id INT,
    name STRING,
    email STRING,
    country STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
    STORED AS TEXTFILE;

    nano small1.csv
    1,abc,abc@gmail.com,USA
    2,xyz,xyz@yahoo.com,CANADA

    nano small2.csv
    3,def,def@gmail.com,India
    4,pqr,pqr@rediff.com,Australia    

    hdfs dfs -copyFromLocal small*.csv /user/bigdata/filesdata

    -- Cargar a la tabla de texto
    LOAD DATA INPATH '/user/bigdata/filesdata/small*.csv' INTO TABLE temp_smalltable;        

    SELECT * FROM temp_smalltable;

    CREATE TABLE IF NOT EXISTS small_seqfile (
    id INT,
    name STRING,
    email STRING,
    country STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
    STORED AS SEQUENCEFILE;    

    INSERT INTO TABLE small_seqfile SELECT * FROM temp_smalltable;

    SELECT * FROM small_seqfile;