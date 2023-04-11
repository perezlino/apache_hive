/*  DIFERENCIAS ENTRE hiveconf & hivevar
    ====================================

    En la lección anterior mencioné que hay una diferencia global versus local en las variables hivevar y hiveconf. En 
    realidad hivevar es global y hiveconf es local. Vamos a entenderlo directamente con un ejemplo. Supongamos tengo este 
    Hive script "set. hql", que está estableciendo una variable hivevar ID de empleado en su interior. Que está 
    estableciendo una variable "empid" = 1281 en su interior:

    set hivevar:empid=1281;

    Si ejecutas este script en hive shell usando el comando "source":

                                                source /home/alfonso/set.hql;

    Y ahora realizamos una consulta:

                                        SELECT * FROM emp_tab WHERE col1=${empid};

    Obtendremos el registro de acuerdo al valor que se indico en la variable.

    Hasta aquí todo correcto. Ahora en la misma sesión de hive, puedes establecer una misma variable "hiveconf" con diferente valor:

                                                        set empid=1481;                                        

    Mismo nombre de variable con diferente valor. ¿Qué opinas? ¿Es este un caso de ambigüedad, o el nuevo es decir, hiveconf anulará 
    el valor establecido anteriormente? En realidad ninguna, porque aquí una variable es global y otra local. Mientras que hivevar 
    seguirá apuntando al antiguo employee_ID y hiveconf se establecerá en el local employee_ID. Bien, primero ejecutaré el mismo 
    comando. Mira, la variable hivevar sigue apuntando al valor antiguo; 1281. Y la variable hiveconf, está apuntando a su valor 
    local; 1481.