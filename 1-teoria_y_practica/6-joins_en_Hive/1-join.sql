/*  INNER JOIN
    ==========

    Los Joins son muy comunes y se utilizan con cualquier entidad relacionada con datos. Los joins en Hive funcionan 
    igual que en SQL o en cualquier otra tecnología. Básicamente, unen tablas basándose en una condición de join sobre 
    columnas comunes. En esta sección, te mostraré cómo hacer un join de 2 tablas en Hive, cómo hacer un join de 3 tablas 
    en Hive, varios tipos de joins, y por último cómo podemos optimizar las uniones aprendiendo su gestión de memoria.

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


    Debemos crear la tabla de departamentos previamente: 
    
                                CREATE TABLE IF NOT EXISTS dept_tab (
                                col1 int,
                                col2 string,
                                col3 string,
                                col4 string,
                                ) 
                                ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
                                LINES TERMINATED BY'\n'
                                STORED AS TEXTFILE;

                                LOAD DATA LOCAL INPATH '/home/alfonso/dept.txt' INTO TABLE dept_tab;    
    
    Usamos la tabla de departamento:

                                                SELECT * FROM dept_tab;
    
    Estos son algunos datos de empleados de 6 columnas: 
    

    dept_tab.col1      dept_tab.col2     dept_tab.col3      dept_tab.col4
    10        INVENTORY        HYDERABAD        IXZ
    20        Jacob            ACCOUNTS         PUNE 
    30        DEVELOPMENT      CHENNAI          LKJ 

    
    ------------------------------------------------------------------------------------------------------------------------

    JOINEAR 2 TABLAS
    ----------------

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

    ------------------------------------------------------------------------------------------------------------------------

    JOINEAR 3 TABLAS
    ----------------

    SELECT 
           emp_tab.col1, 
           emp_tab.col2, 
           emp_tab.col3, 
           dept_tab.col2, 
           dept_tab.col3,
           third_tab.col2 
    FROM 
           emp_tab 
    JOIN 
           dept_tab 
    ON 
           (emp_tab.col7 = dept_tab.col4)

    JOIN
           third_tab 
    ON 
           (dept_tab.col1 = third_tab.col1)           

    ------------------------------------------------------------------------------------------------------------------------