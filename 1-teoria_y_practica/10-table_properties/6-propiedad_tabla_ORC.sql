/*  PROPIEDAD ORC TABLE
    ===================

    Como sabemos, podemos crear una tabla con cualquier formato de archivo, como archivo de texto, que es de todos modos 
    el formato de archivo por defecto. Los otros son RC, formato de archivo ORC, formato de archivo AVRO y formato de 
    archivo PARQUET. Cada formato de archivo tiene sus propias propiedades de tabla. Aquí explicaré las propiedades de 
    tabla asociadas con el formato de archivo ORC. Para ello, en primer lugar, tenemos que crear una tabla con formato de 
    archivo ORC. Vamos a crearla:

                                CREATE TABLE IF NOT EXISTS orc_tab (
                                col1 string,
                                col2 int
                                ) 
                                ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
                                LINES TERMINATED BY'\n'
                                STORED AS ORC;
                                TBLPROPERTIES("orc.compress"="zlib")

    Ahora aquí, lo estoy almacenando como archivo ORC, y las propiedades de la tabla asociadas con el archivo ORC. En primer 
    lugar, el códec de compresión "orc.compress"="ZLIB". Este ZLIB es el códec de compresión que estoy especificando en esta 
    propiedad. En realidad, podemos tener 4 codecs de compresión es decir, SNAPPY, que se utiliza sobre todo para el formato 
    de archivo PARQUET, a continuación, los otros son BZIP2 y GZIP. Aquí, a través de esta propiedad, estoy especificando que 
    el códec de compresión para esta tabla ORC es ZLIB2, es decir, en la tabla "orc_tab", el códec de compresión se utilizará 
    como ZLIB.

    Ahora las otras propiedades que podemos establecer para ORC fileformat son:

    ● orc.compress.size = "value"
    ● orc.stripe.size = "value"
    ● orc.row.index.stride = "value"
    ● orc.create.index = "true or false"
    ● orc.bloom.filter.columns
    ● orc.bloom.filter.fpp

    La primera es "orc.compress.size", determina el número de bytes en cada chunk de compresión. La siguiente es "orc.stripe.size", 
    que especifica el número de bytes en cada franja. A continuación, "row.index.stride" determina el número de filas entre las 
    entradas del índice, y debe ser superior a 1000. El siguiente es "orc.create.index", su valor puede ser verdadero o falso, y 
    determina si se crean índices de filas o no. Los dos últimos son "bloom.filter.columns", que especifica una lista separada por 
    comas de nombres de columnas para las que debe crearse un filtro bloom. Y el último es la probabilidad para el bloom.filter. 
    Estos dos últimos rara vez se utilizan.