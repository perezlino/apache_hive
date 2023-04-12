/*  MODES EN HIVE
    =============

    En este video, contiene una explicación sobre los diferentes modos de Hive, y cómo cambiar entre estos modos. 
    En Hive, tenemos tres modos disponibles según el entorno Cloudera, y esos son: 
    
    ● El modo embebido 
    ● El modo local 
    ● El modo remoto
    
    A continuación explicaré cada uno de estos modos y dónde utilizarlos. 

    ------------------------------------------------------------------------------------------------------------------------

    MODO EMBEBIDO
    -------------

                                                        METASTORE EMBEBIDO
                                 ____________________________________________________________
                                |                                                            |   
                                |                      Servicio Hive JVM                     |           
                                |   ____________         ____________         ____________   |   
                                |  |            |       |            |       |            |  |  
                                |  |   Driver   | ----> |  Metastore | ----> |  Derby DB  |  |  
                                |  |____________|       |____________|       |____________|  |
                                |                                                            |   
                                |____________________________________________________________|

    El primero es el modo embebido. Es el modo por defecto para CDH. En este modo, el metastore se almacena utilizando una base 
    de datos Derby. Y tanto la base de datos, esta base de datos Derby y el servicio metastore, este servicio, se ejecuta embebido 
    en el servidor Hive principal. Este es mi servidor Hive principal y se ejecuta en una única JVM. Como se puede ver en el 
    diagrama, hay un único proceso JVM para metastore y la base de datos Derby. Este modo requiere menos esfuerzos para configurar, 
    y Cloudera recomienda este modo sólo para fines experimentales. La limitación de este nodo es que, permite una única sesión 
    Hive a la vez. No podemos ejecutar dos o más sesiones Hive simultáneamente. 

    ------------------------------------------------------------------------------------------------------------------------

    MODO LOCAL
    ----------
                                            METASTORE LOCAL
                                 _______________________________________
                                |                                       |   
                                |           Servicio Hive JVM           |           
                                |   ____________         ____________   |   
                                |  |            |       |            |  | --------. 
                                |  |   Driver   | ----> |  Metastore |  |         |  
                                |  |____________|       |____________|  |         |  
                                |                                       |         |          ________
                                |_______________________________________|         |         |        |   
                                 _______________________________________          |-------> |   DB   |  
                                |                                       |         |         |________|
                                |           Servicio Hive JVM           |         |   
                                |   ____________         ____________   |         |   
                                |  |            |       |            |  |         |   
                                |  |   Driver   | ----> |  Metastore |  | --------'  
                                |  |____________|       |____________|  |
                                |                                       |   
                                |_______________________________________|

    Ahora pasamos al siguiente modo, el modo local. En este modo, el servicio metastore, este es el servicio metastore, y la base 
    de datos, esta es la base de datos Derby, ambos se ejecutan por separado en diferentes JVMs. Este servicio metastore se ejecuta 
    en la JVM del servicio Hive, y esta base de datos Derby, se ejecutará en alguna otra JVM. Incluso pueden ejecutarse en hosts 
    separados. El servicio metastore se comunica con la base de datos metastore usando JDBC. Ahora que tenemos JVMs separadas para 
    el servicio metastore y la base de datos metastore, este nodo nos permite ejecutar diferentes sesiones Hive en paralelo. Y 
    pasando a su uso. Debemos utilizar el modo local cuando Hadoop se instala en modo pseudo, teniendo un nodo de datos. Como sabéis, 
    Hadoop se puede instalar de tres formas diferentes; standalone, pseudo y distributed. Así que cuando Hadoop se instala en modo 
    pseudo, teniendo los nodos de datos y los nodos de nombres en una sola máquina, entonces podemos utilizar este modo local. O 
    cuando el tamaño de los datos es más pequeño y se limita a una sola máquina local, entonces también debemos utilizar este modo, 
    porque el procesamiento será muy rápido en conjuntos de datos más pequeños presentes en la máquina local.
                               
    ------------------------------------------------------------------------------------------------------------------------

    MODO REMOTO
    -----------

                                     _____________              _______________
                                    |             |            |               | 
                                    | Beeline CLI |----------->| Hive Server 2 |     
                                    |_____________|            |_______________| 
                                     _____________                     |                     
                                    |             |                    | 
                                    |  Hive CLI   |----.        _______˅_______         ________
                                    |_____________|    |       |               |       |        | 
                                     _____________     |------>|   Metastore   |------>|   DB   | 
                                    |             |    |       |_______________|       |________| 
                                    |   BeesWax   |----'               ˄
                                    |_____________|                    | 
                                           ˄                   ________|__________ 
                                           |                  |                   |
                                     ______|______     _______|_________     _____|______   
                                    |             |   |                 |   |            |   
                                    |     Hue     |   | Cloudera Impala |   |  HCatalog  |
                                    |_____________|   |_________________|   |____________|       
                                                                                  ˄
                                                                                  |      
                                                                                  |
                                                                             ___________
                                                                            |           |
                                                                            |    Pig    |
                                                                            |___________|     

    El último es el modo remoto. Este modo se utiliza en entornos de producción en tiempo real. En este modo, el servicio Hive 
    metastore se ejecuta en su propio proceso JVM. No se ejecuta en el proceso JVM del servidor Hive. El metastore y la base de 
    datos Derby se ejecutan en sus propios procesos JVM. Al igual que en modo local, el servicio metastore se comunica con la 
    base de datos metastore a través de JDBC. La principal ventaja del modo remoto sobre el modo local es que, el modo remoto no 
    requiere que el administrador comparta la información de acceso JDBC para la base de datos metastore con cada usuario Hive. Y 
    debemos utilizar el modo remoto cuando Hadoop se instala con el modo distribuido, que tiene múltiples nodos de datos, y los 
    datos se distribuyen a través de diferentes nodos. En segundo lugar, siempre que el conjunto de datos es grande, este modo 
    debe ser utilizado, ya que permite el procesamiento paralelo de datos. 

    ------------------------------------------------------------------------------------------------------------------------

    Podemos cambiar en cualquier momento el modo de ejecución estableciendo una simple propiedad en hive. Y esa propiedad es: 
    
                                                        set mapred.job.tracker; 
    
    mapred.job.tracker=localhost:9001

    Como estoy utilizando un modo local, esta propiedad se establece en host local. Si lo desea, puede cambiarlo a embedded o remote.

    ------------------------------------------------------------------------------------------------------------------------                                                                                