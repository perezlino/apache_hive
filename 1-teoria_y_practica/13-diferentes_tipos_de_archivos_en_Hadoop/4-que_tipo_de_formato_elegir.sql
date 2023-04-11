/*  QUÉ TIPO DE FORMATO ELEGIR
    ==========================

    Ahora también has visto los resultados de las pruebas de rendimiento de lectura y escritura de estos tipos de archivos. 
    Así que aquí viene la pregunta del millón, ¿qué formato de archivo elegir y cuándo? Bueno, para responder sólo a esta 
    pregunta, he creado las 3 lecciones anteriores. Y la respuesta de una sola línea a esta pregunta es la siguiente, todo 
    depende de su caso de uso y el entorno. Sabemos que no existe ningún formato de archivo superhéroe que pueda proporcionarnos
    todo, todos vienen con su propio conjunto de compensaciones. Tenemos que comprometernos con algo para conseguir algo, y 
    ciertamente a todo el mundo le gustaría comprometerse en aquellos aspectos que son menos utilizados en su caso de estudio, 
    o que tienen un efecto mínimo en el rendimiento.

    Habiendo dicho esto, aquí están los puntos clave: 
    
    ● Si sabes de antemano que el esquema de tu archivo va a cambiar con frecuencia, entonces seguro, opta por el archivo AVRO 
      ya que soporta la evolución completa del esquema.  

    ● Si en tu caso de uso, la mayor parte del tiempo estás volcando datos desde HDFS o una base de datos, básicamente significa 
      que hay una gran cantidad de operaciones de escritura, entonces opta por el archivo de texto, es el mejor para las escrituras. 

    ● Por el contrario, si estás construyendo un lake en el que los datos van a ser leídos varias veces, entonces utiliza 
      cualquiera de los formatos de archivo columnar, a mí personalmente me gusta el formato PARQUET con compresión rápida. 

    ● Si estás almacenando datos intermedios entre MapReduce jobs, entonces los archivos de secuencia son los preferidos, ya que 
      están en formato binario por lo que se transfieren en la red con alta velocidad. 

    También los formatos de archivo que elegimos, dependen de la distribución de Hadoop que esté utilizando. Cloudera y Hortonworks
    soportan diferentes formatos. Como Cloudera apoya el uso de formato de archivo PARQUET, mientras que Hortonworks favorece ORC. 
    Así que voy a decir que no hay bueno o malo. Con todas estas opciones y consideraciones, no hay una única opción. Todo depende 
    del caso de uso, de lo que vayas a hacer con tus datos. Espero que ahora que conoces estas cosas, puedas elegir el formato de 
    archivo sabiamente.