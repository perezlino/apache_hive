/*  CARGAR UN ARCHIVO CSV EN UNA TABLA HIVE
    =======================================

    Utilice el comando LOAD DATA para cargar los archivos de datos como CSV en Hive Managed (tabla interna) o 
    tabla externa. En este artículo, voy a explicar cómo cargar archivos de datos en una tabla utilizando varios 
    ejemplos.

    Normalmente, el comando Hive Load sólo mueve los datos de la ubicación LOCAL o HDFS a la ubicación del Hive 
    Data Warehouse o a cualquier ubicación personalizada sin aplicar ninguna transformación.


    Sintaxis del comando Hive LOAD
    ------------------------------

    A continuación se muestra la sintaxis del comando Hive LOAD DATA:

                            LOAD DATA [LOCAL] INPATH 'filepath' [OVERWRITE] 
                            INTO TABLE tablename [PARTITION (partcol1=val1, partcol2=val2 ...)] 
                            [INPUTFORMAT 'inputformat' SERDE 'serde']

    Dependiendo de la versión de Hive que esté utilizando, la sintaxis de LOAD cambia ligeramente. Consulte el 
    documento DML de Hive.

    ● filepath - Admite rutas absolutas y relativas. Si utiliza la cláusula opcional LOCAL el filepath especificado 
               será referido desde el servidor donde se está ejecutando hive beeline de lo contrario utilizará el 
               path de HDFS.
    ● LOCAL - Utilice LOCAL si tiene un archivo en el servidor donde se está ejecutando beeline.
    ● OVERWRITE - Borra el contenido existente de la tabla y lo reemplaza con el nuevo contenido.
    ● PARTITION - Carga los datos en la partición especificada.
    ● INPUTFORMAT - Especifica el formato de entrada de Hive para cargar un formato de archivo específico en la tabla, 
                    toma TEXTO, ORC, CSV, etc.
    ● SERDE - puede ser el Hive SERDE asociado.                          


    Ejemplo ---> Creamos una Base de datos y una tabla
    ---------------------------------------------------

    Creamos la base de datos 'emp' (aún no se como indicar una ruta personalizada al crear una BD, debo indicar una,
    si no se indica ninguna BD, serán almacenadas en la base de datos 'default'):

                                    CREATE DATABASE IF NOT EXISTS emp;


    Para cargar el archivo CSV separado por comas en la tabla Hive, debe crear una tabla con 
    ROW FORMAT DELIMITED FIELDS TERMINATED BY ','.

                                            CREATE TABLE IF NOT EXISTS emp.employee (
                                            id int,
                                            name string,
                                            age int,
                                            gender string )
                                            COMMENT 'Employee Table'
                                            ROW FORMAT DELIMITED
                                            FIELDS TERMINATED BY ',';

    Si no indicamos un LOCATION personalizado, la ubicación de la tabla será en la ruta por defecto:

                                                 /user/hive/warehouse/
     _____________________________________________________________________________________________________________________
    |                                                                                                                     | 
    |   Tenga en cuenta que este directorio en sí está presente en HDFS, pero este directorio está totalmente controlado  |  
    |   por Hive y la seguridad HDFS para este directorio está fuera del alcance.                                         |         
    |_____________________________________________________________________________________________________________________|

    ------------------------------------------------------------------------------------------------------------------------                                            

    Cargar archivo CSV desde HDFS
    -----------------------------

    La sentencia Hive LOAD DATA se utiliza para cargar el archivo de texto, CSV, ORC en la tabla. La sentencia Load hace 
    lo mismo independientemente de si la tabla es Managed/Internal o External.

    Veamos ahora cómo cargar un archivo de datos en la tabla Hive que acabamos de crear.

    ● Crear un archivo de datos (para nuestro ejemplo, estoy creando un archivo con columnas separadas por comas)
    ● Ahora utilice el comando Hive LOAD para cargar el archivo en la tabla. 

                        LOAD DATA INPATH '/user/hive/data/data.csv' INTO TABLE emp.employee;                                           
     _______________________________________________________________________________________________________________________
    |                                                                                                                       |    
    |   Tenga en cuenta que después de cargar los datos, el archivo de origen se eliminará de la ubicación de origen y el   | 
    |   archivo se cargará en la ubicación de Hive data warehouse o en la LOCATION especificada al crear una tabla.         | 
    |                                                                                                                       |
    |   hdfs dfs -ls /user/hive/warehouse/emp.db/employee/                                                                  |
    |   -rw-r--r--   1 hive supergroup         52 2020-10-09 19:29 /user/hive/warehouse/emp.db/employee/data.txt  <----     |
    |                                                                                                                       |
    |_______________________________________________________________________________________________________________________|


    Utilice el comando SELECT para obtener los datos de una tabla y confirme que los datos se han cargado correctamente sin 
    ningún problema.

                                            SELECT * FROM emp.employee

    ------------------------------------------------------------------------------------------------------------------------

    Cargar archivo CSV desde el sistema de archivos LOCAL
    -----------------------------------------------------

    Utilice la cláusula opcional LOCAL para cargar el archivo CSV desde el sistema de archivos local en la tabla Hive sin 
    cargarlo en HDFS.

                            LOAD DATA LOCAL INPATH '/home/hive/data.csv' INTO TABLE emp.employee;                                            

    A diferencia de la carga desde HDFS, el archivo fuente del sistema de archivos LOCAL no será eliminado.

    ------------------------------------------------------------------------------------------------------------------------    

    Utilizar la cláusula OVERWRITE
    ------------------------------

    Utilice la cláusula opcional OVERWRITE del comando LOAD para eliminar el contenido de la tabla de destino y reemplazarlo 
    con los registros del archivo referido.

                        LOAD DATA LOCAL INPATH '/home/hive/data.csv' OVERWRITE INTO TABLE emp.employee;      

    ------------------------------------------------------------------------------------------------------------------------                                              

    Utilizar la cláusula PARTITION
    ------------------------------

    Si tiene una tabla particionada, utilice la cláusula opcional PARTITION para cargar datos en particiones específicas de 
    la tabla. también puede utilizar OVERWRITE para eliminar el contenido de la partición y volver a cargar. 

                LOAD DATA LOCAL INPATH '/home/hive/data.csv' OVERWRITE INTO TABLE emp.employee PARTITION(date=2020);   

    ------------------------------------------------------------------------------------------------------------------------

    Utilizar INSERT INTO
    --------------------

    Al igual que SQL, también puede utilizar INSERT INTO para insertar filas en la tabla Hive. 

    INSERT INTO emp.employee VALUES(7,'scott',23,'M');
    INSERT INTO emp.employee VALUES(8,'raman',50,'M');    

    ------------------------------------------------------------------------------------------------------------------------                               