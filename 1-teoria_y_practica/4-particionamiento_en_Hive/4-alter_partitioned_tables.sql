/*  ALTER PARTITIONED TABLES
    ========================

    Hace un momento hemos visto cómo crear tablas particionadas y cargar datos en ellas. Ahora veamos cómo modificar 
    una tabla particionada. Obviamente, en tiempo real, hay que añadir/eliminar (add/drop) particiones de una tabla con 
    mucha frecuencia. Empecemos por "Eliminar una partición". Pero antes de eso, déjame mostrarte las particiones que 
    tengo. Este es el comando si quieres ver las particiones dentro de una tabla: "show partitions". Uso sólo la tabla 
    anterior:


                                                SHOW PARTITIONS part_dept1;


    partition
    deptname=Accounts
    deptname=HR
    deptname=Marketing
    deptname=Sales

    ------------------------------------------------------------------------------------------------------------------------

    ELIMINAR UNA PARTICIÓN
    ----------------------

    Así que ahora mismo, tenemos cuatro particiones. Ahora para eliminar cualquier partición de esta tabla, utilizamos 
    "ALTER TABLE DROP" y especificamos la partición. La partición se elimina:


                                ALTER TABLE part_dept1 DROP PARTITION (deptname = 'HR')                                                         


    Por favor, recuerden que como esta tabla part_dept1 estaba en una tabla interna, tanto los datos como los metadatos 
    se perdieron. Pero si hubiera sido una tabla externa, entonces la partición de aquí no estaría presente y no se podría 
    consultar, pero en HDFS habría estado presente. 

    ------------------------------------------------------------------------------------------------------------------------

    AÑADIR UNA PARTICIÓN
    --------------------

    El siguiente paso es añadir una partición:


                                ALTER TABLE part_dept1 ADD PARTITION (deptname = 'Dev')        


    Hemos añadido una nueva partición. Pero hay que tener en cuenta que se trata de una partición vacía y no contiene 
    ningún dato. Tenemos que insertar manualmente los datos en él mediante el uso de INSERT o el comando LOAD. Para hacer 
    la carga en esta partición "Dev", le cargaremos el archivo "dev.txt" usando el comando LOAD:


                LOAD DATA LOCAL INPATH '/home/alfonso/files' INTO TABLE part_dept1 PARTITION (deptname ='Dev');                                 


    ------------------------------------------------------------------------------------------------------------------------

    ¿QUE PASA SI CREAMOS EN HDFS LA CARPETA DE UNA PARTICIÓN PRIMERO ANTES DE CREAR LA PARTICIÓN EN SI?
    ---------------------------------------------------------------------------------------------------

    Desde HDFS revisamos nuestras particiones:
    (Asi lo hizo en la clase ===> bin/hadoop fs -ls user/hive/warehouse/part_dept1)


                                        hdfs dfs -ls user/hive/warehouse/part_dept1


    Tenemos 4 directorios (4 particiones):

                                    "user/hive/warehouse/part_dept1/deptname=Accounts"
                                    "user/hive/warehouse/part_dept1/deptname=Dev"
                                    "user/hive/warehouse/part_dept1/deptname=Marketing"
                                    "user/hive/warehouse/part_dept1/deptname=Sales"    


    Si creamos una carpeta para una partición desde HDFS:


                            hdfs dfs -mkdir user/hive/warehouse/part_dept1/deptname=Production    

    Y luego revisamos:

                                        hdfs dfs -ls user/hive/warehouse/part_dept1

    Y nos devuelve 5 directorios:

                                    "user/hive/warehouse/part_dept1/deptname=Accounts"
                                    "user/hive/warehouse/part_dept1/deptname=Dev"
                                    "user/hive/warehouse/part_dept1/deptname=Marketing"
                                    "user/hive/warehouse/part_dept1/deptname=Production"
                                    "user/hive/warehouse/part_dept1/deptname=Sales" 


    Pero si desde Hive, visualizamos las particiones, esta carpeta que hemos creado NO VA A APARECER. 
    
                                        SHOW PARTITIONS part_dept1;

    Y obtenemos:

    partition
    deptname=Accounts
    deptname=Dev
    deptname=Marketing
    deptname=Sales                                            
    
    
    Por tanto, para "ACTIVARLA" tenemos 2 opciones:

    1.- Es utilizando ====> ALTER TABLE part_dept1 ADD PARTITION (deptname='Production');

    2.- Es utilizando ====> MSCK REPAIR TABLE part_dept1;


    Utilizando cualquiera de estas dos opciones vamos a "activar" el directorio de partición.

    ------------------------------------------------------------------------------------------------------------------------