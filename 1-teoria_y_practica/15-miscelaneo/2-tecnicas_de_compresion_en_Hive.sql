/*  TECNICAS DE COMPRESION EN HIVE
    ==============================

    En esta lección hablaremos de la compresión, sus ventajas y cómo realizarla en Hive. Para empezar, ¿qué es la compresión? 
    Es una terminología simple, que significa comprimir archivos para hacer un archivo grande en un archivo pequeño en 
    términos de tamaño. Ahora las ventajas de la compresión: 
    
    ● La primera ventaja es, obviamente, que el archivo comprimido ocupará menos espacio, y por lo tanto el consumo de memoria 
      será menor. 
    
    ● Y la segunda ventaja es, como sabemos, Hadoop es un clúster distribuido y los datos suelen fluir en grandes 
      cantidades a través de la red. Dado que nuestros datos se encuentran en diferentes nodos, por lo que durante la fase de 
      mapeo, particionamiento, combinación, ordenación y barajado (shuffling), los datos fluyen a través de esta red. Ahora bien, 
      si nuestros datos están comprimidos, se acelerará la transferencia de datos, ya que los datos a transferir son menos en 
      bytes. Y además, ahorraremos ancho de banda. Cuando se trata de grandes volúmenes de datos, ambos ahorros pueden ser 
      significativos. 

    Podemos comprimir los archivos en cualquier fase de todo nuestro job. 
    
    ● Así que en primer lugar, comprimir los archivos de entrada en HDFS. Si el archivo de entrada se comprime, entonces los bytes 
      leídos de HDFS se reduce, lo que significa menos tiempo para leer los datos. Y a su vez, vamos a disminuir el rendimiento 
      global de la ejecución de nuestro job. Ahora usted puede tener una pregunta, que si la entrada está comprimida, entonces 
      ¿cómo la función mapper leerá los archivos de datos? No tenemos que preocuparnos por esto, porque se descomprimirán 
      automáticamente cuando sean leídos por la función MapReduce. Supongamos que un archivo está comprimido con la extensión .gz. 
      En la función mapper, se identifica como archivo comprimido gzip, y por lo tanto será leído por el códec gzip.  

    ● Lo siguiente es comprimir el map output (la salida del map). Después de nuestra primera fase de la lectura de los archivos de 
      HDFS se ha completado, la función mapper se ejecutará sobre los datos y producirá su propia salida que va a alimentar al Reducer. 
      También podemos comprimir estos archivos intermedios producidos por el mapper. Dado que este map output será transferido a los 
      nodos reductores a través de la red, para ahorrar ancho de banda, podemos comprimir los archivos map output. Ahora bien, para que 
      Hive realice esta compresión automáticamente, tenemos que establecer algunas propiedades. Y las propiedades son: 
      
      En primer lugar, para comprimir los archivos map de salida, la propiedad es: 
      
                                                    set mapred.compress.map.output;
      
      mapred.compress.map.output=false

      Por defecto es falso, pero si quieres que tu map output sea comprimido, podemos ponerlo como "true". Y la siguiente cosa 
      importante es la codificación de la misma. Es: 
      
                                                    set mapred.map.output.compression.codec;
      
      set mapred.map.output.compression.codec=org.apache.hadoop.io.compress.DefaultCodec

      y aquí está el códec. Así que inicialmente, se utiliza el códec por defecto, pero podemos tener estos cuatro códecs en nuestra 
      compresión: 
      
      ● gzip
      ● bzip2
      ● lzo
      ● snappy

      Cada códec de compresión tiene su propia característica y comprime el archivo por su propio algoritmo relativo. Y la extensión 
      para gzip es ".gz", bzip es ".bz2", para lzo es ".lzo", y snappy es ".snappy". Y aquí está la lista de los códecs que se pueden 
      dividir y los que no. Así que aquí, si quiero usar snappy, puedo escribir snappy. Y si queremos almacenarlo como gzip, podemos 
      escribir gzip.

                                                set mapred.map.output.compression.codec = snappy;

                                                                      o

                                                set mapred.map.output.compression.codec = gzip;

    ● Ahora lo siguiente es comprimir los archivos de salida o salida del Reducer. Ahora que el reductor también ha realizado su 
      funcionalidad en el mapeador de archivos comprimidos, o se puede decir mapeador de salida (mapper output), y tiene su propia 
      salida presente, que se escribirá en el disco. A menudo necesitamos almacenar la salida como archivos de historia (history files). 
      Si la cantidad por día es extensa, entonces estos archivos de salida ocuparán un espacio enorme en HDFS. Para utilizar el espacio 
      adecuadamente, vamos a almacenar los archivos de salida en forma comprimida. Y para hacer esto y que Hive lo haga automáticamente, 
      tenemos que establecer esta propiedad a "true". La propiedad es: 
      
                                                        set mapred.output.compress = true;
      
      Y en que tipo se debe comprimir, se especificará mediante esta propiedad: 
      
                                                set mapred.output.compress.compression.codec; 
      
      mapred.output.compress.compression.codec=org.apache.hadoop.io.compress.DefaultCodec

      Es el mismo códec que se utiliza en la compresión de la salida del map. Por defecto, se utiliza el códec por defecto. Y aquí, 
      supongamos que estoy dando lzo, será comprimir los archivos en formato lzo:

                                                set mapred.output.compress.compression.codec=lzo;      