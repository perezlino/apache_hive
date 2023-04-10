/*  INTRODUCCION A LA CREACION DE INDICES
    =====================================

    Voy a hablar de la indexación en Hive. Un index actúa como una referencia a los registros. El índice nos permite 
    acelerar la búsqueda de datos, ya que en lugar de buscar en todos los registros, podemos referirnos al index para 
    buscar un registro en particular. Los índices mantienen la referencia de los registros. Sin un índice, las consultas 
    que tienen una cláusula WHERE, como WHERE columna_1=100, cargan toda la tabla o partición y procesan todas las filas 
    buscando la columna_1=100. Pero si hay un índice presente para la columna_1=100, las consultas que no tienen un 
    índice cargan toda la tabla o partición y procesan todas las filas buscando la columna_1=100. Pero si existe un index 
    para la columna_1, sólo se buscará en esa parte de los datos. Ahora surge la pregunta, la partición también hace lo 
    mismo. Pero aquí hay una diferencia en ambos que la partición proporciona la segregación de los datos en el nivel HDFS, 
    creando subdirectorios para cada partición. Pero la indexación se realiza a nivel de tabla. Los indexes se utilizan 
    para acelerar la búsqueda de datos dentro de las tablas. 
    
    ¿Cuál es la necesidad de indexar en Hive?
    ----------------------------------------- 
    
    Como sabemos, Hive es una herramienta de almacenamiento de datos sobre Hadoop. Se ocupa de los tamaños de archivo que 
    van hasta terabytes. Ahora si queremos realizar cualquier operación o consulta sobre esta enorme cantidad de datos, 
    tomará una gran cantidad de tiempo, porque las consultas se ejecutarán en todas las columnas presentes en la tabla. 
    Pero si usamos indexación en esa columna, la consulta comprueba primero el index, y luego va a una columna en particular 
    y realiza la operación. Esto nos ahorra tiempo y recursos. 
    
    Creación de un INDEX
    --------------------
    
    Ahora crearemos un index. Antes de ir, te muestro la tabla sobre la que se realizará el indexado:
    
    Debemos crear la tabla de departamentos previamente: 
    
                                CREATE TABLE IF NOT EXISTS data_tab (
                                col1 int,
                                col2 string,
                                col3 string,
                                col4 string,
                                ) 
                                ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
                                LINES TERMINATED BY'\N'
                                STORED AS TEXTFILE;

                                LOAD DATA LOCAL INPATH '/home/alfonso/data.txt' INTO TABLE data_tab;    
    
    Usamos la tabla de departamento:

                                                SELECT * FROM data_tab;
    

    data_tab.col1      data_tab.col2     data_tab.col3      data_tab.col4
    1        gopal        TP        2012
    2        kiran        HR        2012
    3        kaleel       TP        2012
    4        Prasanth     HR        2012
    5        Nishant      TP        2012
    6        Rahul        HR        2012
    7        Chahat       TP        2013
    8        Parun        HR        2013
    9        Bhavi        TP        2013
    10       Sukhbir      HR        2013
    11       karunesh     TP        2013
    12       Karan        HR        2013
    13       Shama        TP        2013
    14       Sumit        HR        2013
    15       Virat        TP        2013
    16       Rohit        HR        2013
    17       Gourav       TP        2014
    18       Sourav       HR        2014
    19       Kunal        TP        2014
    20       Venus        HR        2014
    21       Vinay        TP        2014
    22       Shivam       HR        2014
    
    
    Estos son los contenidos de la tabla. Ahora escribiremos la sintaxis del index:


                        CREATE INDEX i1 ON TABLE data_tab(col3) AS 'COMPACT' WITH deferred rebuild; 


    
    Ahora, ¿por qué he utilizado "compact"? En realidad, podemos crear dos tipos de indices en una tabla: "compact" y 
    "bitmap". Ambos servirán para el mismo propósito, pero pueden dar diferentes tiempos de búsqueda basados en los datos 
    de las columnas indexadas. La principal diferencia entre los índices compactos y los de mapa de bits es que los valores 
    asignados a las filas se almacenan en bloques diferentes. Ahora sabemos que los datos en HDFS se distribuyen a través 
    de los nodos en un clúster. Tiene que haber una identificación adecuada de los datos, como los datos en la indexación 
    por bloques. Debemos ser capaces de identificar qué fila está presente en qué bloque, de modo que cuando se lanza una 
    consulta, puede ir directamente a ese bloque. La indexación compacta almacena el par de valores de la columna indexada y 
    su ID de bloque. Considerando que, el índice bitmap almacena la combinación del valor de la columna indexada y la lista 
    de filas como un mapa de bits. El mapa de bits es sólo un tipo de organización de memoria, o podemos decir formato de 
    archivo de imagen que se utiliza para almacenar imágenes digitales. Al final, ambos servirán para el mismo propósito, la 
    única diferencia es el almacenamiento de índices; como almacenan los index. Y a veces también hay una diferencia entre 
    el tiempo de consulta en ambos. 

    Ahora, ¿por qué he usado "with deferred rebuild" aquí? Esta declaración debe estar presente en el índice creado porque 
    podemos tener que alterar el índice en etapas posteriores utilizando la sentencia ALTER. Supongamos que hemos creado un 
    index en una tabla con un contenido inicial. Más tarde, los datos cambian en la tabla base, pero nuestra tabla de índices
    no lo sabe. Asi que para actualizar la tabla index, tenemos que reconstruirla usando el comando ALTER.


                                            ALTER INDEX i1 ON data_tab rebuild; 


    Ahora una cosa importante a tener en cuenta es, que mientras se crea un índice con la cláusula "deferred rebuild", 
    entonces el índice recién creado está inicialmente vacío, independientemente de si esa tabla contiene datos o no. El 
    ALTER INDEX se utiliza para construir la estructura de índices de nuestra tabla. Como en nuestro caso también, nuestra
    tabla index estaba vacía al principio. Desde la primera sentencia hasta la segunda, nuestra tabla index_table estaba 
    vacia. Solo después de alterar la tabla con el comando "rebuild", nuestra tabla index se llena. Nuestra tabla index 
    estaba vacia hasta la segunda sentencia (CREATE INDEX ...). Ahora cuando hemos disparado nuestro comando ALTER, nuestra 
    tabla index se poblará después de este comando. También podemos crear índices de otras formas. Como nuestra index table 
    es también una tabla, podemos almacenarla en cualquier formato de archivo.   

    Voy a crear otro index:


                CREATE INDEX i2 ON TABLE data_tab(col3) AS 'COMPACT' WITH deferred rebuild STORED AS rcfile;


    Voy a crear otro index. También podemos crear una tabla index usando las propiedades del index y las propiedades de la 
    tabla:


    CREATE INDEX i3 ON TABLE data_tab(col3) AS 'COMPACT' 
    WITH deferred rebuild 
    ROW FORMAT DELIMITED FIELDS BY ','
    LINES TERMINATED BY '\n'
    STORED AS textfile;                    