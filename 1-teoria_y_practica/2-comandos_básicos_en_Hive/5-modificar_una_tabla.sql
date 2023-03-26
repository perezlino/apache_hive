/*  MODIFICAR UNA TABLA
    ===================

    Recordemos que habiamos creado la tabla 'tab':

                                        SELECT * FROM tab;                                


    tab.col1      tab.col2     tab.col3              
    1281        Shawn        Architect        
    1381        Jacob        Admin           
    1481        flink        Mgr            
    1581        Richard      Developer       
    1681        Mira         Mgr              
    1781        John         Developer   

    ------------------------------------------------------------------------------------------------------------------------

    Agregar columnas a la tabla
    ---------------------------    

    Con la siguiente sentencia:

                                        ALTER TABLE tab ADD columns (
                                        col4 string,
                                        col5 int
                                        );

    Revisemos su metadata:

                                        desc tab;

    col_name    data_type   comment
    col1        int
    col2        string
    col3        string
    col4        string
    col5        int

    Revisemos sus datos:

                                            SELECT * FROM tab;                                


    tab.col1      tab.col2     tab.col3     tab.col4     tab.col5              
    1281        Shawn        Architect    NULL        NULL            
    1381        Jacob        Admin        NULL        NULL   
    1481        flink        Mgr          NULL        NULL   
    1581        Richard      Developer    NULL        NULL  
    1681        Mira         Mgr          NULL        NULL
    1781        John         Developer    NULL        NULL 

    ------------------------------------------------------------------------------------------------------------------------

    Reemplazar nombres de columnas
    ------------------------------

    Con la siguiente sentencia:

                                ALTER TABLE tab CHANGE col1 col1 int AFTER col3;
                                                            --------    
                                                                ⇑  
                                                                ǁ
                                              Puedo indicar un nuevo nombre para la col1
                                              o puedo colocar el mismo nombre. También 
                                              indico su tipo de dato.

    Revisemos su metadata:

                                        desc tab;

    col_name    data_type   comment
    col2        string
    col3        string
    col1        int
    col4        string
    col5        int     

    En resumen, reemplazamos el nombre de la columna col1 y su tipo de dato (int) por el de col3. Los valores de
    la col3 se quedan en su mismo lugar, solo estamos reemplazando el orden de nombres de las columnas y sus tipos.
    Al mover col1 en la posicion de col3, col2 y su tipo de datos (string) toma la antigua posición de col1 y col3
    y su tipo de dato (string) toma la antigua posición de col2.

    Revisemos sus datos:

                                            SELECT * FROM tab;                                


    tab.col2      tab.col3     tab.col1     tab.col4     tab.col5              
    1281        Shawn        NULL        NULL        NULL            
    1381        Jacob        NULL        NULL        NULL   
    1481        flink        NULL        NULL        NULL   
    1581        Richard      NULL        NULL        NULL  
    1681        Mira         NULL        NULL        NULL
    1781        John         NULL        NULL        NULL  


    Vemos col2 mantiene los valores que tenia col1 y string soporta int. col3 mantiene los valores de col2 y ambos
    son del tipo string por tanto no se genera problema. Para la col1, dado que es del tipo int, int no soporta string,
    por lo que devuelve NULL.

    ------------------------------------------------------------------------------------------------------------------------

    Cambiar el nombre de una columna
    --------------------------------

    Con la siguiente sentencia:

                                ALTER TABLE tab CHANGE COLUMN col2 new_col2 string; 
                                                                   ----------------   
                                                                           ⇑  
                                                                           ǁ
                                                        Indico un nuevo nombre para la col2 y
                                                        su tipo de dato.

    Revisemos su metadata:

                                        desc tab;

    col_name    data_type   comment
    new_col2    string
    col3        string
    col1        int
    col4        string
    col5        int  

    ------------------------------------------------------------------------------------------------------------------------

    Cambiar el nombre de una tabla
    ------------------------------

    Con la siguiente sentencia:

                                 ALTER TABLE tab RENAME TO tab1; 

    Revisemos sus datos:

                                            SELECT * FROM tab1;                                


    tab1.new_col2      tab1.col3     tab1.col1     tab1.col4     tab1.col5              
    1281        Shawn        NULL        NULL        NULL            
    1381        Jacob        NULL        NULL        NULL   
    1481        flink        NULL        NULL        NULL   
    1581        Richard      NULL        NULL        NULL  
    1681        Mira         NULL        NULL        NULL
    1781        John         NULL        NULL        NULL

    Puedes ver más nulos aquí, esto es porque hemos creado algunas columnas nuevas y reemplazado algunas columnas, los 
    tipos de datos de las que no habrían coincidido. Así que puedes tomar esto como una lección de que tienes que tener 
    mucho cuidado al cambiar el esquema de una tabla. 

    ------------------------------------------------------------------------------------------------------------------------

    Eliminar columnas y cambiar nombres de columnas
    -----------------------------------------------

    Ahora vamos a eliminar las columnas. Hive nos proporciona la cláusula "REPLACE COLUMNS". REPLACE COLUMNS borrará todos 
    los nombres anteriores y añadirá los nuevos nombres de columna. 

    Con la siguiente sentencia:

                                            ALTER TABLE tab1 REPLACE COLUMNS (
                                            id string,
                                            name string
                                            );     

    Revisemos sus datos:

                                            SELECT * FROM tab1;                                


    tab1.id      tab1.name               
    1281        Shawn            
    1381        Jacob         
    1481        flink          
    1581        Richard     
    1681        Mira         
    1781        John         

    ------------------------------------------------------------------------------------------------------------------------

    Modificar table properties
    --------------------------

    Las propiedades de una tabla podemos visualizarlas utilizando la siguiente sentencia:

                                        desc formatted tab;      

    De esta forma podemos modificar distintas propiedades de una tabla. En secciones posteriores se detallará un poco 
    más sobre estas propiedades:


    Ejemplo de modificaciones de table properties:


                                ALTER TABLE tab1 SET tblproperties('auto.purge'='true');

                                ALTER TABLE tab1 SET fileformat avro;

    ------------------------------------------------------------------------------------------------------------------------                                