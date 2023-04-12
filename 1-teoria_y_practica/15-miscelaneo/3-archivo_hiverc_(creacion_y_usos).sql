/*  ARCHIVO HIVERC (CREACION Y USOS)
    ================================

    En esta lección, vamos a discutir sobre HiveRC File y el producto cartesiano. Ambos son temas diferentes y no están 
    relacionados entre sí, pero simplemente estoy cubriendo estos temas en una sola clase. Así que en primer lugar, HiveRC 
    File es un archivo que se ejecuta cuando lanzamos el Hive shell. Cada vez que escribimos Hive y pulsamos enter, este 
    archivo se ejecuta en el backend. El archivo HiveRC es un lugar ideal para añadir configuraciones o personalizaciones de 
    Hive que queremos establecer al iniciar el intérprete de comandos de Hive. En cualquier momento, podemos establecer estas 
    configuraciones en nuestra sesión de Hive también, pero se limitan a esa sesión solamente. Así que en primer lugar, voy 
    a mostrar cómo funciona la configuración dentro de una sesión. Este es el Hive normal sin ningún archivo RC. Supongamos 
    que estoy estableciendo una configuración en una sesión Hive: 
    
                                            set hive.cli.print.header=true;
    
    Por defecto, es "false". Esta propiedad es para imprimir el encabezado en las tablas. He hecho esta propiedad a "true" para 
    una sesión. Ahora esta propiedad ha hecho que esto sea "true" solo para esta sesión en particular. Ahora supongamos, si salgo 
    de esta sesión. De nuevo, lanzando el Hive shell, una nueva sesión. Ahora voy a comprobar esta propiedad 
    "set hive.cli.print.header". Nos está mostrando "false", porque esa propiedad se estableció en "true" sólo para esa sesión. 
    Ahora para que esta configuración sea común para todas las sesiones de Hive, añadiremos esta configuración en el archivo HiveRC. 
    Además, establecer las configuraciones cada vez en cada nueva sesión es un trabajo tedioso y es repetir trabajo. Hay algunas 
    configuraciones comunes que generalmente se establecen en el archivo HiveRC. Estos son, como establecer los encabezados de 
    columna, la misma configuración que acabo de establecer. Luego, hacer que el nombre de la base de datos actual forme parte del 
    prompt de Hive, añadir archivos jar y registrar UDFs. 
    
    Así que en primer lugar, para crear el archivo HiveRC, necesitamos conocer su ubicación. La ubicación del archivo HiveRC es
    "hiveconf directory". Así que iremos a este directorio hiveconf:

    cd $HIVE_HOME
    ls           <------------- Exploramos lo que existe dentro de HIVE_HOME
    cd conf      <------------- Este es mi directorio hiveconf
    vi .hiverc   <------------- Ahora dentro de esto, tengo que crear un archivo .HiveRC. Así que voy a utilizar el editor VI

    Ahora en este editor o en este archivo, podemos establecer cualquier configuración. Voy a establecer lo siguiente:

                                            set hive.cli.print.header=true;
                                            set hive.auto.convert.join=true;

    Podemos establecer cualquier número de configuraciones; podemos añadir UDFs, podemos añadir archivos jar. Pero por el momento, 
    Estoy usando estas propiedades solamente. Ahora guárdalo. Ahora lanzaré una nueva sesión Hive. Saldré de esta sesión y lanzaré 
    una nueva sesión Hive. Ahora en esta sesión Hive, mi Archivo RC se ejecutará en el backend.

    ------------------------------------------------------------------------------------------------------------------------

    PRODUCTO CARTESIANO
    -------------------

    Para realizar un producto cartesiano entre dos tablas, por ejemplo, la tabla1 y tabla2, hacemos lo siguiente:

                                                    SELECT * FROM tabla1,tabl2;                                                 

    ------------------------------------------------------------------------------------------------------------------------