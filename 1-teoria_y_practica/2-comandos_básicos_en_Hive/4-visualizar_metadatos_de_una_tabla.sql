/*  VISUALIZAR METADATOS DE UNA TABLA
    =================================

    Recordemos que habiamos creado la tabla 'tab':

                                        SELECT * FROM tab;                                


    tab.col1      tab.col2     tab.col3              
    1281        Shawn        Architect        
    1381        Jacob        Admin           
    1481        flink        Mgr            
    1581        Richard      Developer       
    1681        Mira         Mgr              
    1781        John         Developer   

    Para visualizar los nombres de campos, tipo de datos de los campos y comentarios hacemos lo siguiente:


                                            desc tab;


    col_name    data_type   comment
    col1        int
    col2        string
    col3        string


    Otra forma MÁS COMPLETA de visualizar la metadata de una tabla es utilizando la siguiente sentencia:


                                        desc formatted tab;    