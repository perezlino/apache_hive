/* Introduccion a HIVE
   ===================

    Lo que es HIVE
    --------------

    Primero hablaremos de lo que es Hive. Hive es una herramienta de consulta tipo SQL para consultar los datos 
    almacenados en ubicaciones HDFS. Usted debe saber que Hadoop almacena los datos en forma de archivos HDFS. 
    Ahora, para realizar operaciones de negocio y para procesar los datos HDFS, Apache nos ha dado una herramienta 
    de consulta SQL como es Hive. La llamo herramienta de consulta tipo SQL porque las consultas en Hive tienen 
    casi la misma estructura que las de SQL. Al igual que SQL se utiliza para consultar los datos presentes en 
    RDBMS, Hive se utiliza para consultar los datos en HDFS. Hive fue desarrollado inicialmente por Facebook, pero 
    más tarde fue tomado por Apache. Hablando de qué tipo de datos puede procesar Hive, Hive sólo puede procesar 
    datos estructurados, es decir, los datos que se pueden organizar en tablas, como los que tenemos en RDBMS; filas 
    y columnas propiamente dichas. Hive es eficiente para el procesamiento en batch, es decir, en función de la 
    cantidad de datos que deben procesarse y no del tiempo que se tarda en obtener los resultados. Ahora, este es el 
    punto más importante que debes saber como aprendiz de Hive, que Hive es sólo una lente entre MapReduce y HDFS. 
    Porque las consultas de Hive se convierten internamente en programas MapReduce por su compilador, y luego los 
    programas resultantes de MR realmente procesarán los datos. Así que primero la consulta Hive se convierte en 
    programas MapReduce, y luego ese programa se aplicará sobre los datos. Sin embargo, no hay que preocuparse por 
    esta conversión, ya que se realiza internamente por el propio Hive. Por último, pero no menos importante, Hive 
    soporta varios formatos de almacenamiento de Hadoop, como Parquet, Sequence, ORC, Avro, archivo de texto, etc. 
    Vamos a aprender acerca de estos formatos, junto con algunos otros, en detalle, más adelante en el curso.


    Lo que no es HIVE
    -----------------

    Pasemos ahora a lo que no es Hive. Esto también es importante saberlo. Los estudiantes generalmente se confunden 
    entendiendo Hive como una base de datos al ver las consultas SQL, pero Hive no es una base de datos. Repito, Hive 
    no es una base de datos. Hive sólo apunta a los datos que están presentes en HDFS. Hive almacena la información 
    estructurada, o podemos decir metadatos de archivos HDFS, en forma de tablas, y luego ve el archivo HDFS de una 
    manera tabular. Lo tendrás más claro en la próxima clase sobre cómo funciona Hive con HDFS. Además, Hive no es una 
    herramienta para OLTP, ya que no soporta inserciones, actualizaciones o borrados a nivel de fila. Aunque, en las 
    últimas versiones de Hive, empezaron a soportar, insert, update y delete, con propiedades ACID completas, pero no 
    son tan eficientes. Además, algunas operaciones sólo son compatibles con determinados formatos de archivo. Por 
    ejemplo, el comando de update sólo es compatible con el formato de archivo ORC. Dado que Hive se utiliza para el 
    procesamiento batch, no es adecuado para situaciones en las que se requiere una respuesta rápida, como ocurre con 
    los RDBMS. Además, Hive tarda un tiempo extra en convertir primero la consulta en un programa MapReduce, y luego 
    procesar los datos a través de ese programa. Esta conversión es obviamente una sobrecarga para Hive. Así que yo 
    diría que Hive no es bueno para respuestas más rápidas y sólo se refiere a la cantidad de datos que se procesan. 
    Y por último, esto también lo he explicado antes, que Hive sólo soporta datos estructurados y no soporta datos no 
    estructurados, como audios, vídeos e imágenes. 
*/