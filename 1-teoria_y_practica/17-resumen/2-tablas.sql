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

    2.- hdfs dfs -copyFromLocal data.txt /user/bigdata/filesdata 

    LOAD DATA INPATH '/user/bigdata/filesdata/data.txt' INTO TABLE employee;

    SELECT * FROM employee;

    ------------------------------------------------------------------------------------------------------------------------

    EJEMPLO 2 - CREAR UNA TABLA 
    ---------------------------	