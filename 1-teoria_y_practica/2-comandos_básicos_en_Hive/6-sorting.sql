/*  SORTING
    =======

    Vamos a ordenar nuestros datos en tablas Hive. Para ordenar, aprenderemos 4 cláusulas: 
    
    ● ORDER BY 
    ● SORT BY
    ● DISTRIBUTE  BY
    ● CLUSTER BY

    
    Comencemos con el comando ORDER BY. 

    ------------------------------------------------------------------------------------------------------------------------

    ORDER BY
    --------    

    El comando ORDER BY se utiliza para la ordenación completa de nuestros datos. Garantiza la ordenación total de 
    nuestros datos, y para ello tiene que pasar por un único reductor (single reducer). Repito, la cláusula ORDER BY 
    utiliza un único reductor para realizar la ordenación completa de los datos. Como en este ejemplo, donde hemos 
    realizado la ordenación en base a la columna 2 utilizando la cláusula ORDER BY. La cláusula ORDER BY ha utilizado 
    un reductor, al que se le han pasado todos los datos de la columna 2, y en la salida hemos obtenido una lista 
    ordenada completa. Veamos cómo lo hemos hecho, en la práctica. Empezaremos con el ejemplo. Antes de ordenar, 
    mostraré la tabla sobre la que voy a realizar la ordenación. Tengo dos columnas en la tabla, la columna 1 y esta 
    es la columna 2. La columna 2 contiene algunos números.

    Esto lanzará un MapReduce job. Dado que nuestro ordenamiento se realiza en los reductores, por lo que el reductor 
    tomará un poco más de tiempo. Aquí podemos ver un solo archivo y nos ha asegurado un ordenamiento completo de los 
    datos. Primero vendrá, 1, luego 2, 3, 4, 5 y 6.     


    SELECT * FROM tabla;                                               SELECT columna2 FROM tabla ORDER BY columna2; 

    aa      1                                                                    1
    bb      1                                                                    1    
    dd      5                                                                    1     
    ef      2                                                                    1    
    teh     1                                                                    1
    dth     4                                                                    1
    dfh     5                                                                    1
    h       3                                                                    1
    sr      1                                                                    1
    ef      1                                                                    2
    dth     1                       ________                    ___________      2
    dth     1                      |        |                  |           |     2
    dth     12     =============>  | MAPPER |  =============>  |  REDUCER  |     2                     
    rht     2                      |________|                  |___________|     2
    vhk     2                                                                    2             
    gj      2                                                                    2
    ub      2                                                                    3
    l       4                                                                    4
    bj      4                                                                    4
    bjk     4                                                                    4
    hyj     4                                                                    4
    s       6                                                                    4
    fh      6                                                                    5
    g       5                                                                    5
    j       5                                                                    5    
    h       5                                                                    5   
    kf      5                                                                    5
    yj      1                                                                    5
    cv      1                                                                    6    
    vyj     2                                                                    6    
    jfy     2                                                                    12    



    Pero hay algunas limitaciones de la cláusula ORDER BY. En modo estricto, la cláusula ORDER BY tiene que ir seguida 
    de la cláusula LIMIT. La cláusula LIMIT es 'obligatoria' porque, como estamos pasando los datos a "un" reductor, y 
    ya sabes que en producción tenemos datasets muy grandes, un solo reductor puede tardar mucho en terminar, así que 
    usaremos una cláusula LIMIT aquí. Es lanzado nuevamente un MapReduce job. Esta cláusula LIMIT la usamos cuando 
    tenemos un dataset en GBs. Tenemos un gran número de filas, por lo que para restringir la salida, utilizamos la 
    cláusula LIMIT.

     SELECT columna2 FROM tabla ORDER BY columna2 LIMIT 5;

    1
    1
    1
    1
    1

    ------------------------------------------------------------------------------------------------------------------------

    SORT BY
    -------

    El segundo comando es SORT BY. SORT BY también hace ordenación pero dentro de un reductor. Entendámoslo así. En primer 
    lugar, estamos de acuerdo en que es posible que MapReduce puede utilizar más de un reductor, como es obvio, en un 
    entorno en tiempo real donde nuestro dataset es grande. Así que más de un reductor será utilizado en un job. Ahora 
    SORT BY hará la ordenación dentro de un reductor y no entre los reductores. Por eso la cláusula SORT BY no garantiza 
    la ordenación completa de los datos. Así que si vemos en este ejemplo, la ordenación se realiza en base a la columna 2, 
    y hay dos reductores utilizados que obtendrán esta lista de valores del mapeador. 

    Por tanto, SORT BY ha realizará la ordenación dentro de un reductor, y no se realiza la ordenación completa global de 
    los datos. Así que nuestra salida final se compone de dos salidas de dos reductores. Veamos cómo funciona. Utilizaremos 
    la ordenación en la misma tabla. De nuevo lanzará un MapReduce job. 

    SELECT * FROM tabla;                                               SELECT columna2 FROM tabla SORT BY columna2; 

    aa      1                                                                    1  ---------
    bb      1                                                                    1    
    dd      5                                                                    1           |     
    ef      2                                                                    1    
    teh     1                                                      ___________   1           |       
    dth     4                           .---------------------->  |           |  1
    dfh     5                           |                         |  REDUCER  |  1           |   
    h       3                           |                         |___________|  2  
    sr      1                           |                                        1           |   
    ef      1                           |                                        2
    dth     1                       ____|___                                     2           |   
    dth     1                      |        |                                    3          
    dth     12     =============>  | MAPPER |                                    1           |   
    rht     2                      |________|                                    4                           
    vhk     2                           |                                        5           |  
    gj      2                           |                                        1
    ub      2                           |                                        5           |
    l       4                           |                                        6
    bj      4                           |                          ___________   12 ---------
    bjk     4                           '---------------------->  |           |  1  ---------
    hyj     4                                                     |  REDUCER  |  1           |   
    s       6                                                     |___________|  2              
    fh      6                                                                    2           |   
    g       5                                                                    2  
    j       5                                                                    4           |      
    h       5                                                                    4          
    kf      5                                                                    4           |   
    yj      1                                                                    5          
    cv      1                                                                    5           |   
    vyj     2                                                                    5              
    jfy     2                                                                    6  ---------   

    ------------------------------------------------------------------------------------------------------------------------

    DISTRIBUTE  BY
    -------------

    Ahora el siguiente comando es DISTRIBUTE  BY. Hive utiliza la cláusula DISTRIBUTE  BY para distribuir los pares 
    key-value entre los reductores. Podemos decir que la cláusula DISTRIBUTE  BY decide qué keys irán a qué reductor. 
    Garantiza que todas las filas con el mismo valor DISTRIBUTE  BY irán al mismo reductor. Será más claro en este 
    ejemplo. Así que si estoy usando DISTRIBUTE  BY en la columna 2 de la misma tabla, entonces DISTRIBUTE  BY asegura 
    que todos los valores de 1, 3, y 5, irán a este reductor, y todos los valores de 2, 6, 4, y 12, irán a este reductor. 
    Generalizando, podemos decir que DISTRIBUTE  BY asegura que cada uno de los n reductores obtenga un rango de valores 
    conocidos que se solapen.


    SELECT * FROM tabla;                                               SELECT columna2 FROM tabla DISTRIBUTE  BY columna2; 

    aa      1                                                                    1  ---------
    bb      1                                                                    1    
    dd      5                                                                    1           |     
    ef      2                                                                    3    
    teh     1                                                      ___________   5           |       
    dth     4                           .---------------------->  |           |  1
    dfh     5                           |                         |  REDUCER  |  5           |   
    h       3                           |                         |___________|  5  
    sr      1                           |                                        5           |   
    ef      1                           |                                        1
    dth     1                       ____|___                                     1           |   
    dth     1                      |        |                                    5          
    dth     12     =============>  | MAPPER |                                    1           |    
    rht     2                      |________|                                    1                     
    vhk     2                           |                                        1           |   
    gj      2                           |                                        5  ---------
    ub      2                           |                                        
    l       4                           |                                        
    bj      4                           |                          ___________   
    bjk     4                           '---------------------->  |           |  4  ---------
    hyj     4                                                     |  REDUCER  |  6           |   
    s       6                                                     |___________|  2              
    fh      6                                                                    4           |   
    g       5                                                                    4  
    j       5                                                                    2           |      
    h       5                                                                    2          
    kf      5                                                                    2           |   
    yj      1                                                                    6          
    cv      1                                                                    4           |   
    vyj     2                                                                    2              
    jfy     2                                                                    4           |   
                                                                                 12         
                                                                                 2           |   
                                                                                 2  ---------  


    Pero tenga en cuenta que DISTRIBUTE BY no hace ningún tipo de ordenación, simplemente distribuye los valores de las 
    columnas entre los reductores. Para realizar la ordenación, tenemos que combinar la cláusula DISTRIBUTE BY con la 
    cláusula SORT BY. En este escenario, DISTRIBUTE BY está asegurando que los valores conocidos se superpongan en ambos 
    reductores, y luego SORT BY está haciendo el ordenamiento dentro del reductor para obtener esta salida. Aquí también, 
    si usted puede notar, la ordenación global no se realiza. La ordenación total sólo se realiza mediante la cláusula 
    order by. 


                            SELECT columna2 FROM tabla DISTRIBUTE BY columna2 SORT BY columna2;  


    ------------------------------------------------------------------------------------------------------------------------

    CLUSTER BY
    ----------

    Por último, tenemos el comando CLUSTER BY. El comando CLUSTER BY no es más que una forma abreviada del comando 
    DISTRIBUTE BY SORT BY. En lugar de escribir "DISTRIBUTE BY SORT BY", puede utilizar "CLUSTER BY". Lógicamente, 
    nada diferente. Así que vamos a ejecutar este CLUSTER BY directamente. Podemos pensar en esto como un atajo para eso. 
    También podemos utilizar DISTRIBUTE BY y SORT BY en paralelo. Ahora se ha asegurado de que todos los valores 2 van a 
    un reductor, todos los valores 4 van a un reductor, y dentro de los reductores que nuestros valores están ordenados. 
    Así que chicos, esta fue la experiencia de ordenamiento en Hive.


    SELECT * FROM tabla;                                               SELECT columna2 FROM tabla CLUSTER BY columna2; 

    aa      1                                                                    1  ---------
    bb      1                                                                    1    
    dd      5                                                                    1           |     
    ef      2                                                                    1    
    teh     1                                                      ___________   1           |       
    dth     4                           .---------------------->  |           |  1
    dfh     5                           |                         |  REDUCER  |  1           |   
    h       3                           |                         |___________|  1  
    sr      1                           |                                        1           |   
    ef      1                           |                                        3
    dth     1                       ____|___                                     5           |   
    dth     1                      |        |                                    5          
    dth     12     =============>  | MAPPER |                                    5           |    
    rht     2                      |________|                                    5                     
    vhk     2                           |                                        5           |   
    gj      2                           |                                        5  ---------
    ub      2                           |                                        
    l       4                           |                                        
    bj      4                           |                          ___________   
    bjk     4                           '---------------------->  |           |  2  ---------
    hyj     4                                                     |  REDUCER  |  2           |   
    s       6                                                     |___________|  2              
    fh      6                                                                    2           |   
    g       5                                                                    2  
    j       5                                                                    2           |      
    h       5                                                                    2          
    kf      5                                                                    4           |   
    yj      1                                                                    4          
    cv      1                                                                    4           |   
    vyj     2                                                                    4              
    jfy     2                                                                    4           |   
                                                                                 6         
                                                                                 6           |   
                                                                                 12  ---------      

    ------------------------------------------------------------------------------------------------------------------------