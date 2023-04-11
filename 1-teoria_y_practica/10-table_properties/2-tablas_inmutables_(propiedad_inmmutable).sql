/*  TABLAS INMUTABLES
    =================

    Voy a explicar cómo hacer una tabla inmutable. Un objeto inmutable es aquel que una vez creado no puede ser cambiado. 
    Por ejemplo, si tienes experiencia en Java, sabrás que string es un objeto inmutable, ya que una vez creado su valor 
    no puede ser cambiado. Todas las operaciones como substring, deletion, resultarán en la creación de un nuevo string 
    mientras que el antiguo string permanecerá igual. Volviendo a Hive, Hive también proporciona inmunidad de tabla a 
    algunos comandos, como el comando INSERT INTO. El comando INSERT INTO se introdujo en la versión 0.8 y se utiliza 
    para añadir datos a una tabla o partición, manteniendo intactos los datos existentes. En palabras más simples, si 
    tenemos una tabla y hay algunos datos ya presentes en ella, y ahora si queremos insertar nuevos datos en esa tabla 
    manteniendo los datos antiguos como están, entonces usamos el comando INSERT INTO. En casos normales, cuando nuestra 
    tabla no es inmutable o cuando nuestra tabla es mutable, entonces el comando INSERT INTO se comportará así. Voy a 
    mostrar esto. 

    Antes de eso, por favor, no confundirse con las tablas mutables, estas no son nuevos tipos de tablas, porque, TODAS 
    LAS TABLAS SON, POR DEFECTO, MUTABLES. Así que puedo decir que tengo estas dos tablas normales:


                                                    SELECT * FROM table1;


                                                    John         1300
                                                    Albert       1200
                                                    Mark         1000
                                                    Frank        1150
                                                    Loopa        1100
                                                    Lui          1300
                                                    Lesa         900
                                                    Pars         800
                                                    leo          700
                                                    lock         650
                                                    pars         900
                                                    jack         700
                                                    fransis      1000         


    Esta es una tabla normal, o por defecto se puede decir, esta es una tabla mutable. Mi tabla 1 contiene estos valores.


                                                    SELECT * FROM table2;


                                                    John         1500
                                                    Albert       1900
                                                    Mark         1000
                                                    Frank        1150
                                                    Loopa        1100
                                                    Lui          1300
                                                    Lesa         900
                                                    Pars         800
                                                    leo          700
                                                    lock         650
                                                    Bhut         800
                                                    Lio          500 
                                                    

    Ahora voy a insertar en la tabla 1, todas las filas de la tabla 2. Para ello utilizaré el comando INSERT INTO, y ten 
    en cuenta que se trata de una tabla mutable.


                                    INSERT INTO TABLE table1 SELECT * from table2;


    Este comando se utiliza para insertar todos los valores, o todas las filas, de la tabla 2 a la tabla 1, manteniendo 
    intactos todos los datos de la tabla 1. Este comando INSERT INTO va a lanzar un job de MapReduce.


                                                SELECT * FROM tabla1;                                     

                                                    John         1500
                                                    Albert       1900
                                                    Mark         1000
                                                    Frank        1150
                                                    Loopa        1100
                                                    Lui          1300
                                                    Lesa         900
                                                    Pars         800
                                                    leo          700
                                                    lock         650
                                                    Bhut         800
                                                    Lio          500 
                                                    John         1300
                                                    Albert       1200
                                                    Mark         1000
                                                    Frank        1150
                                                    Loopa        1100
                                                    Lui          1300
                                                    Lesa         900
                                                    Pars         800
                                                    leo          700
                                                    lock         650
                                                    pars         900
                                                    jack         700
                                                    fransis      1000                                                       

    Como puedes ver, ahora las filas son 25. Inicialmente las filas eran casi 12 o 13, pero ahora después del comando 
    INSERT INTO, ha insertado los datos de la tabla 2 a la tabla 1, manteniendo intactas las filas de la tabla 1. Ahora 
    bien, este era el caso siempre que la tabla es mutable, lo que significa que permite que el comando INSERT INTO se 
    ejecute sobre ella, permite añadir los datos. Ahora crearé una TABLA INMUTABLE. Una tabla puede ser creada como 
    inmutable estableciendo su propiedad immutable a true. Por defecto esta propiedad es false, y esta propiedad fue 
    introducida en la versión 0.13 de Hive. Ahora voy a crear esto, voy a crear una nueva tabla.
    

                                CREATE TABLE IF NOT EXISTS inmutable_tab (
                                col1 string,
                                col2 int
                                ) 
                                ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
                                LINES TERMINATED BY'\n'
                                STORED AS TEXTFILE;
                                TBLPROPERTIES("inmmutable"="true");

                                LOAD DATA LOCAL INPATH '/home/alfonso/table1.txt' INTO TABLE inmutable_tab;   


    Visualizemos el resultado:

                                                SELECT * FROM inmutable_tab;


                                                    John         1300
                                                    Albert       1200
                                                    Mark         1000
                                                    Frank        1150
                                                    Loopa        1100
                                                    Lui          1300
                                                    Lesa         900
                                                    Pars         800
                                                    leo          700
                                                    lock         650
                                                    pars         900
                                                    jack         700
                                                    fransis      1000     


    Sí, nos ha permitido cargar los datos. Esto es porque esta propiedad nos permite cargar los datos por primera vez. 
    Después de la primera inserción de datos, los sucesivos comandos INSERT INTO fallarán, dando como resultado un único 
    conjunto de datos en la tabla. Ahora hemos cargado los datos por primera vez. Ahora, para los sucesivos comandos de 
    inserción, utilizaré:


                                INSERT INTO TABLE inmutable_tab SELECT * FROM table2;   


    FAILED: SemanticException [Error 10256]: Inserting into a non-empty immutable table is not allowed


    O bien debe estar vacía, como en el primer caso, cuando se crea la tabla, o cuando la primera vez que estamos cargando 
    los datos, podemos cargar los datos en ese momento. Después, todos los comandos INSERT INTO sucesivos fallarán. Ahora 
    que hemos visto el comportamiento del comando INSERT INTO en tablas inmutables, vamos a comprobar el comportamiento del 
    comando INSERT OVERWRITE en la misma tabla inmutable.

    Como ya he explicado en mis videos anteriores, "OVERWRITE" significa borrar el contenido de la tabla primero, y luego 
    insertar los nuevos datos. Así que vamos a hacer lo siguiente:


                            INSERT OVERWRITE TABLE inmutable_tab SELECT * FROM table2


    Esta consulta significa primero limpiar la tabla "inmutable_tab", si tiene contenido, limpiará todo el contenido de la 
    tabla "inmutable_tab", y luego insertará los datos de la tabla 2 en ella. Nótese que la tabla "inmutable_tab" es nuestra 
    tabla objeto inmutable. 

    Ahora el propio resultado habla de que el comando INSERT OVERWRITE no se ve afectado por la propiedad inmutable. 
    INSERT OVERWRITE funcionará tal cual. Te mostraré los datos también dentro de ella: 
    
    
                                            SELECT * FROM inmutable_tab;
    

                                                John         1500
                                                Albert       1900
                                                Mark         1000
                                                Frank        1150
                                                Loopa        1100
                                                Lui          1300
                                                Lesa         900
                                                Pars         800
                                                leo          700
                                                lock         650
                                                Bhut         800
                                                Lio          500     
    
    La tabla "inmutable_tab" está conteniendo los datos de la tabla 2, y todos sus datos anteriores son eliminados por este 
    comando de sobreescritura.                            
