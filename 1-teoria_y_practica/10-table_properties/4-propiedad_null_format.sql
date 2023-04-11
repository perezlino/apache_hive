/*  PROPIEDAD NULL FORMAT
    =====================

    Nuestra siguiente propiedad es la propiedad "null format". Esta propiedad permite que el valor dado pasado a esta 
    propiedad, sea tratado como valor nulo. Voy a explicar esta propiedad directamente con un ejemplo. Para ello, en 
    primer lugar, vamos a ver el archivo. Tengo este archivo "prop.txt":
    
                                                    John,,200
                                                    Albert,HR,1900
                                                    Mark,,1000
                                                    Frank,TP,1150
                                                    Loopa,HR,1100
                                                    Lui,,1300
                                                    Lesa,TP,900
                                                    Pars,HR,800
                                                    leo,HR,700
                                                    lock,,650
                                                    Bhut,TP,800
                                                    Lio,TP,500    
    
    Como se puede ver, nuestro archivo contiene 3 columnas en cada fila, pero hay algunas filas en las que falta el valor 
    de la segunda columna. Al igual que en la primera fila, el valor de la segunda columna no se encuentra. En la tercera 
    fila también falta el valor de la segunda columna. 

    Ahora, si intentamos cargar este archivo en una tabla Hive de 3 columnas, Hive obviamente cargará este archivo con éxito. 
    Pero si intentamos capturar los datos que faltan utilizando la consulta: 
    
    
                                        SELECT * FROM tabla WHERE col2 IS NULL; 
    
    
    Esto nos devolvería 0 filas, porque por defecto "nada" es "null" entre los delimitadores. Repito, nada es nulo entre 
    delimitadores. Todo son datos para Hive entre delimitadores. Hive no leerá un valor perdido como valor nulo, será un 
    valor normal para Hive aunque esté vacío.

    Para ver esto creemos una tabla:

                                CREATE TABLE IF NOT EXISTS prop_tab1 (
                                col1 string,
                                col2 string,
                                col3 int
                                ) 
                                ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
                                LINES TERMINATED BY'\n'
                                STORED AS TEXTFILE;

                                LOAD DATA LOCAL INPATH '/home/alfonso/prop.txt' INTO TABLE prop_tab1; 


    Visualizemos la tabla:


                                        SELECT * FROM prop_tab1;

    prop_tab1.col1       prop_tab1.col2       prop_tab1.col3

    John                     200
    Albert        HR        1900
    Mark                    1000
    Frank         TP        1150
    Loopa         HR        1100
    Lui                     1300
    Lesa          TP         900
    Pars          HR         800
    leo           HR         700
    lock                     650
    Bhut          TP         800
    Lio           TP         500                                            


    Realicemos la consulta:


                                        SELECT * FROM prop_tab1 WHERE col2 IS NULL;   


    No obtendremos nada. 0 filas.


    Ahora, creemos una nueva tabla pero con la siguiente propiedad:                                          

                                CREATE TABLE IF NOT EXISTS prop_tab2 (
                                col1 string,
                                col2 string,
                                col3 int
                                ) 
                                ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
                                LINES TERMINATED BY'\n'
                                STORED AS TEXTFILE;
                                TBLPROPERTIES("serialization.null.format"="")

                                LOAD DATA LOCAL INPATH '/home/alfonso/prop.txt' INTO TABLE prop_tab2; 


    Visualizemos la tabla:


                                        SELECT * FROM prop_tab2;

    prop_tab1.col1       prop_tab1.col2       prop_tab1.col3

    John          NULL           200
    Albert        HR            1900
    Mark          NULL          1000
    Frank         TP            1150
    Loopa         HR            1100
    Lui           NULL          1300
    Lesa          TP             900
    Pars          HR             800
    leo           HR             700
    lock          NULL           650
    Bhut          TP             800
    Lio           TP             500                                            


    Realicemos la consulta:


                                        SELECT * FROM prop_tab2 WHERE col2 IS NULL;   

    John          NULL           200
    Mark          NULL          1000    
    Lui           NULL          1300
    lock          NULL           650    