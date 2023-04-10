/*  MEMORY MANGAMENT & OPTIMIZATION OF JOINS
    ========================================

    Como dije que joinear un mayor número de tablas en una sola consulta nos puede costar con el rendimiento, y ya 
    sabes en tiempo real, donde los datos son realmente grandes. Así que uno tiene que hacer joins muy sabiamente. 
    Así que, en esta lección, voy a arrojar algo de luz sobre cómo Hive hace la gestión de memoria al hacer joins, 
    y finalmente cómo puedes optimizar tus consultas join. Hive sigue este enfoque en los joins. Por defecto, la 
    última tabla del join (última tabla de la query) es streamed y las otras son buffered en la memoria.

    Asi que si hablamos de la siguiente consulta, en este caso, la tabla de empleados y la tabla de departamentos se 
    almacenarán en memoria, mientras que la última tabla de la consulta, es decir, la tercera tabla, se transmitirá 
    (streamed) a través de los reducers:

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
                                                    (emp_tab.col6 = dept_tab.col1)

                                                JOIN
                                                    third_tab 
                                                ON 
                                                    (dept_tab.col1 = third_tab.col1)     


                                                          
    Y en la otra consulta, donde se utilizaron dos condiciones de unión diferentes:

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
    
    
    En ese escenario, habían 2 jobs. Así que en el primer job, la tabla de empleados se almacena en el buffer y el 
    departamento es streamed. En el segundo job, el resultado del primer job se almacena en el buffer y la tercera tabla 
    es streamed. Teniendo en cuenta esta regla que establece que "por defecto, la última tabla del join es streamed", es 
    aconsejable que de las dos tablas, la que sea grande, es decir, lo suficientemente grande en comparación con nuestra 
    memoria intermedia, sea la última en la consulta de join. De esta forma ahorraremos mucha memoria. 

    Pero en caso de que le resulte difícil poner una tabla grande en último lugar, o poner una tabla grande en último lugar 
    no sirve a su propósito, entonces en ese caso usted tiene que sobrescribir esta regla diciendo explícitamente Hive que 
    esta tabla debe ser Streamed. Para ello, especifique la palabra clave 'STREAMTABLE' en la consulta. Por ejemplo, si 
    desea que la tabla de empleados sea streamed:

                                                SELECT /*+ STREAMTABLE (emp_tab) */
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
                                                    (emp_tab.col6 = dept_tab.col1)

                                                JOIN
                                                    third_tab 
                                                ON 
                                                    (dept_tab.col1 = third_tab.col1)  


    Ahora, Hive considerará que la tabla de empleados es streamed y las demás se almacenarán en el buffer.