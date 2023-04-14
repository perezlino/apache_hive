/*  CAGRAR EN UNA TABLA HIVE UN ARCHIVO CSV UTILIZANDO BUILT SERDE
    ==============================================================

    Supongamos que tengo un archivo CSV sample.csv en el directorio /temp con las siguientes entradas:

    1 Hugh Jackman hughjackman@cam.ac.uk Male 136.90.241.52
    2 David Lawrence dlawrence1@gmail.com Male 101.177.15.130
    3 Andy Hall andyhall2@yahoo.com Female 114.123.153.64
    4 Samuel Jackson samjackson231@sun.com Male 89.60.227.31
    5 Emily Rose rose.emily4@surveymonkey.com Female 119.92.21.19

    ¿Cómo consumir este archivo CSV en el Hive warehouse utilizando SerDe incorporado?

    SerDe significa serializador/deserializador. Un SerDe nos permite convertir los bytes no estructurados en un 
    registro que podemos procesar utilizando Hive. Los SerDe se implementan utilizando Java. Hive viene con varios 
    SerDe incorporados y también hay disponibles muchos otros SerDe de terceros.

    CREATE TABLE IF NOT EXISTS sample_tab (
    id INT,
    first_name STRING,
    last_name STRING,
    email STRING,
    gender STRING,
    ip_address STRING)    
    ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
    WITH SERDEPROPERTIES("separatorChar"="\t")
    STORED AS TEXTFILE;

    nano sampletabfile.csv;
    1,Hugh,Jackman,hughjackman@cam.ac.uk,Male,136.90.241.52
    2,David,Lawrence,dlawrence1@gmail.com,Male,101.177.15.130
    3,Andy,Hall,andyhall2@yahoo.com,Female,114.123.153.64
    4,Samuel,Jackson,samjackson231@sun.com,Male,89.60.227.31
    5,Emily,Rose,rose.emily4@surveymonkey.com,Female,119.92.21.19    

    hdfs dfs -copyFromLocal sampletabfile.csv /user/bigdata/filesdata

    -- Cargar a la tabla de texto
    LOAD DATA INPATH '/user/bigdata/filesdata/sampletabfile.csv' INTO TABLE sample_tab;        

    SELECT * FROM sample_tab;    