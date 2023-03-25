/*  HIVE vs SQL
    ===========

    Como he mencionado la similitud de Hive con SQL, los estudiantes suelen confundirse pensando que Hive es SQL puro. 
    Pero ten en cuenta que Hive no es exactamente igual que SQL. Así que a continuación explico algunas diferencias 
    clave entre Hive y SQL. 

     _______________________________________________________________________________________________________________________
    |                                                         |                                                             |
    |                         HIVE                            |                          SQL                                |
    |                                                         |                                                             |
    |   ● Hive no es una base de datos ya que no contiene     |  ● SQL es una base de datos relacional pura con capacidad   |    
    |     datos físicos. Nuestros datos reales permanecen     |   propia. Almacena físicamente los datos en ella.           |
    |     almacenados en archivos HDFS solamente y no en      |                                                             |
    |     Hive. Hive es sólo una herramienta que se sienta    |                                                             |
    |     sobre HDFS para consultar los datos según la        |                                                             |
    |     demanda. Hive sólo apunta a esos datos con los      |                                                             |   
    |     metadatos que tiene.                                |                                                             |
    |                                                         |                                                             |
    |   ● Hive se basa en el concepto de escribir una vez y   |  ● En cambio, el SQL RDBMS se diseñó para escribir muchas   |
    |     leer muchas. Una vez cargados los datos en las      |    veces y leer muchas. Podemos escribir, actualizar y      |
    |     tablas de Hive, sólo se les pueden añadir y no se   |    borrar datos tantas veces como queramos.                 |    
    |     modifican.                                          |                                                             |
    |                                                         |                                                             |    
    |   ● En tercer lugar, Hive se creó para el procesamiento |  ● En cambio, SQL se creó para el procesamiento             |
    |     batch. Es más adecuado para sistemas OLAP donde     |    transaccional. Es más adecuado para sistemas OLTP. Se    |
    |     la latencia no es una gran preocupación.            |    utiliza en sistemas en los que la latencia preocupa más. |   
    |                                                         |                                                             |
    |   ● El sistema Hive es fácilmente escalable, y además   |  ● En cambio, SQL no es fácil de escalar y además es        |
    |     a un coste muy bajo.                                |    costoso.                                                 |
    |_________________________________________________________|_____________________________________________________________|
  */