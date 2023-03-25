/*  ARQUITECTURA DE HIVE
    ====================

    Vamos a explicar la arquitectura de Hive. La arquitectura de Hive generalmente contiene estos cinco 
    componentes, de los cuales, un componente está conectado a Hadoop framework. Vamos a discutir estos 
    componentes de Hive uno por uno. El primero de todos es la UI o interfaz de usuario. A través de este 
    componente, los usuarios envían sus consultas al sistema. Este es el componente con el que los usuarios 
    interactúan directamente. El Hive shell, en el que escribimos los comandos y vemos los resultados, 
    puede considerarse una interfaz de usuario. La interfaz de usuario también puede ser de tres tipos, es 
    decir, podemos enviar una consulta a Hive de tres formas distintas. Una es utilizando la interfaz de 
    línea de comandos de Hive. La segunda es utilizando la interfaz web de Hive. Y la tercera es utilizando 
    el servidor Thrift. Servidor Thrift significa, mediante el uso de conexiones JDBC y ODBC de cualquier 
    aplicación con Hive. 

    El siguiente componente es el driver (controlador). Este componente recibe la consulta de la interfaz de 
    usuario. La tarea principal del driver incluye, en primer lugar, obtener las APIs necesarias para la 
    consulta que están modeladas en interfaces JDBC y ODBC. Y la segunda tarea principal es convertir la 
    consulta Hive en su programa MapReduce. Como he dicho antes, todas las consultas Hive se convierten 
    internamente en programas MapReduce, por lo que el driver convierte las consultas Hive en sus programas 
    MapReduce con un poco de ayuda del compilador. 

    Nuestro siguiente componente es el compilador. El compilador tiene un pequeño papel en la conversión de 
    las consultas Hive en programas MapReduce. Junto con eso, el compilador también hace el análisis semántico 
    del programa, y, finalmente, genera un plan de ejecución con la ayuda del metastore. Y el metastore es una 
    pequeña base de datos que almacena toda la información estructurada de nuestras tablas, particiones, número 
    de columnas en las tablas, tipos de datos de las columnas, serializadores, deserializadores, etc, toda la 
    información se almacena en este metastore. Por defecto, Hive utiliza el servidor SQL Derby integrado como 
    metastore, pero en los proyectos en tiempo real no utilizamos Derby porque proporciona almacenamiento de 
    proceso único. Es decir, mientras se utiliza Derby, no podemos ejecutar dos instancias simultáneas de Hive 
    CLI. En tiempo real, utilizamos MySQL o cualquier otra base de datos fuerte como nuestro metastore, que 
    permite múltiples instancias simultáneas de Hive CLI. 

    Por último viene nuestro motor de ejecución. Este es el componente que está conectado con el marco Hadoop. 
    El motor de ejecución ejecuta un plan que fue creado por el compilador. Interactuará con el NameNode y el 
    gestor de recursos para obtener los datos de salida deseados desde el HDFS, y finalmente devolverá los 
    resultados al usuario. Bien, después de aprender el funcionamiento de cada componente, veamos una fase de 
    la ejecución de una consulta. Supongamos que tengo esta consulta

                            "SELECT MAX (precio) AS (precio máximo) FROM tabla_1".

    Encajemos esta consulta en la arquitectura Hive. En primer lugar, el usuario realiza la consulta a través 
    de la interfaz de usuario. Luego viene nuestro driver. Obtendrá las APIs necesarias para la consulta, y luego 
    convertirá esta consulta en un programa MapReduce con la ayuda del compilador. Luego viene el componente 
    compilador. Hará un análisis semántico del programa, y finalmente creará un plan de ejecución para el programa. 
    Mientras crea el plan de ejecución, tiene que obtener ayuda del metastore, porque el metastore es el componente 
    que contiene la información estructural de la tabla_1. Metastore le dirá al compilador que la tabla_1 contiene 
    tantas columnas, y también que la columna "precio" tiene qué tipo de dato. Toda esta información será utilizada 
    por el compilador para crear el plan de ejecución. A continuación, este plan de ejecución se proporcionará al 
    motor de ejecución. El motor de ejecución interactuará con NameNode y el gestor de recursos de Hadoop para buscar 
    la tabla_1 en HDFS e indicarles que realicen la tarea del plan de ejecución, es decir, que obtengan el precio 
    máximo de la columna precio. Una vez que el trabajo es completado por Hadoop, vuelve con los resultados que 
    finalmente se muestran al usuario en la interfaz de usuario. Así que este fue el flujo de cómo una consulta Hive 
    fluye en su arquitectura. Chicos, esta fue la parte teórica básica de Hive. A partir de la próxima clase, vamos a                                        
    abrir nuestro Hive shell, y aprender todos los conceptos y comandos de Hive prácticamente en Hive shell.                          
                                                                                                                                                          HADOOP        
                                                 _____________________________________________                                         _________________________________________
                                                |    7. Compilador envia resultados           |                                       |                                         |
    _________                                   |                                             |               6a. Gestor de recursos  |                             MAPREDUCE   |
   |         | 1. Ejecuta una consulta    ______˅_____                                 _______|____________       ejecuta el Job      |      ____________________               |    
   |         | ------------------------> |            |  6. Compilador ejecuta plan   |                    | -----------------------------> |                    |              |    
   |    U    | 8. Recupera resultado     |   Driver   | ----------------------------> | Motor de ejecución |                          |     | Gestor de recursos |              |    
   |    I    | <------------------------ |____________|                               |____________________| <----------------------------- |____________________|              |
   |         |                              |      ˄                                          ˄             ˄  6b. Gestor de recursos |       /       |       \                 |
   |_________|                              |      |                                          |             |      completa el Job    |   ___/___  ___|___  ___\___             |
Hive CLI                2. Pregunta por el  |      | 5. Envia plan                            | 6c. Metadata ops                      |  |_______||_______||_______|            |
Web interface                   plan        |      |                                          |        DDLS |                         |         Task trackers                   |    
Thrift Server                               |      |                                          |             |                         |_________________________________________|
                                          __˅___________  3. Pregunta por la metadata   ______˅______       |                         |                                         |
                                         |              | ---------------------------> |             |      |                         |                             HDFS        |
                                         |  Compilador  | 4. Envia la metadata         |  Metastore  |      |                         |                                         |
                                         |______________| <--------------------------- |_____________|      |                         |      ____________________               |  
                                                                                                            '-----------------------------> |                    |              |
                                                                                                              6d. DFS ops             |     |     Namenode       |              | 
                                                                                                                                      |     |____________________|              |
                                                                                                                                      |       /       |       \                 |
                                                                                                                                      |   ___/___  ___|___  ___\___             |
                                                                                                                                      |  |_______||_______||_______|            |
                                                                                                                                      |           Data nodes                    |
                                                                                                                                      |_________________________________________|                      