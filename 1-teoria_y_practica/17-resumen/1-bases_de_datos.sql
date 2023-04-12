/*  RESUMEN TEORIA BASES DE DATOS
    =============================

    CREAR BASES DE DATOS
    --------------------

    Sintáxis:

                                        CREATE (DATABASE|SCHEMA)[IF NOT EXISTS] database_name
                                        [COMMENT database_comment]
                                        [LOCATION hdfs_path]
                                        [MANAGEDLOCATION hdfs_path]
                                        [WITH DBPROPERTIES (property_name=property_value, ...)];

    CREATE DATABASE IF NOT EXISTS marketing
    COMMENT 'stores all Marketing data'
    LOCATION '/user/bigdata/hive/MARKETING.db'
    WITH DBPROPERTIES('purpose'='marketing');

    CREATE DATABASE IF NOT EXISTS sales
    COMMENT 'stores all Sales data'
    LOCATION '/user/bigdata/hive/SALES.db'
    WITH DBPROPERTIES('purpose'='sales');  

    ------------------------------------------------------------------------------------------------------------------------

    ELIMINAR BASE DE DATOS
    -----------------------

    Sintáxis:

                                        DROP (DATABASE|SCHEMA)[IF EXISTS] database_name;

    DROP DATABASE IF EXISTS mark

    ------------------------------------------------------------------------------------------------------------------------

    MODIFICAR BASE DE DATOS
    -----------------------

    Una vez creada una base de datos, puede modificar sus propiedades de metadatos (DBPROPERTIES) o su OWNER mediante el 
    comando ALTER DATABASE.

    Sintáxis:

                        ALTER (DATABASE|SCHEMA) database_name SET DBPROPERTIES (property_name=property_value, ...);
                        ALTER (DATABASE|SCHEMA) database_name SET OWNER[USER|ROLE] user_or_role;
                        ALTER (DATABASE|SCHEMA) database_name SET LOCATION hdfs_path;
                        ALTER (DATABASE|SCHEMA) database_name SET MANAGEDLOCATION hdfs_path;         

    ALTER DATABASE sales
    SET DBPROPERTIES ('department'='USASALES');
    
    ------------------------------------------------------------------------------------------------------------------------

    UTILIZAR UNA BASE DE DATOS
    --------------------------

    USE DATABASE se utiliza para cambiar de base de datos. USE establece la base de datos actual para todas las sentencias 
    HiveQL posteriores. Para volver a la base de datos predeterminada, utilice la palabra clave "default" en lugar del nombre 
    de la base de datos.

                                                        USE database_name;
                                                        USE default;

    ------------------------------------------------------------------------------------------------------------------------

    LISTAR BASES DE DATOS
    ---------------------

    La sentencia SHOW DATABASES lista todas las bases de datos presentes en Hive.

                                                        SHOW DATABASES;

    ------------------------------------------------------------------------------------------------------------------------

    DESCRIPCION DE UNA BASE DE DATOS
    --------------------------------

    La sentencia DESCRIBE DATABASE en Hive muestra el nombre de la base de datos en Hive, su comentario (si está definido), 
    su ubicación en el sistema de archivos y su Owner.

                                                DESCRIBE DATABASE db_name;

    ------------------------------------------------------------------------------------------------------------------------