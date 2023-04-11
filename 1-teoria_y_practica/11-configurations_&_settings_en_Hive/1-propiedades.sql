/*  PROPIEDADES
    ===========

    En esta lección, estoy explicando varios ajustes de configuración en Hive. estos ajustes se pueden hacer a nivel de Hive 
    o de Hadoop. Sin duda, estas propiedades se pueden establecer en "hive.xml" o .HiveRC File también, como he explicado en 
    mis videos anteriores. Pero los ajustes que varían de sesión a sesión, y no necesitan el mismo valor para varias sesiones, 
    se establecen explícitamente en cada sesión de Hive. Tengan en cuenta que estas propiedades que se establecen en una sesión 
    Hive tienen un alcance limitado a esa sesión Hive solamente, no tienen su efecto en otras sesiones Hive. 
    
    Empezando por el tamaño de bloque, la propiedad es: 
    
                                                        set dfs.block.size;
    
    dfs.block.size=67108864

    Aquí, el valor por defecto para esta propiedad se establece en esto. Y con respecto a esta propiedad, esta configuración 
    determina el tamaño del bloque físico en un cluster Hadoop. Por defecto, en Hadoop 1, es de 64 MB, y en Hadoop 2, es de 128 MB. 
    Esta propiedad juega un papel importante a la hora de decidir el tamaño de la división de entrada. 
    
    Y la siguiente es: 
    
                                                    set parquet.block.size;

    parquet.block.size is undefined                                                    

    Esta propiedad especifica el tamaño máximo de cada archivo de datos Parquet producido cuando tenemos nuestra tabla almacenada en 
    formato Parquet. Ambos, el Hadoop data block size y Parquet block size, es necesario establecer lo mismo, porque queremos que un 
    bloque de parquet quepa dentro de un bloque HDFS. Esta vez se mostrará indefinido porque estoy usando el formato de archivo por 
    defecto como formato de archivo de texto.   

    Pasando a este formato de archivo, nuestra siguiente propiedad es:
    
                                                    set hive.default.fileformat; 
    
    hive.default.fileformat=TextFile

    Por defecto, es text file. Esta propiedad, como su nombre indica, establece el formato de archivo predeterminado que Hive utiliza 
    si no mencionamos ningún formato al crear la tabla. Por defecto es "text file".Supongamos que queremos modificar este valor:

                                                 set hive.default.fileformat=orc;  

    Ahora bien, si no doy ningún valor en "STORED AS" al crear una tabla, elegirá por defecto el tipo de archivo como ORC. Para
    verificar el cambio utilizamos:

                                                    DESC FORMATTED nombre_tabla;  

    A continuación, la siguiente propiedad es: 
    
                                                set hive.mapred.mode=nonstrict;
    
    Por defecto, es no estricto. Esta propiedad está asociada a varios comandos en Hive, como en la cláusula ORDER BY. Si esta 
    propiedad es "strict", la cláusula ORDER BY debe ir seguida de una cláusula LIMIT. Pero si esta propiedad es "non strict", 
    entonces la cláusula LIMIT se convierte en opcional. Como usted sabe, la cláusula ORDER BY utiliza un reducer, y los datos están 
    en GBs. Entonces, la salida de estos GBs de datos a través de un solo reducer puede tomar mucho tiempo, haciendo que nuestro 
    cluster sea lento. Pero si el modo "strict" está presente, entonces por la cláusula LIMIT, tenemos que mencionar el número de 
    filas a la salida, y las filas serán mucho menos que el total de filas. Así que, mediante el uso de este modo strict, estamos 
    reduciendo la carga de nuestro reducer.  

    Pasando a la siguiente propiedad:

                                            set hive.groupby.orderby.position.alias=true;      

    Se utiliza en la cláusula ORDER BY. Esta propiedad se introdujo en la versión 0.11 de Hive. Antes, las columnas se especificaban 
    por el nombre. Pero si esta propiedad se establece en true, entonces podemos utilizar el número de posición de las columnas en 
    lugar de sus nombres en el comando ORDER BY. Por defecto, esta propiedad está en false. 

    Ahora pasamos a la configuración del reductor. En primer lugar es:

                                                    set mapred.reduce.tasks = 1;                                                                                          

    Esta propiedad sirve para establecer el número de "reducers" que se utilizarán en un job. Por defecto, Hive elige por sí mismo 
    el número de "reducers" a utilizar en un job, considerando varios factores, como la naturaleza del comando y la cantidad de datos 
    a procesar. Pero si no queremos que Hive decida el número de reductores, podemos codificar este valor a cualquier número. Ahora 
    supongamos, aquí estoy usando a 1. Así que estoy diciendo Hive, no importa, cualquiera que sea la naturaleza del job es, tienes 
    que usar sólo un Reducer en cualquier job.                                                    

    Y la siguiente es: 
    
                                            set hive.exec.reducers.bytes.per.reducer;

    Esta es otra forma de determinar el número de "reducers" a utilizar en un job. Esta propiedad especifica el número de bytes que 
    se debe dar a cada "reducer". Por defecto, es de 256 MB. Ahora supongamos, si tengo 512 MB de datos, entonces de acuerdo a esta 
    propiedad, dos "reducers" serán usados, porque 256 MB de datos serán dados a un "reducer", y el siguiente "reducer" recibirá 
    256 MB.

    Y la siguiente es: 
    
                                                    set hive.exec.reducers.max;

    Por defecto, su valor es 1009. Esta propiedad es para restringir el número máximo de reducers que se utilizarán en un job. Por 
    defecto, su valor es 1009. Esto significa que en cualquier job, se puede utilizar esta cantidad de reducers.   

    Pasamos al siguiente conjunto de configuraciones. Primero, Tengo la propiedad de establecer "speculative.execution" a true. Pero 
    antes de eso, deberías saber qué es. Es una técnica que permite al master node ejecutar una copia del nodo en algún otro nodo. En 
    el caso cuando un nodo parece estar ejecutando una tarea más lentamente, la aplicación Master puede ejecutar redundantemente el 
    mismo job o tarea en otro nodo. Mientras tanto, el nodo anterior también estará ejecutando la tarea. Al mismo tiempo tenemos los 
    mismos jobs ejecutándose en dos nodos diferentes. La tarea que termine primero será aceptada y la otra será eliminada. Ahora, 
    ¿por qué hacemos la "speculative.execution" y cuáles son sus ventajas? Las ventajas de la "speculative.execution" es que, reduce 
    el tiempo de trabajo si el progreso de la tarea es lento, debido a la indisponibilidad de memoria en el nodo en el que se está 
    ejecutando actualmente. En ese caso, cambiar a otro nodo es beneficioso. Pero también conlleva una penalización, como en el caso 
    en que la tarea es lenta debido a los cálculos complejos y algoritmos. En ese caso ejecutar la misma tarea en algún otro nodo no 
    nos ayudará. Más bien disminuirá el rendimiento global de nuestro cluster, ya que ahora tendremos dos tareas redundantes 
    ejecutándose en dos nodos diferentes inútilmente. Así que debemos configurar esta propiedad con mucho cuidado. Ahora en 
    "speculative.execution" también, tenemos dos opciones. La primera es, si queremos que esta propiedad se ejecute sólo en la
     "map task", entonces tenemos: 
    
                                            set mapred.map.tasks.speculative.execution; 

    set mapred.map.tasks.speculative.execution=true

    Por defecto es true. Si usted sabe que su trabajo será lento o su tarea será lenta debido a los complejos algoritmos en ella, 
    entonces usted puede hacer esta propiedad a false para evitar la redundancia de las tareas.

    Ahora la misma propiedad podemos hacerla para los reducers también: 
    
                                            set mapred.reduce.tasks.speculative.execution;

    set mapred.reduce.tasks.speculative.execution=true                                            

    Esta propiedad también es por defecto true. Si lo deseas, puede hacer que sea falsa. 

    La siguiente propiedad es:

                                                    set hive.enforce.bucketing;

    set hive.enforce.bucketing=false

    Por defecto es false. Esta propiedad debe ser verdadera si desea que los datos de la tabla se almacenen en buckets. 

    La siguiente propiedad es:

                                                    set hive.auto.convert.join = true;

    Lo estoy poniendo true. Esta propiedad debe ser true si queremos que Hive haga el map join automáticamente cuando detecte un 
    join en tablas pequeñas.                                                    