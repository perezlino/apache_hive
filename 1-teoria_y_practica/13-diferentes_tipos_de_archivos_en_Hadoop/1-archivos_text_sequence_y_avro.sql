/*  ARCHIVOS TEXT, SEQUENCE Y AVRO
    ==============================

    Hasta ahora hemos visto los formatos de archivo básicos en Hadoop, como el formato de archivo de texto, el formato 
    de archivo de valor clave y el formato de archivo de secuencia. Pero hay otros formatos de archivo también disponibles 
    en Hadoop; como AVRO, PARQUET, formato RC (row columnar), formato de archivo ORC (optimized row columnar). Antes de 
    hablar de cada uno de ellos, se plantea la cuestión de por qué hay la necesidad de tantos formatos de archivo y ¿por 
    qué los formatos de archivos importan tanto? Para entenderlo, pensemos qué queremos exactamente de un archivo. 
    Ciertamente, lo que queremos es que nuestros archivos se lean rápidamente, que se escriban rápidamente, que se puedan 
    dividir para que no sea necesario leer todo el archivo a la vez, que varias tareas puedan leer las partes del archivo y 
    procesarlas en paralelo. De esta manera, estaremos aprovechando la idea central de Hadoop, de computación paralela 
    distribuida. A continuación, nuestro archivo debe soportar la evolución del esquema, es decir, permitirnos cambiar los 
    campos de un dataset. Podemos añadir y eliminar los campos de un archivo, y debe seguir siendo capaz de leer archivos 
    antiguos con el mismo código. Y también, nuestro archivo debe proporcionar soporte avanzado de compresión. Debido a que 
    Hadoop almacena grandes archivos dividiéndolos en bloques, es mejor si los bloques pueden ser comprimidos de forma 
    independiente. Hay varios códecs de compresión disponibles, como "snappy", "bzip2" y que permiten un almacenamiento y 
    procesamiento eficiente de los bloques. En resumen, nuestro archivo debe soportar esta compresión avanzada. De acuerdo, 
    entonces un formato de archivo ideal debería proporcionarnos todas estas características anteriores como una tarta en 
    nuestro plato. Pero la triste verdad es que ningún formato de archivo puede proporcionar todas las características a la 
    vez. Siempre tiene que haber una compensación entre las características anteriores. Por ejemplo, si queremos que la 
    velocidad de lectura sea rápida, tendremos que renunciar un poco a la velocidad de escritura. Si queremos que la compresión 
    sea mayor, entonces la divisibilidad puede ser un problema. Y cada uno de los diferentes formatos de archivo tiene su 
    propio conjunto de compensaciones. Algunos proporcionan lecturas más rápidas con un poco de compromiso en la escritura y 
    la evolución del esquema, y algunos nos proporcionan lo contrario con mejor escritura y compromisos en la lectura y tal 
    vez en la compresión. Dicho esto, vamos a entender ahora qué formato de archivo nos proporciona qué características, y así 
    podrás compararlos y seleccionar qué formato de archivo te conviene más para tu caso práctico. 

    ------------------------------------------------------------------------------------------------------------------------

    TEXTFILES
    ---------

    Empezaremos con archivos de texto, como los archivos separados por comas (CSV) y los archivos separados por tabulaciones (TSV). 
    Los archivos de texto simple, CSV y TSV, son comunes en el mundo no Hadoop, y también son muy comunes en el mundo Hadoop. 
    Desde el punto de vista del comportamiento, cada línea de un archivo de texto es un registro, y las líneas terminan con un 
    carácter de nueva línea, al modo típico de Unix. Los archivos de texto son útiles al volcar datos de una base de datos o de 
    HDFS. Así que estos archivos nos dan un rendimiento de escritura considerablemente mejor que otros, pero a costa del 
    rendimiento de lectura. De hecho, los archivos de texto son uno de los formatos de archivo más lentos de leer. Los archivos de 
    texto no soportan la compresión de bloques (block compression), por lo que comprimir un archivo de texto en Hadoop suele tener 
    un coste mayor en el rendimiento de lectura. Pero si quieres comprimirlos, tendrás que utilizar un códec de compresión a nivel 
    de archivo como bzip2. Los archivos de texto son intrínsecamente divisibles, sólo hay que dividirlos con el carácter de fin de 
    línea "\n". Y puesto que cada registro es un archivo de índice de datos, significa que no tiene metadatos adjuntos. Por lo que 
    respecta a la evolución del esquema, los archivos de texto tienen un soporte limitado para la evolución del esquema, es decir, 
    sólo se pueden añadir nuevos campos, mientras que los campos existentes nunca se pueden eliminar. 

    ------------------------------------------------------------------------------------------------------------------------

    SEQUENCE
    --------

    Después de los archivos de texto, vienen los archivos de secuencia. Los archivos de secuencia se almacenan como pares clave-valor 
    en un registro. Además, los registros se almacenan en formato binario, por lo que finalmente ocupan menos espacio. Los archivos 
    de secuencia tienen un buen rendimiento de escritura en comparación con los archivos de texto, también tiene un buen rendimiento 
    de lectura cuando se trata de leer filas completas de datos. Los archivos de secuencia soportan compresión a nivel de bloque, por 
    lo que se puede comprimir el contenido del archivo y ahorrar una buena cantidad de espacio. Además, no es necesario ningún código 
    o paso adicional si quieres trabajar con archivos de secuencia comprimidos. También son divisibles, por lo que puede dividir el 
    archivo en segmentos y asignarlos a varias tareas. Al igual que los archivos de texto, los archivos de secuencia tampoco almacenan 
    metadatos con los datos, por lo que la única opción de evolución del esquema es añadir nuevos campos. Pero si desea eliminar 
    algunos campos, tendrá que volver a crear manualmente otro archivo con los nuevos campos modificados. 

    ------------------------------------------------------------------------------------------------------------------------

    AVRO
    ----

    Ahora viene el formato de archivo avro. Avro en realidad no es un formato de archivo, es un formato de archivo más un framework 
    de serialización y de-serialización. Avro utiliza JSON para definir los tipos de datos, y serializa los datos en un formato 
    binario compacto. Hablando de su rendimiento de lectura-escritura, los archivos avro se sitúan en, se puede decir medio, en 
    términos de rendimiento de lectura y escritura, ni muy rápido ni muy lento. Así que si su aplicación se ocupa principalmente de 
    las operaciones de IO, entonces Avro archivo no es la mejor opción que va a tener. Avro admite la compresión a nivel de bloque y 
    también se puede dividir. Y lo que es más importante, los archivos avro están diseñados para soportar la evolución completa de 
    esquemas. LOS ARCHIVOS AVRO ALMACENAN METADATOS CON LOS DATOS, POR LO QUE ADMITEN LA EVOLUCIÓN COMPLETA DEL ESQUEMA. ESTE FORMATO 
    DE ARCHIVO ES REALMENTE LA MEJOR OPCIÓN SI SABE QUE EL ESQUEMA DE SU ARCHIVO VA A CAMBIAR CON FRECUENCIA.En un archivo avro, 
    podemos renombrar, añadir, eliminar y cambiar los tipos de datos de los campos, definiendo nuevos esquemas independientes, mientras 
    que los archivos antiguos pueden seguir leyéndose con el esquema actual.

    ------------------------------------------------------------------------------------------------------------------------