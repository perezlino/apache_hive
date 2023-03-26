/*  HIVE Y HDFS
    ===========

     _____________________________________________________________________________________________________________________
    |                                                                                                                     | 
    |   Tenga en cuenta que el directorio "/user/hive/warehouse" en sí está presente en HDFS, pero este directorio está   |  
    |   totalmente controlado por Hive y la seguridad HDFS para este directorio está fuera del alcance.                   |         
    |_____________________________________________________________________________________________________________________|


    ¿Dónde almacena Hive los archivos de datos en HDFS?
    ---------------------------------------------------

    Hive almacena los datos en la carpeta /user/hive/warehouse de HDFS si no se especifica una carpeta utilizando 
    la cláusula LOCATION al crear una tabla. Hive es un data warehouse database para Hadoop, todos los archivos de 
    datos de base de datos y tablas se almacenan en la ubicación HDFS /user/hive/warehouse por defecto, también 
    puede almacenar los archivos Hive data warehouse ya sea en una ubicación personalizada en HDFS, S3, o cualquier 
    otro sistema de archivos compatible con Hadoop.

    Cuando se trabaja con Hive, es necesario conocer 2 almacenes de datos diferentes:

    ● Hive Metastore
    ● Hive Data warehouse Location (Donde se almacenan los datos de las tablas reales)


    Ubicación del Hive Metastore
    ----------------------------

    Hive Metastore se utiliza para almacenar los metadatos sobre la base de datos y las tablas y, por defecto, 
    utiliza la base de datos Derby; Puede cambiar esto a cualquier base de datos RDBMS como MySQL y Postgress etc.

    Por defecto el nombre de la base de datos del metastore es "metastore_db".


    ¿Dónde almacena Hive las tablas en HDFS?
    ----------------------------------------

    Hive almacena las tablas por defecto en /user/hive/warehouse en el sistema de archivos HDFS. Es necesario crear 
    estos directorios en HDFS antes de utilizar Hive.

    En esta ubicación, puede encontrar los directorios para todas las bases de datos que cree y subdirectorios con el 
    nombre de la tabla que utilice.

    Al crear tablas Hive, también puede especificar la ubicación personalizada donde almacenar.


    Obtener la ruta de almacenamiento desde Property
    ------------------------------------------------

    En caso de tener una ubicación diferente, puede obtener la ruta de la property "hive.metastore.warehouse.dir" y esto 
    se puede obtener ejecutando el siguiente comando desde un terminal CLI Hive Beeline:

                                            set hive.metastore.warehouse.dir;

    Y obtenemos:
    hive.metastore.warehouse.dir=/user/hive/warehouse

