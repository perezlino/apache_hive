/*  RESUMEN TEORIA TABLAS
    =====================

    CREAR TABLA
    -----------

    Sintáxis:

        CREATE [TEMPORARY] [EXTERNAL] TABLE [IF NOT EXISTS] [db_name.] tabl_name
        [(col_name data_type [column_constraint] [COMMENT col_comment], ...)]
        [PARTITIONED BY (col_name data_type [COMMENT 'col_comment'], ...)]
        [CLUSTERED BY (col_name, col_name, ...) [SORTED BY (col_name [ASC|DESC], ...)]
        INTO num_buckets BUCKETS]
        [COMMENT table_comment]
        [ROW FORMAT row_format]
        [FIELDS TERMINATED BY char]
        [LOCATION 'hdfs_path']
        [STORED AS file_format]


        CREATE [TEMPORARY] [EXTERNAL] TABLE [IF NOT EXISTS] [db_name.] tabl_name
        LIKE existing_table_or_view_name
        [LOCATION hdfs_path];

        row_format
            :   DELIMITED [FIELDS TERMINATED BY char [ESCAPED BY char]] [COLLECTION ITEMS TERMINATED BY char]
                    [MAP KEYS TERMINATED BY char] [LINES TERMINATED BY char]
                    [NULL DEFINED AS char]

            |   SERDE serde_name [WITH SERDEPROPERTIES (property_name=property_value, property_name=property_value, ...)]       

        file_format
            :   SEQUENCEFILE
            |   TEXTFILE
            |   RCFILE
            |   ORC
            |   PARQUET
            |   AVRO
            |   JSONFILE
            |   INPUTFORMAT  input_format_classname OUTPUTFORMAT output_format_classname


    ● La sentencia CREATE TABLE en HIVE se utiliza para crear una tabla con el nombre dado.

    ● Por defecto, las tablas Hive se crean en el directorio del warehouse, la ubicación se especifica en valor para la clave 
      hive.metastore.warehouse.dir en el archivo de configuración $HIVE_HOME/conf/hive-site.xml, por defecto, la ubicación del 
      warehouse sería /user/hive/warehouse

    ● IF NOT EXISTS - Puede utilizar IF NOT EXISTS para evitar el error en caso de que la tabla ya esté presente

    ● EXTERNAL - Se utiliza para crear una tabla externa

    ● TEMPORARY - Se utiliza para crear una tabla temporal

    ● ROW FORMAT - Especifica el formato de la fila

    ● FIELDS TERMINATED BY - Por defecto Hive utiliza el separador de campos ^A. Para cargar un archivo con un separador de 
      campos personalizado, como una coma, un pipe o un tabulador, utilice esta opción.

    ● CLUSTERED BY - Dividir los datos en un número específico de buckets

    ● LOCATION - Puede especificar la ubicación personalizada donde almacenar los datos en HDFS.                                                
    
    ------------------------------------------------------------------------------------------------------------------------

    EJEMPLO 1 - CREAR UNA TABLA 
    ---------------------------

    USE sales;

    CREATE TABLE IF NOT EXISTS employee (
    id INT,
    name STRING,
    age INT,
    gender STRING)
    COMMENT 'Employee Table'
    ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';

    DESCRIBE employee;

    nano data.txt     <---------- Creamos un archivo por medio de "nano"
    1,SAM,21,M
    2,NANCY,24,F    

    1.- hadoop fs -mkdir /user/bigdata/filesdata     <------ Este metodo de crear una carpeta utilizando "hadoop fs" esta
															 OBSOLETO. En este curso se utilizo asi. Ahora solo se utiliza
															 "hdfs dfs" para crear directorios de manera directa.

	En su defecto:

		hdfs dfs -mkdir /user/bigdata/filesdata															 

    2.- hdfs dfs -copyFromLocal data.txt /user/bigdata/filesdata  <--------- Copiamos el archivo creado al directorio

    LOAD DATA INPATH '/user/bigdata/filesdata/data.txt' INTO TABLE employee;

    SELECT * FROM employee;

    ------------------------------------------------------------------------------------------------------------------------

    EJEMPLO 2 - CREAR UNA TABLA 
    ---------------------------	

    USE sales;

    CREATE TABLE IF NOT EXISTS primitive_data_type (
    ETINYINT TINYINT,
    ESMALLINT SMALLINT,
    EINT INT,
    EBIG BIGINT,
    EBOOLEAN BOOLEAN,
    EFLOAT FLOAT,
    EDOUBLE DOUBLE,
    ESTRING STRING,
    EBINARY BINARY,  
    ETIMESTAMP TIMESTAMP, 
    EDECIMAL DECIMAL,     
    EDATE DATE, 
    EVARCHAR VARCHAR(100), 
    ECHAR CHAR(10) )
    COMMENT 'primitive_type'
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ',';

    DESCRIBE primitive_data_type

    nano primitive_data_type.txt      <---------- Creamos un archivo por medio de "nano"

    10,15,100,126,TRUE,10.25,750000.00,Welcome to Apache Hive Course,1,2022-03-25 16:32:01,9.499,2014-12-07,Hive is a DataWarehouse,We will be a rocks star,L

    hdfs dfs -copyFromLocal primitive_data_type.txt /user/bigdata/filesdata   <--------- Copiamos el archivo creado al directorio

    hadoop fs -ls /user/bigdata/filesdata  <---------- Debriamos usar  =>  hdfs dfs -ls /user/bigdata/filesdata	
                                                        Este comando "hadoop" ya no se utiliza, esta OBSOLETO.

    LOAD DATA INPATH '/user/bigdata/filesdata/primitive_data_type.txt' INTO TABLE primitive_data_type;

    SELECT * FROM primitive_data_type;	

    ------------------------------------------------------------------------------------------------------------------------

    EJEMPLO 3 - CREAR UNA TABLA 
    ---------------------------	

    CREATE TABLE IF NOT EXISTS complex_data_type (
    myarray array<string>,
    mymap map<string,int>,
    addr struct<city:string,state:string,pin:bigint>)
    COMMENT 'complex_type'
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
    COLLECTION ITEMS TERMINATED BY '$'
    MAP KEYS TERMINATED BY '#';

    DESCRIBE complex_data_type;

    nano complex_data_type.txt;

    a$b$c,pf#600$epf#400,maharashtra$mumbai$400002

    hdfs dfs -copyFromLocal complex_data_type.txt /user/bigdata/filesdata

    hadoop fs -ls /user/bigdata/filesdata  <---------- Debriamos usar  =>  hdfs dfs -ls /user/bigdata/filesdata	
                                                        Este comando "hadoop" ya no se utiliza, esta OBSOLETO.

    LOAD DATA INPATH '/user/bigdata/filesdata/complex_data_type.txt' INTO TABLE complex_data_type;

    SELECT * FROM complex_data_type; 
     ______________________________________________________________________________________________________________________
    |  complex_data_type.myarray  |   complex_data_type.mymap |    complex_data_type.addr                                  | 
    |-----------------------------|---------------------------|------------------------------------------------------------|
    |  ["a","b","c"]              |   {"pf":600, "epf":400}   |    {"city":"maharashtra", "state":"mumbai", "pin":400002}  | 
    |_____________________________|___________________________|____________________________________________________________|

    ------------------------------------------------------------------------------------------------------------------------

    MANAGED Y EXTERNAL TABLES
    -------------------------

    MANAGED TABLE: Una tabla gestionada se almacena bajo la propiedad path de "hive.metastore.warehouse.dir", por defecto en 
                   una ruta de carpeta similar a "/user/hive/warehouse/databassename.db/tablename/". La ubicación por defecto 
                   puede anularse mediante la propiedad LOCATION durante la creación de la tabla. Si se elimina una tabla o 
                   partición gestionada, se borran los datos y metadatos asociados a dicha tabla o partición.

    EXTERNAL TABLE: Una tabla externa describe los metadatos / esquema sobre archivos externos. Los archivos de tablas externas 
                    pueden ser accedidos y gestionados por procesos externos a Hive. Las tablas externas pueden acceder a datos 
                    almacenados en fuentes como ubicaciones HDFS remotas.

    ------------------------------------------------------------------------------------------------------------------------

    CREACIÓN DE MANAGED Y EXTERNAL TABLES
    -------------------------------------

    MANAGED TABLE (INTERNAL TABLE)
    ------------------------------

    USE sales;

    CREATE TABLE IF NOT EXISTS managedtable (
    id INT,
    name STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';

    DESCRIBE managedtable;

    nano manageddata.txt     <---------- Creamos un archivo por medio de "nano"
    1,SAM
    2,NANCY   												 

    hdfs dfs -copyFromLocal manageddata.txt /user/bigdata/filesdata  <--------- Copiamos el archivo creado al directorio

    hdfs dfs -ls /user/bigdata/filesdata

    LOAD DATA INPATH '/user/bigdata/filesdata/manageddata.txt' INTO TABLE managedtable;

    SELECT * FROM managedtable;


    EXTERNAL TABLE
    --------------

    USE sales;

    CREATE EXTERNAL TABLE IF NOT EXISTS externaltable (
    id INT,
    name STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';
    LOCATION '/home/bigdata/externaltabledata/';

    DESCRIBE externaltable;

    nano externaldata.txt     <---------- Creamos un archivo por medio de "nano"
    1,SAM
    2,NANCY   												 

    hdfs dfs -copyFromLocal externaldata.txt /user/bigdata/filesdata  <--------- Copiamos el archivo creado al directorio

    hdfs dfs -ls /user/bigdata/filesdata

    LOAD DATA INPATH '/user/bigdata/filesdata/externaldata.txt' INTO TABLE externaltable;

    SELECT * FROM externaltable;

    ------------------------------------------------------------------------------------------------------------------------

    STORAGE FORMATS
    ---------------

	● STORED AS TEXTILE <-------- Es el formato de archivo por defecto
	● STORED AS SEQUENCEFILE
	● STORED AS RCFILE
	● STORED AS PARQUET
	● STORED AS ORC
	● STORED AS JSONFILE
	● STORED AS AVRO

	Ejemplo 1
	---------

    USE sales;

    CREATE TABLE IF NOT EXISTS ORCtable (
    id INT,
    name STRING)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY ',';
    STORED AS ORC;

	INSERT INTO ORCtable SELECT * FROM managedtable;

	DESCRIBE FORMATTED ORCtable;

    ------------------------------------------------------------------------------------------------------------------------

    LISTAR TABLAS
    --------------

    La sentencia SHOW TABLES lista todas las tablas presentes en en la base de datos activa o podemos especificarle una 
	BBDD especifica:

                                            SHOW TABLES [IN database_name];

    ------------------------------------------------------------------------------------------------------------------------

    DESCRIPCION DE UNA TABLA
    ------------------------

    La sentencia DESCRIBE en Hive muestra la lista de columnas, su tipo de datos y comentarios de una tabla en especifico:

                                                DESCRIBE [db_name.] table_name;

    ------------------------------------------------------------------------------------------------------------------------

    ELIMINAR UNA TABLA
    ------------------

	La sentencia DROP TABLE en Hive elimina los datos de una tabla en particular y elimina todos los metadatos asociados a 
	ella del metastore de Hive.

                                        DROP TABLE [IF EXISTS] table_name;

    DROP TABLE IF EXISTS managedtable;

    ------------------------------------------------------------------------------------------------------------------------

    MODIFICAR UNA TABLA
    -------------------

    La sentencia ALTER TABLE en Hive permite modificar la estructura de una tabla existente.

    Sintáxis:

                        ALTER TABLE table_name RENAME TO new_table_name;
                        ALTER TABLE ADD COLUMNS (column1, column2);
                              

    ALTER TABLE sample1 RENAME TO sample2;
	ALTER TABLE sample2 ADD COLUMNS (column1 STRING);
    
    ------------------------------------------------------------------------------------------------------------------------	

	TRUNCAR UNA TABLA
	-----------------

	La sentencia TRUNCATE TABLE en Hive elimina todas las filas de la tabla o partición.

												TRUNCATE TABLE table_name;

	------------------------------------------------------------------------------------------------------------------------												