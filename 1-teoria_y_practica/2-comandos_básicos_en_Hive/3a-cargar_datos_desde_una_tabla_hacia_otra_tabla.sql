/*  CARGAR DATOS DESDE UNA TABLA HACIA OTRA TABLA
    =============================================

    En las clases anteriores, aprendimos a crear tablas de diferentes maneras y vimos cómo cargar esas tablas 
    desde un archivo. Ahora, en esta lección, aprenderemos a cargar los datos desde una tabla hacia otra tabla. 
    Antes cargamos un archivo plano en una tabla. Ahora veremos cómo cargar una tabla desde otra tabla.

    Para cargar los datos de una tabla, utilizaremos el comando INSERT. Pero en primer lugar, voy a mostrar la 
    tabla fuente. Usaré esta tabla de empleados. 
    
                                                SELECT * FROM emp_tab;
    
    Estos son algunos datos de empleados de 6 columnas, y estos datos van a ser cargados en otra tabla. 
    

    emp_tab.col1      emp_tab.col2     emp_tab.col3      emp_tab.col4      emp_tab.col5      emp_tab.col6      emp_tab.col7             
    1281        Shawn        Architect        7890        1481        10        IXZ
    1381        Jacob        Admin            4560        1481        20        POI
    1481        flink        Mgr              9580        1681        10        IXZ
    1581        Richard      Developer        1000        1681        40        LKJ
    1681        Mira         Mgr              5098        1481        10        IKZ
    1781        John         Developer        6500        1681        10        IXZ
    

    Y si, te habrás dado cuenta que en los datos, puedes ver los nombres de las columnas esta vez. En realidad, es fácil. 
    Sólo tienes que configurar esta propiedad en Hive: 
    
                                            set hive.cli.print.header=true;


    Si esta propiedad es falsa, los nombres de las columnas no vendrán junto con los datos, pero ahora es verdadera, así que 
    los nombres están ahí.

    Ahora los datos de esta tabla se van a cargar en una nueva tabla. Vamos a crear una nueva tabla. "CREATE TABLE tab". Ten 
    en cuenta que puedes crear esta tabla con cualquier número de columnas, no es obligatorio que el esquema de la tabla de 
    origen y el esquema de la tabla de destino sean iguales. Puede crear la tabla de destino con cualquier número de columnas, 
    pero sí, tiene que tener en cuenta ambos esquemas al cargar los datos. Si intentas insertar una columna de tipo string 
    del origen en una columna de tipo integer del destino, esa columna se llenará de nulos. Así que hay que tener en cuenta 
    los esquemas de las tablas. Estoy creando esta nueva tabla con sólo 3 columnas. 


                                                    CREATE TABLE tab (
                                                    col1 int,
                                                    col2 string,
                                                    col3 string
                                                    )
                                                    STORED AS TEXFILE;


    Al cargar datos desde un archivo se hacia necesario indicar distintas cláusulas al momento de crear una tabla, dado que 
    Hive no era consciente de cómo las columnas se separan en un archivo, ni cómo las líneas se terminan en ese archivo, por 
    lo que tenemos que decirle explícitamente a Hive que mis columnas están separadas por comas y las líneas se terminan por 
    el carácter de fin de línea. Pero en este caso, estamos cargando datos de una tabla Hive en sí, que ya está estructurada. 
    Hive tiene pleno conocimiento de los metadatos de esta tabla, por lo que no es necesario escribir esas dos o tres 
    cláusulas. Basta con escribir "STORED AS TEXTFILE", pero en cualquier momento, puedes añadir una LOCATION para esta 
    tabla. Ahora mismo, no estoy proporcionando eso.

    Ahora la tabla está creada. Realicemos la carga. Para cargar una tabla desde otra tabla, usamos el comando insert. 
    "INSERT INTO TABLE tab". Como he creado esta tabla de 3 columnas, podemos seleccionar 3 columnas cualesquiera de la tabla 
    de origen, pero con tipos de datos coincidentes, de lo contrario podemos obtener nulos. Seleccionaremos las 3 primeras 
    columnas.


                                INSERT INTO TABLE tab SELECT col1, col2, col3 FROM emp_tab;


    Vamos a ver si los datos se han cargado correctamente en la tabla:


                                                SELECT * FROM tab;                                

    tab.col1      tab.col2     tab.col3              
    1281        Shawn        Architect        
    1381        Jacob        Admin           
    1481        flink        Mgr            
    1581        Richard      Developer       
    1681        Mira         Mgr              
    1781        John         Developer   


    Así que los datos se han cargado correctamente. No es necesario que cargues todos los datos en la nueva tabla. 

    ------------------------------------------------------------------------------------------------------------------------

    INTO vs OVERWRITE
    =================

    Recordar que en lugar de utilizar INTO, también podemos utilizar la cláusula OVERWRITE. INTO se utiliza para anexar 
    (append) datos a la tabla. Esto significa que si la tabla previamente tiene algunos datos en ella, a continuación, 
    INTO anexa los datos a los datos anteriores. Pero sobrescribir significa, si la tabla ya tiene datos, entonces primero 
    borra los datos de la tabla1, y luego cargar nuevos datos en ella.

    Veamos como podemos utilizar OVERWRITE:


                INSERT OVERWRITE TABLE tab SELECT col1, col2, col3 FROM emp_tab WHERE col3 = 'Developer';    


    Vamos a ver si los datos se han cargado correctamente en la tabla:


                                                SELECT * FROM tab;                                

    tab.col1      tab.col2     tab.col3                        
    1581        Richard      Developer                  
    1781        John         Developer   

    ------------------------------------------------------------------------------------------------------------------------

    Múltiples inserciones desde una tabla hacia varias tablas
    ---------------------------------------------------------

    También es posible que desde esta tabla de origen, tengamos que cargar datos en múltiples tablas. Por ejemplo, tenemos 
    2 tablas de destino, y queremos que los datos de los "Developers" vayan a una tabla y los datos de los "Managers" vayan 
    a otra tabla. Este es un caso muy simple, pero es posible que tenga que cargar en muchas tablas para cada valor de la 
    columna 3. Entonces, ¿cómo vamos a hacerlo? ¿Escribirás consultas de inserción separadas para cada tabla de destino? 
    Bueno, sí, puedes escribir consultas separadas, pero Hive también nos da una opción para hacer múltiples inserciones en 
    un solo comando. Veamos cómo. Primero crearé dos tablas de destino, una para el "Developer" y otra para el "Manager".


                                                CREATE TABLE developer_tab (
                                                id int,
                                                name string,
                                                desg string
                                                ) 
                                                STORED AS TEXTFILE;

                                                CREATE TABLE manager_tab (
                                                id int,
                                                name string,
                                                desg string
                                                ) 
                                                STORED AS TEXTFILE;
                     

    Realizamos la inserción:


    FROM emp_tab INSERT INTO TABLE developer_tab SELECT col1,col2,col3 WHERE col3 ='Developer' INSERT INTO TABLE manager_tab SELECT col1,col2,col3 WHERE col3='Mgr';


    Los datos se han cargado en ambas tablas.

    ------------------------------------------------------------------------------------------------------------------------