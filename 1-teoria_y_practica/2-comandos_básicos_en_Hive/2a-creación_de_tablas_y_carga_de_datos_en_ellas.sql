/*  CREACIÓN DE TABLAS Y CARGA DE DATOS EN ELLA
    ===========================================

    Crear una tabla en Hive es un comando DDL, y el formato de la consulta "create table" es el mismo que en 
    SQL. Antes de crear una tabla, permítame decirle que hay dos tipos de tablas creadas en Hive: 
    
    1.- Tablas externas: en el caso de las tablas externas, Hive sólo es responsable de los metadatos de la 
                         tabla, pero no de los datos reales.  

    2.- Tablas internas: en el caso de las tablas internas, Hive es el único propietario de los datos y metadatos 
                         de la tabla. 

    3.- Diferencias:                     
    
    Tienen sus diferencias en cómo se almacenan los metadatos de las tablas.  Sin embargo, la principal diferencia 
    se produce al eliminar una tabla. Si eliminamos una TABLA INTERNA en Hive, se perderán tanto los metadatos como 
    los datos reales de la tabla, ya que Hive era el propietario de ambos. Pero si eliminamos una TABLA EXTERNA, 
    sólo se perderán los metadatos, que eran gestionados por Hive. Los datos reales de la tabla no se borrarán, y 
    otras aplicaciones podrán acceder a ellos en HDFS. Sólo se perderá la definición de la tabla. Tras eliminar una 
    tabla externa, Hive ya no tendrá ningún vínculo con esos datos. La diferencia entre ambas tablas se explica en 
    detalle en las próximas clases.

    4.- Por defecto, Hive crea tablas internas.


    Sentencias para crear tablas
    ----------------------------

    CREATE TABLE -----> Creará por defecto una Tabla interna
    CREATE EXTERNAL TABLE -----> Creará una Tabla externa
    CREATE TABLE IF NOT EXISTS -----> "if not exists" cumple la misma función que en las bases de datos. Al igual que 
                                      si estamos tratando de crear una tabla duplicada, Hive no arrojará un error, 
                                      simplemente ignorará este comando.

    Creación de una tabla
    ---------------------

    Queremos cargar el archivo: "data.txt". Tiene los siguientes datos:

                                            499,Poole:GBR,England,141000
                                            501,Blackburn:GBR,England,140000
                                            500,Bolton:GBR,England,139020
                                            502,Newport:GBR,Wales,139000
                                            503,PrestON:GBR,England,135000
                                            504,Stockport:GBR,England,132813

    Hasta esta parte, la estructura es similar a SQL. Pero ahora, en Hive, ya que tenemos que cargar los datos de un 
    archivo, tenemos que decirle a Hive que cómo es mi archivo. Mi archivo de entrada tiene cuatro columnas: la columna_1 
    es de tipo string, la columna_2 es de tipo array, la columna_3 es de tipo string y la columna_4 es de tipo int. Así 
    que de acuerdo con mi archivo de entrada, la siguiente línea es, " Row format delimited". Con esto, le estoy diciendo 
    a Hive que en mi archivo de entrada, los datos están delimitados. ¿Y cómo, y por cuáles delimitadores está delimitado? 
    Para ello, utilizamos:
                                        
                                        ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
                                        COLLECTION ITEMS TERMINATED BY ':' 
                                        LINES TERMINATED BY '\n' 
                                        STORED AS TEXTFILE

    Así que ROW FORMAT DELIMITED significa, mi archivo de entrada a cargar es de tipo delimitador, con campos terminados por 
    coma (FIELDS TERMINATED BY ','). Los elementos de la colección terminan con dos puntos (COLLECTION ITEMS TERMINATED BY ':'). 
    Esto significa que dentro de una colección, es decir, un array, los elementos están separados por dos puntos. Así que 
    Poole será mi primer elemento del array, y GBR será el segundo elemento del array. Y las líneas terminan con una nueva 
    línea (LINES TERMINATED BY '\n'). Así que cada nueva línea en el archivo de entrada será una fila a la tabla de Hive.
    Almacenado como archivo de texto (STORED AS TEXTFILE). Con esto, le estoy diciendo a Hive que esta tabla debe ser 
    almacenada en formato de archivo de texto. También podemos utilizar cualquier otro formato de archivo soportado por Hive, 
    como archivo de secuencia, Parquet, AVRO, ORC, etc, pero por defecto es el formato de archivo de texto. Así que este es 
    el aspecto de una consulta básica para crear una tabla interna. 

                                        CREATE TABLE IF NOT EXISTS tabla1 (
                                        col1 string, 
                                        col2 array<string>, 
                                        col3 string, 
                                        col4 int)
                                        ROW FORMAT DELIMITED 
                                        FIELDS TERMINATED BY ',' 
                                        COLLECTION ITEMS TERMINATED BY ':' 
                                        LINES TERMINATED BY '\n' 
                                        STORED AS TEXTFILE

    Y como te dije, si quieres crear una Tabla externa, pon la palabra clave EXTERNAL aquí. En lugar de CREATE TABLE, pon 
    CREATE EXTERNAL TABLE, y el resto de las consultas serán iguales. 

    También se puede acortar esta consulta y utilizar los valores por defecto. Así que a partir de ROW FORMAT DELIMITED hasta 
    STORED AS TEXTFILE, estas líneas se pueden omitir y la creación de la tabla se puede hacer. Y en ese caso, Hive utilizará 
    los valores por defecto de la misma, que son, ROW FORMAT DELIMITED, FIELDS TERMINATED BY que por defecto es ^A, 
    LINES TERMINATED BY que por defecto es '\n', y el formato del archivo por defecto es TEXTFILE. 

    Si creamos una nueva tabla, tabla2, sin estas cláusulas, tendremos problemas. No es adecuado para este archivo de entrada, 
    ya que el esquema de la tabla y el archivo no coinciden. En el archivo, los campos terminan en coma, pero en la definición 
    de la tabla, como no hemos sobrescrito la cláusula FIELDS TERMINATED BY, habría tomado el carácter "^A" por defecto. Así 
    que por favor, tener cuidado de todos estos delimitadores de esquema al crear una tabla. Además, podemos incluir muchas 
    otras cláusulas, como LOCATION, PARTITION, TABLE PROPERTIES, etc.

    A continuación podemos establecer la ruta de almacenamiento por defecto en HDFS con el siguiente comando:

                                                set hive.metastore.warehouse.dir;

    Ahora, podemos guardar la tabla en la ruta por defecto '/user/hive/warehouse' o podemos indicar una ruta personalizada:

                                        CREATE TABLE IF NOT EXISTS tabla1 (
                                        col1 string, 
                                        col2 array<string>, 
                                        col3 string, 
                                        col4 int)
                                        ROW FORMAT DELIMITED 
                                        FIELDS TERMINATED BY ',' 
                                        COLLECTION ITEMS TERMINATED BY ':' 
                                        LINES TERMINATED BY '\n' 
                                        STORED AS TEXTFILE
                                        LOCATION 'user/alfonso/tabla1';  <-------


    Carga de datos en la tabla
    --------------------------

    Tras la creación de la tabla, ahora tenemos que cargar el archivo en ella, o podemos decir vincular los metadatos a 
    nuestro archivo. Para ello, voy a utilizar el comando LOAD, que es "LOAD DATA LOCAL INPATH", y luego la ruta completa 
    al archivo. He utilizado la keyword LOCAL aquí, porque mi archivo de entrada está presente en el sistema de archivos 
    local y no en HDFS. Mi archivo de entrada está aquí, data.txt. Si este archivo hubiera estado presente en HDFS, 
    entonces tenemos que omitir esta keyword LOCAL y escribir "LOAD DATA INPATH", y luego la ruta HDFS al archivo. Así 
    que aquí, seria, "LOAD DATA LOCAL INPATH 'ruta del archivo' y la ruta es 'home/alfonso/data.txt' y luego agregamos 
    INTO TABLE table_name.

                            LOAD DATA LOCAL INPATH 'home/alfonso/data.txt' INTO TABLE tabla1

    El archivo se ha cargado. Ahora veremos si el archivo de entrada se cargó o no. Escribamos la sentencia: 
    
                                                    SELECT * FROM tabla_1 
    
    Podemos ver que nuestros datos fueron cargados apropiadamente. Chicos, aquí, en lugar de utilizar INTO, también podemos 
    utilizar la cláusula OVERWRITE. INTO se utiliza para anexar (append) datos a la tabla. Esto significa que si la tabla1 
    previamente tiene algunos datos en ella, a continuación, INTO anexa los datos a los datos anteriores. Pero sobrescribir 
    significa, si la tabla1 ya tiene datos, entonces primero borra los datos de la tabla1, y luego cargar nuevos datos en 
    ella.