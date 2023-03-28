/*  STATIC PARTITION
    ================

    En Hive, podemos hacer particiones de dos maneras: PARTICIONES ESTÁTICAS y PARTICIONES DINÁMICAS. La idea 
    central de ambos es la misma, particionar los datos en varios directorios, pero la forma de hacerlo es 
    diferente. Así que veamos primero la partición estática. 

    Pero primero, creamos la tabla y cargamos los datos del archivo "dept.txt":

    CREATE TABLE IF NOT EXISTS dept (
    col1 int,
    col2 string,
    col3 string,
    col4 int
    ) 
    ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
    LINES TERMINATED BY'\N'
    STORED AS TEXTFILE;

    LOAD DATA LOCAL INPATH '/home/alfonso/files' OVERWRITE INTO TABLE dept;

    ------------------------------------------------------------------------------------------------------------------------

    PARTICIÓN ESTÁTICA
    ------------------

    En la partición estática, tenemos que cargar esos datos en sus respectivas particiones MANUALMENTE. Debemos
    saber qué datos vienen y en qué partición tenemos que ponerlos. Veámoslo con un ejemplo. Supongamos que esta 
    es mi tabla fuente, no particionada; tabla "dept" (dept.txt). Contiene cuatro columnas. La primera es el número 
    de departamento, la segunda el nombre del departamento, la tercera el nombre del empleado y la tercera el salario.

    SELECT * FROM dept;

                                dept.col1       dept.col2       dept.col3       dept.col4

                                10              Accounts        Edouard         2384
                                40              HR              Teddy           3747
                                10              Accounts        Paloma          3833
                                40              HR              Ana             3603
                                20              Sales           Claudette       2084
                                40              HR              Naoko           2698
                                10              Accounts        Bill            2582
                                10              Accounts        Miwa            2002
                                10              Accounts        Claudette       3836
                                10              Accounts        Gordon          3906
                                ...             ...             ...             ...   
                                ...             ...             ...             ...      

    Ahora tenemos que cargar estos datos en una tabla de partición que se particiona en el nombre del departamento. 
    ¿Entendido? Ahora creamos la tabla de partición. Creamos la tabla de partición así:


    CREATE TABLE IF NOT EXISTS part_dept (
    deptno int,
    empname string,
    sal int
    ) 
    PARTITIONED BY (deptname string)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
    LINES TERMINATED BY'\n'
    STORED AS TEXTFILE;


    Tenga en cuenta que en el caso de la partición estática, en cualquier columna que se está haciendo la partición, esa 
    columna no debe ser incluida en la declaración 'CREATE'. Como estoy haciendo la partición en la columna 
    "nombre_departamento" (dept.col2), esa columna no debe estar presente en la creación de columnas. Porque obviamente, 
    estamos cargando los datos de esa columna en su propia partición con nombre, por lo que escribirlo en la creación de 
    columnas es una cosa innecesaria. 

    Ahora inserte los datos en la partición utilizando particionamiento estático:


    INSERT INTO TABLE part_dept PARTITION (deptname = 'HR') SELECT col1, col3, col4 FROM dept WHERE col2 = 'HR'; 


    Estoy creando una partición llamada "HR". Básicamente, estoy creando un directorio con nombre "HR". Y dentro de la 
    partición "HR", ¿qué datos se deben cargar? Se menciona en la consulta SELECT "columna_1, columna_3, columna_4 FROM 
    departamento WHERE columna_2="HR"". Así que has visto que estoy seleccionando individualmente sólo los datos de "HR" 
    de la tabla departamento y luego cargar en la partición "HR". 

    Mis datos están cargados. Ahora para comprobar si se ha cargado correctamente o no, vamos a la interfaz de usuario, 
    navegamos por el sistema de archivos, y podemos ver que se ha creado una partición llamada "HR" en la ruta 
    "user/hive/warehouse/part_dept/deptname=HR". Si entramos en ella, veremos todos los registros del departamento de "HR".

    Una cosa más, también puede cargar directamente particiones estáticas utilizando el comando LOAD. Pero en ese caso, 
    nuestros datos deben ser segregados previamente en la columna de partición. Así que si ya tengo archivos separados 
    para cada uno de los departamentos; accounts, HR, finance, y sales, entonces puedo cargar cada archivo por separado 
    en su partición correspondiente mediante el comando LOAD. Así que tengo este archivo separado para el departamento de 
    HR, que contiene los datos de HR. Entonces usando el comando LOAD, podemos insertarlo en la partición respectiva de la
    tabla.  


    LOAD DATA LOCAL INPATH '/home/alfonso/files' INTO TABLE part_dept PARTITION (deptname ='HR');


    ------------------------------------------------------------------------------------------------------------------------