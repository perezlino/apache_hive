/*  MERGE FILES EN HIVE
    ===================

    En este tutorial, voy a discutir una de las técnicas de optimización en Hive, y que es el merging de archivos en Hive. Hive 
    crea internamente archivos pequeños en el cluster Hadoop cuando ejecutamos sentencias create tables o insert overwrite. Y 
    como ya sabes, Hadoop no funciona bien con archivos pequeños, porque cada archivo tiene una entrada en el name node. Así que 
    estos archivos pequeños pueden hacer que el cluster sea lento. Hive ofrece la posibilidad de fusionar (merge) un gran número 
    de archivos en un número más pequeño de archivos. Podemos ajustar algunos parámetros de configuración específicos de Hive 
    para mitigar los pequeños de archivos. Una cosa importante a mencionar aquí es que, no se confundan entre los archivos de 
    datos y los archivos generados internamente por Hive. La siguiente configuración sólo fusionará los archivos pequeños creados 
    por Hive durante la ejecución de las sentencias create table o insert. Nuestros archivos de datos reales, que contienen los 
    datos en HDFS, no se fusionarán. Esta solución no funcionará con archivos de datos HDFS, o los archivos que estamos ingiriendo 
    en HDFS a través de Scoop o cualquier otro técnica. Así que para fusionar estos archivos, tenemos que establecer algunos de 
    los ajustes. 
    
    En primer lugar es: 
    
    hive.merge.mapfiles ==> Esto fusionará los archivos pequeños producidos por los trabajos "map-only", y su valor por defecto 
                            es true. 
                            
    El segundo es: 
    
    hive.merge.mapredfiles ==> Esto fusionará los archivos pequeños que se producen a partir de MapReduce jobs, y por defecto su 
                               valor es false. 

    El siguiente es:

    hive.merge.size.per.task ==> Especifica el tamaño objetivo del merge file, o podemos decir, el archivo resultante después del 
                                 merge. Por defecto su valor es 256000000 en bytes
                                
    La última es: 
    
    hive.merge.smallfiles.avgsize ==> Siempre que el tamaño promedio del archivo de salida sea inferior a este número, mencionado 
                                      en esta propiedad, Hive ejecutará un MapReduce job adicional para fusionar los archivos 
                                      basándose en estas dos propiedades (las dos primeras) Ahora también hay una penalización por 
                                      fusionar estos archivos, ya que Hive lanzará un trabajo MapReduce adicional después de la 
                                      consulta para fusionar estos archivos pequeños. Y, además, este merge ocurre antes de intimidar 
                                      al usuario de que nuestra consulta real ha sido ejecutada.  Después de que sólo el merge se ha 
                                      completado, se indica al usuario sobre la ejecución de la consulta. Así que esto aumenta nuestro 
                                      tiempo total de rendimiento para la ejecución de la consulta. En cualquier caso, recomendaré 
                                      esta técnica de optimización siempre que la latencia no sea un problema, pero sí el espacio en 
                                      disco.                                