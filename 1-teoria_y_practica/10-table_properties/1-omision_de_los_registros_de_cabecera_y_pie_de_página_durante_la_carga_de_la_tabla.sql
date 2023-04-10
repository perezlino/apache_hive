/*  OMISION DE LOS REGISTROS DE CABECERA Y PIE DE PAGINA DURANTE LA CARGA DE LA TABLA
    =================================================================================

    Las propiedades de tabla son las propiedades asociadas a una tabla determinada. Estas propiedades pueden ser 
    ACTIVAS o PASIVAS. Las propiedades de tabla pasivas no hacen nada, simplemente etiquetan una tabla, por ejemplo, 
    podemos dar el nombre del creador, la fecha de creación. Al crear la tabla, se utilizan simplemente para 
    etiquetarla. Pero las propiedades de tabla activas son aquellas que ayudan en el procesamiento de datos, o que 
    pueden ser responsables de seleccionar un dato específico de la tabla. Entenderás más de estas propiedades de 
    tabla en mis próximos ejemplos. Hay varias propiedades de tabla que podemos asociar a una tabla. Te mostraré las 
    más importantes y comúnmente utilizadas en el entorno de real-time. La primera de todas es "skip header count".

    Pongamos por caso que en algunos archivos, especialmente en los archivos de logs, hay algunas líneas que no son datos 
    reales sino que contienen información sobre los archivos o sobre los datos, y estas líneas están presentes en la parte 
    superior del archivo, o podemos decir que son las cabeceras del archivo. Por ejemplo, en un archivo de log, podemos 
    encontrar tres registros principales: información del sistema, información del volumen e información de la subversión. 
    Mientras cargamos los datos en las tablas Hive, no necesitamos que se carguen estas líneas. Así que o bien tenemos que 
    eliminar manualmente esos archivos yendo a ese archivo y eliminando manualmente los tres registros principales, lo cual 
    no es recomendable. O podemos usar las propiedades de la tabla Hive "skip.header.line.count", para saltarnos esas líneas 
    de cabecera. Así que voy a mostrar el archivo en primer lugar. Este es mi archivo:
    
                                                system=linux.14.0.1
                                                version=2.0
                                                sub-version=3.4
                                                John,1300
                                                Albert,1200
                                                Mark,1000
                                                Frank,1150
                                                Loopa,1100
                                                Lui,1300
                                                Lesa,900
                                                Pars,800
                                                leo,700
                                                lock,650
                                                pars,900
                                                jack,700
                                                fransis,1000
    
    Se supone que es un archivo de log. Como puedes ver, nuestros datos reales comienzan a partir de John, y estas 3 líneas 
    son las cabeceras del archivo, que incluyen alguna información del sistema, como sistema, versión y sub-versión. Al 
    cargar los datos, no queremos que estas 3 líneas se carguen en nuestra tabla Hive, porque no son datos reales. Así que, 
    para eliminar estas líneas durante la carga, utilizaremos una propiedad "skip.header.line.count" durante la creación de 
    la tabla. Crearemos una tabla con esta propiedad. Así que ahora empezaré a crear la tabla:

    
                                CREATE TABLE IF NOT EXISTS log1_tab (
                                col1 string,
                                col2 int
                                ) 
                                ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
                                LINES TERMINATED BY'\n'
                                STORED AS TEXTFILE
                                TBLPROPERTIES("skip.header.line.count"="3")

                                LOAD DATA LOCAL INPATH '/home/alfonso/log1.txt' INTO TABLE log1_tab;       


    Visualicemos el resultado:


                                                SELECT * FROM log1_tab;                                  


    John,1300
    Albert,1200
    Mark,1000
    Frank,1150
    Loopa,1100
    Lui,1300
    Lesa,900
    Pars,800
    leo,700
    lock,650
    pars,900
    jack,700
    fransis,1000                                                    


    Al igual que las líneas de cabecera, a veces también pueden estar presentes las líneas de pie de página. Como en lugar 
    de pasar la información en el encabezado, la información de registro, la información del archivo, puede estar presente
    en el pie de página también. Como en este archivo, tengo un archivo "log 2". Ahora, en lugar de poner la información 
    del archivo en la parte superior, han puesto la información del archivo en estas 3 líneas, es decir, en la zona de pie 
    de página. Así que de nuevo, no queremos que estas 3 líneas se carguen en nuestra tabla Hive, tenemos que omitirlo. Para 
    eso, usaremos otra propiedad. De nuevo, tenemos que crear una tabla. La llamaré "log2_tab". 

    Nuestro archivo "log2.txt":

                                                        John,1300
                                                        Albert,1200
                                                        Mark,1000
                                                        Frank,1150
                                                        Loopa,1100
                                                        Lui,1300
                                                        Lesa,900
                                                        Pars,800
                                                        leo,700
                                                        lock,650
                                                        pars,900
                                                        jack,700
                                                        fransis,1000
                                                        system=linux.14.0.1
                                                        version=2.0
                                                        sub-version=3.4

    Creamos la tabla:

                                CREATE TABLE IF NOT EXISTS log2_tab (
                                col1 string,
                                col2 int
                                ) 
                                ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
                                LINES TERMINATED BY'\n'
                                STORED AS TEXTFILE
                                TBLPROPERTIES("skip.footer.line.count"="3")

                                LOAD DATA LOCAL INPATH '/home/alfonso/log2.txt' INTO TABLE log1_tab;       


    Visualicemos el resultado:


                                                SELECT * FROM log2_tab;                                  


    John,1300
    Albert,1200
    Mark,1000
    Frank,1150
    Loopa,1100
    Lui,1300
    Lesa,900
    Pars,800
    leo,700
    lock,650
    pars,900
    jack,700
    fransis,1000          


    Como puedes ver, esta propiedad ha hecho que la carga se salte las últimas 3 líneas.                                                    