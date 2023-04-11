/*  SUSTITUIR EL VALOR DE UNA VARIABLE
    ==================================

    Hay una disposición en variables, que podemos pasar el valor de la variable a través de otra variable. Supongamos 
    que tenemos una variable a la que se le da un valor, y ahora creamos una nueva variable. A esta variable, podemos 
    asignarle el valor de nuestra variable anterior. Pero para eso tenemos que establecer una propiedad en Hive.

    Esto se establece con: 
    
                                            hive.variable.substitute=true;

    Por defecto, este valor está fijado en false, pero si queremos usarlo, tenemos que poner esta propiedad a "true". 


                                                set table = emp_tab;

                                                set new_table = ${hiveconf:table};

                                                set new_table;

    new_table=emp_tab


    Nuestra nueva variable contiene el valor de la variable anterior. También podemos comprobarlo ejecutando: 
    

                                            SELECT * FROM ${hiveconf:new_table}; 
    
    
    Aquí estoy pasando la nueva variable es decir nueva_tabla.