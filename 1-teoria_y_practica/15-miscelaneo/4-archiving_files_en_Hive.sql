/*  ARCHIVING FILES EN HIVE
    =======================

    En esta lección voy a explicar el archivado en Hive. Archivar significa transferir los datos a un medio de almacenamiento 
    de uso menos frecuente para que los datos de uso frecuente puedan colocarse allí. En la mayoría de los casos, archivamos 
    los datos antiguos porque se utilizan menos. Ahora surge la pregunta, ¿por qué necesitamos archivar? La respuesta es, 
    archivamos para reducir la carga del name node, porque para cada archivo presente en HDFS, tiene que haber una entrada 
    para él en el name node. Esto parece bien cuando el número de archivos es menor, pero cuando el número llega a millones 
    entonces afecta directamente al consumo de memoria en el name node. En estas situaciones, es ventajoso tener el menor 
    número de archivos posible. Hive tiene soporte incorporado para convertir los archivos de las particiones existentes en 
    archivos Hadoop, también conocido como HAR. De modo que la partición que una vez tuvo 100 archivos, ahora contiene sólo 
    4-5 archivos basados en los ajustes que hemos hecho. Antes de archivar, hay que hacer tres ajustes. He enumerado estos 
    tres ajustes: 
    
    ● En primer lugar, debemos habilitar el archivado. Por defecto, en Hive, el archivado está desactivado. En primer lugar, 
      tenemos que hacer que se active mediante el establecimiento de esta propiedad:

                                                set hive.archive.enabled=true;

    ● Esta propiedad informa a Hive de si se puede establecer el directorio principal (parent directory) al crear los archivos HAR.

                                        set hive.archive.har.parentdir.settable=true;

    ● Ahora la tercera propiedad. Esto controla el tamaño de los archivos que componen el archivado.

                                            set har.partfile.size=1099511627776;

    Dado que la ejecución de los comandos de archivado puede tardar hasta minutos, sólo voy a mostrar los dos comandos que utilizamos 
    para archivar. El primer comando es simple, estamos archivando la tabla_10. Dentro de la tabla_10, estamos archivando la partición 
    2012. Después de disparar este comando, un MapReduce job será lanzado el cual guardará nuestra partición en un archivo HAR. 

                                        ALTER TABLE table10 ARCHIVE PARTITION (year=2012);  

    Ahora de nuevo, si tenemos que desarchivar esa partición, vamos a disparar este comando, y este comando también se pondrá en marcha 
    un MapReduce job.

                                        ALTER TABLE table10 UNARCHIVE PARTITION (year=2012);                                                                                                                                             

    Hay una cosa a tener en cuenta, que el archivado no hace ahorro de espacio en HDFS porque estamos poniendo los archivos de HDFS a 
    HDFS solamente. No estamos sacando los archivos de HDFS, solo estamos juntando esos archivos en uno. Estamos dando una dirección 
    al "name node". Así que sólo reduce la carga del name node, pero no reduce el espacio en el HDFS.                                       