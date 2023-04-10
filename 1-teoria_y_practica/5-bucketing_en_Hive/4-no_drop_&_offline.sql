/*  NO DROP & OFFLINE
    =================

    En esta clase, me gustaría explicar dos alteraciones más que podemos hacer a nuestra tabla. Podría haberlo 
    explicado anteriormente en la clase sobre modificación de tablas (ALTER TABLE), pero hasta entonces no habíamos 
    tratado el concepto de tabla de particiones. Así que lo explico aquí. Básicamente esta clase es sobre dos 
    cláusulas en Hive que pueden proteger nuestra tabla. Estas son, no drop y offline. Primero hablemos de no drop. 
    Como el nombre sugiere, el comando no drop previene que una tabla o partición sea accidentalmente eliminada. En 
    nuestros proyectos, tenemos algunas tablas críticas que no deben ser eliminadas en ningún caso. Así que, como 
    medida de seguridad, podemos habilitar esta facilidad de no drop para nuestra tabla:


                                            ALTER TABLE emp_tab ENABLE no_drop;


    Ahora en caso de que cambies de opinión y no quieras esta característica, haz lo contrario. Desactivala.                                             


                                            ALTER TABLE emp_tab DISABLE no_drop;


    También podemos utilizar este comando para una particion:


                            ALTER TABLE part_dept PARTITION (deptname='HR') ENABLE no_drop;                                                


    ------------------------------------------------------------------------------------------------------------------------

    Ahora la segunda protección es "offline". Previene que nuestros datos sean consultados (queried). Digamos que tengo 
    una tabla "department_table", y no quiero que sea consultada. Para ello, escribo:


                                        ALTER TABLE dept_tab ENABLE offline;                                 


    Para desactivarlo:


                                        ALTER TABLE dept_tab DISABLE offline;                                              


    También podemos utilizar este comando para una particion:


                            ALTER TABLE part_dept1 PARTITION (deptname='Accounts') ENABLE offline;          

    ------------------------------------------------------------------------------------------------------------------------                                                                  