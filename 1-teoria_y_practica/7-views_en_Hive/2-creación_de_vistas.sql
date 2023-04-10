/*  CREACION DE VISTAS
    ==================

    Utilizaremos la siguiente tabla para crear nuestras vistas:

    
                                                SELECT * FROM emp_tab;
    
    Estos son algunos datos de empleados de 6 columnas, y estos datos van a ser cargados en otra tabla. 
    

    emp_tab.col1      emp_tab.col2     emp_tab.col3      emp_tab.col4      emp_tab.col5      emp_tab.col6      emp_tab.col7             
    1281        Shawn        Architect        7890        1481        10        IXZ
    1381        Jacob        Admin            4560        1481        20        POI
    1481        flink        Mgr              9580        1681        10        IXZ
    1581        Richard      Developer        1000        1681        40        LKJ
    1681        Mira         Mgr              5098        1481        10        IKZ
    1781        John         Developer        6500        1681        10        IXZ


    EJEMPLO 1
    ---------

    Nos refleja toda la información de la tabla "emp_tab":

                                CREATE VIEW emp_view1 AS SELECT * FROM emp_tab;

    ------------------------------------------------------------------------------------------------------------------------

    EJEMPLO 2
    ---------

                            CREATE VIEW emp_view2 AS SELECT col1,col2 FROM emp_tab;

    ------------------------------------------------------------------------------------------------------------------------

    EJEMPLO 3
    ---------

    Podemos tambien indicar un nombre para las columnas de nuestra vista:

                CREATE VIEW IF NOT EXISTS emp_view3 AS SELECT col1 AS id, col2 AS name FROM emp_tab;    

    ------------------------------------------------------------------------------------------------------------------------

    EJEMPLO 4
    ---------

    Podemos tambien realizar joins:

    CREATE VIEW emp_view4 AS SELECT emp_tab.col1, emp_tab.col2, dept_tab.col3 FROM emp_tab JOIN dept_tab ON (emp_tab.col6 = dept_tab.col1);                 

    ------------------------------------------------------------------------------------------------------------------------

    EJEMPLO 5
    ---------

    Podemos MODIFICAR nuestras vistas:

                                ALTER VIEW emp_view1 AS SELECT col1 FROM emp_tab;      

    ------------------------------------------------------------------------------------------------------------------------

    EJEMPLO 6
    ---------
    
    Podemos renombrar nuestra vista:

                                    ALTER VIEW emp_view1 RENAME TO emp_view_new;

    ------------------------------------------------------------------------------------------------------------------------

    EJEMPLO 7
    ---------

    Borramos una vista:

                                                    DROP VIEW emp_view2;

    ------------------------------------------------------------------------------------------------------------------------                                                                                        