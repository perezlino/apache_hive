/*  CARGAR DATOS DE UN JOIN ENTRE DOS TABLAS A UN ARCHIVO DE UN DIRECTORIO
    =======================================================================

    Usaremos esta tabla de empleados (se creó en las lecciones anteriores). 
    
                                                SELECT * FROM emp_tab;
    
    Estos son algunos datos de empleados de 6 columnas: 
    

    emp_tab.col1      emp_tab.col2     emp_tab.col3      emp_tab.col4      emp_tab.col5      emp_tab.col6      emp_tab.col7             
    1281        Shawn        Architect        7890        1481        10        IXZ
    1381        Jacob        Admin            4560        1481        20        POI
    1481        flink        Mgr              9580        1681        10        IXZ
    1581        Richard      Developer        1000        1681        40        LKJ
    1681        Mira         Mgr              5098        1481        10        IKZ
    1781        John         Developer        6500        1681        10        IXZ    

    Usamos la tabla de departamento:

                                                SELECT * FROM dept_tab;
    
    Estos son algunos datos de empleados de 6 columnas: 
    

    dept_tab.col1      dept_tab.col2     dept_tab.col3      dept_tab.col4
    10        INVENTORY        HYDERABAD        IXZ
    20        Jacob            ACCOUNTS         PUNE 
    30        DEVELOPMENT      CHENNAI          LKJ 

    Veamos como podemos utilizar OVERWRITE:


                INSERT OVERWRITE LOCAL DIRECTORY '/tmp/datos' 
                ROW FORMAT DELIMITED 
                FIELDS TERMINATED BY ','
                SELECT 
                emp_tab.col1, 
                emp_tab.col2, 
                emp_tab.col3, 
                dept_tab.col1, 
                dept_tab.col2, 
                dept_tab.col3 
                FROM 
                    emp_tab 
                JOIN 
                    dept_tab 
                ON 
                    (emp_tab.col6 = dept_tab.col1); 

    Dentro del directorio indicado, encontraremos un archivo de nombre similar a '000000_0' y este contendra un archivo
    de estructura similar a un archivo '.csv', dado que le indicamos que su delimitador sea ','.