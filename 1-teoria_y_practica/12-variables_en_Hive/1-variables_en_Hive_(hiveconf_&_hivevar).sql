/*  VARIABLES EN HIVE (hiveconf y hivevar)
    ======================================

    Bienvenidos a esta sección donde hablaremos de las variables en hive. Estas variables no son nada nuevo, pero se comportan 
    de la misma manera que podrías haber aprendido antes en cualquier lenguaje de programación. Las variables son valores que 
    se pueden cambiar, no son fijos. Podemos pasar el valor a una variable durante la ejecución del programa. ¿Por qué usamos 
    variables en Hive? ¿Por qué no simplemente fijar los valores? Te lo explico con un ejemplo. Supongamos que tenemos un valor 
    que denota el precio de cualquier producto, digamos "price = 100". Ahora, en proyectos en tiempo real, sin duda este valor 
    es fijo. Ahora, en proyectos en tiempo real, sin duda este valor de precio se utilizaría en muchos lugares en la secuencia 
    de comandos Hive, y también se puede utilizar dentro de múltiples secuencias de comandos Hive. ¿Verdad? Ahora, en caso de 
    que queramos cambiar el valor del precio a 110, ¿cambiarías el valor del precio en cada lugar de los scripts Hive? No, 
    ¿verdad? Lo que haremos es crear una variable de precio y asignarle un valor en un solo lugar. Esta asignación de valor 
    puede ser dentro del script o mientras escribes la consulta en otros lugares. Después de hacer esto, sólo tienes que cambiar 
    el valor en un solo lugar, y el mismo valor se reflejará en todos los lugares. Dicho esto, empecemos a practicar con las 
    variables hive. Hive proporciona dos tipos de variables: 
    
    ● hiveconf
    ● hivevar

    ------------------------------------------------------------------------------------------------------------------------

    HIVECONF
    --------

    Veamos primero cómo declarar una variable en una sesión hive. Luego gradualmente en la sección, aprenderemos como funcionan 
    las variables en scripts hive, en Bash shell, en consultas hive, estas cosas. Así que dentro de una sesión hive, puedes en 
    cualquier momento establecer la variable utilizando el comando set: 
    
                                                            set deptno = 40 
    
    Así que aquí estoy estableciendo una variable deptno que es igual a 40, y se establece. Si quieres comprobar su valor, si 
    se establece o no, escribe:
    
                                                                set deptno;

    deptno=40
    
    Verás que el número de departamento es igual a 40. Hay otra forma de crear la variable "hiveconf": 
    
                                                            set hiveconf:d1=20; 
    
    Ahora establece d1: 
                                                                    set d1; 
    
    d1=20

    Se establece en 20. Puedes establecer "hiveconf" de estas dos maneras, ambas son lo mismo. ¿Ahora cómo puedes usar esto? Puedes 
    usarlo de varias maneras. Empecemos con lo básico. Creamos la siguiente consulta:

                                        SELECT * FROM emp_tab WHERE col6=${hiveconf:deptno};

    Ya habiamos establecido que deptno es igual a 40.                                        

    ------------------------------------------------------------------------------------------------------------------------

    HIVEVAR
    -------

    Hay otro tipo de variable en hive, que es "hivevar". Funciona igual, pero tiene algunas diferencias con "hiveconf". La diferencia 
    exacta se explicara en la proxima clase con un ejemplo, pero es una sola diferencia, puedo decirte que "hivevar" fija el valor 
    globalmente mientras que "hiveconf" fija el valor localmente. Y puedes establecer una variable "hivevar" como esta: 
    
                                                        set hivevar:deptnumber=10; 
    
    Así que la variable número de departamento de tipo hivevar se estableció en 10. 

             _______________________________________________________________________________________________________________
            |                                                                                                               |    
            |   Por defecto, si estás configurando variables sin hivevar o hiveconf, la variable hiveconf se configurará.   | 
            |_______________________________________________________________________________________________________________|
            

    Ahora el beneficio de "hivevar" es que, puedes usar esta variable con o sin el prefijo "hivevar":

                                        SELECT * FROM emp_tab WHERE col6=${deptnumber};    

    Si lo deseas, puedes incluir el prefijo "hivevar", no es un problema:

                                        SELECT * FROM emp_tab WHERE col6=${hivevar:deptnumber};  

    Podemos utilizar cualquier número de variables en una consulta. Además, puedes utilizar ambos tipos de variables en una misma 
    consulta. Así que voy a mostrar esto también. Vamos a crear una variable hivevar más: 
    
                                                    set hivevar:name=col2;

    Ahora:

                            SELECT col1, ${name}, col3 FROM empt_tab WHERE col6 = ${hiveconf:deptno};

    Aquí hay una cosa importante a mencionar que, estas variables se establecen para esta sesión Hive solamente. Repito, el valor de 
    estas variables, tanto para hiveconf como para hivevar, se limitan únicamente al ámbito de esta sesión. No podemos utilizar estas 
    variables en ninguna otra sesión Hive.                                                                               

    Salimos de una sesión de Hive escribiendo "quit;"