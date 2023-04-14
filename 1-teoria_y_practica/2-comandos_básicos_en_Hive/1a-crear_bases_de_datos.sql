/*  CREAR BASES DE DATOS
    ====================

    Bienvenidos a este vídeo. A partir de este vídeo, empezaremos nuestras prácticas. Y en primer lugar, voy a 
    crear una base de datos. Sí, me escuchaste bien, vamos a crear una base de datos. Te estarás preguntando que 
    en los videos teóricos estuve resaltando que Hive no es una base de datos, Hive no es una base de datos, y 
    aquí estoy diciendo que vamos a crear una base de datos. Chicos, tengan en cuenta que esta base de datos, la 
    estoy creando para almacenar los metadatos de una tabla. Esta base de datos no es para almacenar nuestros datos 
    reales. Nuestros datos reales se almacenarán en HDFS solamente. En realidad, mientras creamos tablas, 
    proporcionaremos un nombre de tabla, número de columnas en esa tabla, tipo de datos de las columnas, y muchas 
    otras informaciones. ¿Dónde se almacenan estos datos? Esta información se almacena en una base de datos, o 
    podemos decir meta store. Y es por eso que estamos aquí creando una base de datos, para almacenar los metadatos 
    de una tabla y no los datos reales. Así que vamos a empezar.
    

                                            Create database d1; 
    

    Le doy el nombre "d1". Mi base de datos se ha creado. Este es el comando más básico para crear una base de datos 
    "d1". En Hive, también podemos crear una base de datos usando el comando "if not exists". 
    

                                        Create database if not exists d1;
    

    Estoy creando la misma base de datos ""d1"". Aquí, He creado la misma base de datos "d1" usando el comando 
    "if not exists". 

    Y como estamos usando el comando "if not exists", Hive no nos lanzará un error en este caso. Porque si la base de 
    datos ya está presente, entonces Hive simplemente ignorará este comando. Si la base de datos D1 no hubiera estado 
    presente, entonces el comando create database if not exists habría creado una nueva base de datos D1. Mira, si creo 
    la misma base de datos, 
    

                                            Create database d1;
                                       FAILED: Execution Error, ....... 
    

    Estoy creando una base de datos D1 sin usar el comando if not exists. Esta vez Hive nos está lanzando un error que 
    la base de datos D1 ya existe. Pero en mi comando anterior, creé la misma base de datos D1 usando el comando  
    "if not exists". En este caso, incluso la base de datos D1 ya estaba creada, Hive no nos ha lanzado un error, sino 
    que simplemente ha ignorado este comando. Chicos, if not exists es un comando opcional, pueden usarlo o no. Pero les 
    recomiendo que lo usen siempre, porque en tiempo real siempre creamos bases de datos usando el comando "if not exists". 
    Después de la creación, veamos el comando "describe". El comando "describe" se utiliza para describir cualquier base 
    de datos. Entonces, 
    

                                            describe database d1; 
    

    Este es el nombre de mi base de datos, este es el directorio, la ubicación donde se almacena, y este es el usuario. 
    Como ven, mi base de datos D1 se almacena en este directorio; "hdfs://localhost:9000/user/hive/warehouse/d1.db", por 
    defecto. Esta ubicación por defecto se puede cambiar cambiando la propiedad "metastore.warehouse", que aprenderemos 
    más adelante en este curso. Por el momento, todas nuestras bases de datos se almacenarán en el directorio por defecto. 
    Y cualquier tabla que se cree en esta base de datos D1, se almacenará como un subdirectorio en esta ubicación. Por 
    ejemplo, si creamos una tabla_1 en la base de datos D1, se almacenará como "user/hive/warehouse/d1.db/table_1". 

    A continuación, también podemos crear una base de datos utilizando comentarios. El comentario se utiliza para dar alguna 
    información sobre la base de datos. 
    

                            Create database if not exists d2 comment 'This is a database';


    Para describir esta base de datos, tenemos el comando especial "extended". 
    

                                            describe database extended d2;
    

    Aquí podemos ver que este es el nombre de la base de datos, y el comentario, la ubicación, y el usuario. También podemos 
    crear una base de datos con propiedades db. Hay algunas propiedades db predefinidas vinculadas con la base de datos. Voy 
    a mencionar dos de ellas. Por lo que crear una base de datos con propiedades db es de la siguiente manera:


                create database if not exists d3 with dbproperties('creator'='alfonso','date'='2023-03-24')


    Para ver estas propiedades, tenemos que utilizar el comando "extended" al describir. 
    

                                            describe database extended d3;
    

    Ves, aqui vienen las propiedades que establecimos. Ahora si queremos ver la lista de todas las bases de datos que hemos 
    creado, entonces usamos el comando "show". 
    

                                                    show databases;
    
    
    Esta es la lista de bases de datos creadas por mi. Y aqui puedes ver una base de datos por defecto, lladada 'default'.
    Supongamos que no mencionamos ninguna base de datos al crear nuestra tabla, la tabla se almacenará en el subdirectorio 
    'default'. En caso contrario, en la base de datos que le indiquemos. Ahora si queremos que algunas tablas obtengan datos 
    bajo una base de datos en particular, entonces tenemos que usar el comando. "use". 
    
    
                                                           use d2;
    
    Despues del comando "use d2", ahora si creo una tabla, esa tabla se creara en la base de datos d2, ya que ahora Hive 
    esta usando la base de datos d2 para almacenar todo. 