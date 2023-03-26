/*  DIFERENCIA ENTRE TABLAS INTERNAS Y TABLAS EXTERNAS
    ==================================================

    Vamos a aprender lo que son las tablas internas (managed o gestionadas) y externas y sus diferencias, la principal 
    diferencia entre ambas, es que las tablas internas pertenecen y son gestionadas por Hive, mientras que las tablas 
    externas no son gestionadas por Hive.

    Vamos a explicar la diferencia entre tabla interna vs externa, creándolas, comprobando su ubicación y eliminándolas.

    Tanto las tablas gestionadas como las tablas externas se pueden identificar utilizando el comando:
    
                                            DESCRIBE FORMATTED nombre_tabla

    ------------------------------------------------------------------------------------------------------------------------

    ¿Qué es una tabla interna o gestionada por Hive?
    ------------------------------------------------

    Las Tablas Internas son también conocidas como "Managed tables" que son propiedad y están gestionadas por Hive. Por 
    defecto, Hive crea una tabla como tabla Interna y es propietaria de la estructura de la tabla y de los archivos.

    En otras palabras, Hive gestiona completamente el ciclo de vida de la tabla (metadatos y datos) de forma similar a 
    las tablas en RDBMS.

    Para las tablas internas, Hive por defecto almacena los archivos en la ubicación del data warehouse que se encuentra 
    en /user/hive/warehouse.

    Cuando se elimina una tabla interna, se eliminan los datos y los metadatos de la tabla.

    A continuación se muestra un ejemplo de creación de una tabla interna.  

                                            CREATE TABLE IF NOT EXISTS emp.employee (
                                            id int,
                                            name string,
                                            age int,
                                            gender string )
                                            COMMENT 'Employee Table'
                                            ROW FORMAT DELIMITED
                                            FIELDS TERMINATED BY ',';                                          

    Utilice: 
    
                                            DESCRIBE FORMATTED emp.employee; 
                                            
    
    para obtener la descripción de la tabla y debería ver "Table Type" como "MANAGED_TABLE". 

    ------------------------------------------------------------------------------------------------------------------------

    ¿Qué es una tabla externa de Hive?
    ----------------------------------

    Los datos de las tablas externas no pertenecen ni son gestionados por Hive. Para crear una tabla externa es necesario 
    utilizar la cláusula EXTERNAL.

    Por defecto, Hive almacena los archivos de las tablas externas también en la ubicación del data warehouse gestionado 
    por Hive, pero recomienda utilizar una ubicación externa mediante la cláusula LOCATION.

    La eliminación de una tabla externa sólo elimina los metadatos, pero no los datos reales. Los datos reales siguen siendo 
    accesibles fuera de Hive.

    A continuación se muestra un ejemplo de creación de una tabla externa en Hive. Si se ha fijado, utilizamos las opciones 
    EXTERNAL y LOCATION.

                                            CREATE EXTERNAL TABLE emp.employee_external (
                                            id int,
                                            name string,
                                            age int,
                                            gender string)
                                            ROW FORMAT DELIMITED
                                            FIELDS TERMINATED BY ','
                                            LOCATION '/user/hive/data/employee_external';

    Utilice: 
    
                                            DESCRIBE FORMATTED emp.employee_external; 
                                            
                                            
    para obtener la descripción de la tabla y debería ver el "Table Type" como "EXTERNAL_TABLE". 

    ------------------------------------------------------------------------------------------------------------------------

    Dropear Tablas Internas vs Externas
    -----------------------------------

    Independientemente de si se trata de una tabla interna o externa, Hive gestiona la definición de la tabla y la 
    información de sus particiones en Hive Metastore. Al eliminar una tabla interna, se borran los metadatos de la 
    tabla de Metastore y también se eliminan todos sus datos/archivos de HDFS.

    Al eliminar una tabla externa, sólo se eliminan los metadatos de la tabla del Metastore y se mantienen los datos 
    reales tal cual en la ubicación HDFS.

    ------------------------------------------------------------------------------------------------------------------------

    Diferencias entre tablas internas y externas
    --------------------------------------------

    A continuación se presentan las principales diferencias entre las tablas internas y externas en Apache Hive. 

    ______________________________________________________________________________________________________________________________
   |                 INTERNAL OR MANAGED TABLE	                   |                          EXTERNAL TABLE                      |  
   |---------------------------------------------------------------|--------------------------------------------------------------|
   |    Por defecto, Hive crea una Tabla Interna o Managed.	       |   Utilice la opción/cláusula EXTERNAL para crear una         |  
   |                                                               |   tabla externa.                                             |  
   |---------------------------------------------------------------|--------------------------------------------------------------|
   |    Hive posee los metadatos, datos de la tabla gestionando    |   Hive gestiona los metadatos de la tabla pero no el         |  
   |    el ciclo de vida de la tabla                               |   archivo subyacente.                                        |  
   |---------------------------------------------------------------|--------------------------------------------------------------|
   |    La eliminación de una tabla interna elimina los metadatos  |   Si se elimina una tabla externa, sólo se eliminan los      |  
   |    de Hive Metastore y los archivos de HDFS.                  |   metadatos de Metastore sin tocar el archivo real en HDFS.  | 
   |---------------------------------------------------------------|--------------------------------------------------------------|
   |    Hive soporta las operaciones ARCHIVE, UNARCHIVE, TRUNCATE, |   No es compatible                                           |  
   |    MERGE, CONCATENATE                                         |                                                              |  
   |---------------------------------------------------------------|--------------------------------------------------------------|
   |    Soporta ACID/Transactional                                 |   No es compatible                                           |          
   |---------------------------------------------------------------|--------------------------------------------------------------|
   |    Soporta caché de resultados                                |   No es compatible                                           |  
   |_______________________________________________________________|______________________________________________________________| 


    ------------------------------------------------------------------------------------------------------------------------

    Cuándo utilizar tablas externas e internas
    ------------------------------------------

    Utilice "managed tables" cuando Hive deba gestionar el ciclo de vida de la tabla, o cuando genere tablas temporales.

    Utilice tablas externas cuando los archivos ya estén presentes o en ubicaciones remotas, y los archivos deban permanecer 
    aunque se elimine la tabla.

    ------------------------------------------------------------------------------------------------------------------------

    Conclusión
    ----------

    En este artículo sobre la diferencia entre las tablas internas y externas, ha aprendido que los metadatos y los archivos 
    de las tablas internas/gestionadas pertenecen al servidor Hive y gestiona el ciclo de vida completo de la tabla, mientras 
    que las tablas externas sólo poseen los metadatos, lo que significa que al eliminar una tabla externa sólo se eliminan 
    sus metadatos, pero no el archivo real. También ha aprendido cuándo utilizar tablas internas y cuándo tablas externas.

    ------------------------------------------------------------------------------------------------------------------------