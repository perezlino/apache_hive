/*  ARCHIVOS RC, ORC Y PARQUET
    ==========================

    Ahora nos queda el formato de archivo columnar. Estos formatos están ganando un buen impulso en el mercado, y se 
    están adoptando en una amplia gama de casos prácticos, debido a la estructura en la que almacenan los datos. En 
    formato de archivo columnar, en lugar de simplemente almacenar filas de datos adyacentes entre sí, también almacenamos 
    valores de columnas adyacentes entre sí, por lo que los conjuntos de datos se particionan tanto horizontal como 
    verticalmente. Hablaré aquí de 3 formatos de archivo columnares importantes, y empezando por el archivo RC. 

    ------------------------------------------------------------------------------------------------------------------------

    RC
    --

    Los archivos RC o archivos columnares de registro fueron el primer formato de archivo columnar adoptado en Hadoop. Se 
    trata de archivos planos formados por pares binarios clave-valor, y comparte muchas similitudes con los archivos de 
    secuencia. Los archivos RC son buenos y conocidos por sus lecturas más rápidas, pero escribir un archivo RC requiere más 
    memoria y computación que los formatos de archivo no columnares. Así que podemos resumir que el archivo RC ofrece un buen 
    rendimiento de lectura, pero con un poco de compromiso en el rendimiento de escritura. El archivo RC ofrece una compresión 
    significativa. Si los datos son adecuados, los archivos RC pueden incluso comprimirse con una alta relación de compresión. 
    Los archivos RC se pueden dividir, pero como ya he dicho, no hay ningún formato de archivo que ofrezca todas las 
    características, y en el caso de los archivos RC, se echa de menos el soporte para la evolución de esquemas. El serDe 
    actual para archivos RC en Hive y otras herramientas no soportan la evolución de esquemas. Para añadir una columna a 
    nuestros datos, debemos reescribir todos los archivos RC preexistentes. 

    ------------------------------------------------------------------------------------------------------------------------

    ORC
    ---

    El sucesor del archivo RC es el archivo ORC. Archivo ORC significa Optimized Row Columnar. Como su nombre indica, este 
    archivo es una versión optimizada del antiguo archivo RC. Por lo tanto, el archivo ORC tendrá un mejor rendimiento de lectura 
    y escritura, y una mejor compresión que los archivos RC. Los archivos ORC se pueden dividir a nivel de franja, pero no admiten 
    la evolución de esquemas.     

    ------------------------------------------------------------------------------------------------------------------------

    PARQUET
    -------

    Por último, está el formato de archivo parquet. Se trata del formato de archivo columnar más famoso adoptado por la comunidad 
    Hadoop. Parquet almacena estructuras de datos anidadas en un formato columnar plano. Al igual que RC y ORC, PARQUET también 
    está diseñado para lecturas más rápidas con menos preocupación por las velocidades de escritura. Los archivos parquet pueden 
    comprimirse con el famoso códec de compresión snappy. Son condicionalmente divisibles para algunos códecs de compresión. Sin 
    embargo, a diferencia de los archivos RC y ORC, los serDe parquet admiten una evolución limitada del esquema. En parquet, se 
    pueden añadir nuevas columnas al final de la estructura.

    ------------------------------------------------------------------------------------------------------------------------