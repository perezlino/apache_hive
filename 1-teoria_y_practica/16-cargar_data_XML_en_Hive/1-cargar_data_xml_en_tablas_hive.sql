/*  CARGAR DATA XML EN TABLAS HIVE
    ==============================

    En esta lección, estoy cubriendo un tema muy importante, que es cómo cargar datos o archivos XML en nuestras tablas Hive. 
    Hasta ahora sólo hemos cargado datos estructurados en nuestras tablas Hive. Los datos estructurados son muy fáciles de 
    cargar ya que contienen delimitadores adecuados. Pero como XML es un formato semi-estructurado, contiene varias etiquetas 
    y dentro de esas etiquetas, se menciona el valor real. Por lo tanto, esos son los valores que tenemos que insertar en la 
    tabla Hive, y el resto de etiquetas deben omitirse. Ahora el punto principal es cómo cargar estos archivos XML 
    semiestructurados en Hive. La respuesta a esto es, utilizando SerDes adecuado para XML. Como sabes, Hive nos proporciona 
    varios SerDes, o podemos decir serializaciones/deserializaciones para leer diferentes tipos de datos, e incluso nos permite 
    escribir nuestros propios SerDes si tenemos nuestros propios datos formateados. Pero para archivos XML, no tenemos que crear 
    nuestro propio SerDe porque el SerDe para esto ya está disponible en internet. Lo único que tenemos que hacer es descargar 
    este SerDe de internet y añadirlo a nuestro entorno Hive. Así que vamos a empezar las cosas prácticamente. Antes de eso, voy 
    a mostrar la estructura del archivo XML, que voy a cargar en mi tabla Hive. Tengo este archivo XML "books.xml".
    
                                                <CATALOG>
                                                <BOOK>
                                                <TITLE>Hadoop Definitive Guide</TITLE>
                                                <AUTHOR>Tom White</AUTHOR>
                                                <COUNTRY>US</COUNTRY>
                                                <COMPANY>CLOUDERA</COMPANY>
                                                <PRICE>24.90</PRICE>
                                                <YEAR>2012</YEAR>
                                                </BOOK>
                                                <BOOK>
                                                <TITLE>Programming Pig</TITLE>
                                                <AUTHOR>Alan Gates</AUTHOR>
                                                <COUNTRY>USA</COUNTRY>
                                                <COMPANY>Horton Works</COMPANY>
                                                <PRICE>30.90</PRICE>
                                                <YEAR>2013</YEAR>
                                                </BOOK>
                                                </CATALOG>     

    Como se puede ver, hay un montón de etiquetas en este archivo XML, y los valores correspondientes para estas etiquetas reside 
    en ellos. En realidad, la estructura de XML: es como que sólo, para cada etiqueta individual, hay un valor asociado con él. En 
    este XML, tengo los detalles de los libros en el mismo. Desde aquí hasta aquí, contiene los detalles de un libro. Este libro, 
    esta es la etiqueta de inicio y esta es la etiqueta final. Y esta etiqueta de inicio es para otro libro. Desde la etiqueta de 
    inicio hasta la etiqueta final, todas las etiquetas dentro de estas dos etiquetas contienen los detalles del primer libro. Y 
    esta es de nuevo la etiqueta de inicio. Desde aquí hasta aquí, contiene los detalles del segundo libro. Como puede ver, dentro 
    de esta etiqueta de inicio y fin, tenemos otras etiquetas, como título, autor y país. Cada etiqueta de inicio va seguida de una 
    etiqueta de fin, y dentro de estas dos etiquetas de inicio y fin, reside nuestro valor real. Es decir, el título de este libro 
    es "Hadoop Definitive Guide", el autor de este libro es "Tom White". Y de nuevo en el segundo libro, el título es "Programming 
    Pig", y el autor es "Alan Gates". Tenemos que cargar estos valores en nuestra tabla Hive, y tenemos que omitir estas etiquetas. 
    Podemos pensar en este archivo XML como, libro será nuestra tabla, y el título, autor, país, estos actuarán como columnas en 
    nuestra tabla Hive, y estas columnas tendrán diferentes filas que contienen diferentes valores para diferentes libros.

    Ahora que ya conoces la estructura de XML y cómo funcionan estas etiquetas y valores, tenemos que extraer estos valores de sus 
    etiquetas correspondientes, y cargarlos en las tablas Hive. Y esto lo haremos utilizando un SerDe específico, y el nombre del 
    SerDe es:

                                                com.ibm.spss.hive.serde2.xml.XmlSerDe

    Este es el nombre del SerDe que tenemos que descargar. Y dentro de estos SerDes, tenemos este formato de entrada:
    
                                                com.ibm.spss.hive.serde2.xml.XmlInputFormat  
    
    y formato de salida especificado:

                                                org.apache.hadoop.hive.ql.io.IgnoreKeyTextOutputFormat

    Así que en primer lugar, voy a descargar este SerDe de Internet y añadirlo a mi entorno Hive. Voy a descargar un archivo jar.
    Lo podemos buscar de la siguiente manera:

                                                com.ibm.spss.hive.serde2.xml.XmlSerDe jar file

    Como ya lo he descargado, iré directamente a mi carpeta de descargas. Copiaré la ruta y aquí usaré el comando ADD JAR y el 
    nombre del archivo jar. Ves, dice "esta ruta ha sido añadida a la ruta de la clase". Ahora podemos usar estos SerDes en nuestra 
    sentencia CREATE TABLE:

                                            ADD JAR /home/alfonso/Downloads/nombre_del_archivo.jar;   

    Pasando a mi actual sentencia CREATE TABLE para la carga de datos XML. La creación de la tabla es igual que la creación de una 
    tabla normal, pero con algunas modificaciones. Como tenemos un SerDe para datos XML, lo usaremos en nuestra sentencia CREATE para 
    especificar el formato de las filas. Ahora crearé una tabla:
    

                CREATE TABLE book_details (TITLE STRING, AUTHOR STRING,COUNTRY STRING,COMPANY STRING,PRICE FLOAT,YEAR INT)
                ROW FORMAT SERDE 'com.ibm.spss.hive.serde2.xml.XmlSerDe'
                WITH SERDEPROPERTIES (
                "column.xpath.TITLE"="/BOOK/TITLE/text()",
                "column.xpath.AUTHOR"="/BOOK/AUTHOR/text()",
                "column.xpath.COUNTRY"="/BOOK/COUNTRY/text()",
                "column.xpath.COMPANY"="/BOOK/COMPANY/text()",
                "column.xpath.PRICE"="/BOOK/PRICE/text()",
                "column.xpath.YEAR"="/BOOK/YEAR/text()")
                STORED AS INPUTFORMAT 'com.ibm.spss.hive.serde2.xml.XmlInputFormat'
                OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.IgnoreKeyTextOutputFormat'
                TBLPROPERTIES ("xmlinput.start"="<BOOK","xmlinput.end"= "</BOOK"); 

                LOAD DATA LOCAL INPATH '/home/alfonso/files/books.xaml' INTO TABLE book_details;    


    Lo que estamos diciendo en esta linea "column.xpath.TITLE"="/BOOK/TITLE/text()" es que tome la etiqueta /TITLE que se encuentra
    dentro de la etiqueta /BOOK y extraiga el texto "text()" y luego lo coloque en la columna TITLE ("colum.xpath.TITLE").