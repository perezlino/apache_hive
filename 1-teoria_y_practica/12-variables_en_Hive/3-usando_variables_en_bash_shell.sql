/*  USANDO VARIABLES EN BASH SHELL
    ==============================

    Bien, ya has visto los usos básicos de las variables, pero en real-time no usaremos variables como esas. En la 
    mayoría de los casos, vamos a utilizar estas variables en un script, así que voy a cubrir esas cosas ahora. En 
    la primera lección de esta sección, he explicado cómo ejecutar consultas y scripts hive en el Bash shell, así 
    que voy a aprovechar el aprendizaje de esa clase. Así que escribimos:


                hive --hiveconf deptno=20 -e 'select * from emp_tab where col6 =${hiveconf:deptno};


    Obtendremos los registros donde la col6 = 20 en la tabla "emp_tab".

    Otra linea de comandos:


                    hive --hivevar deptno=10 -e 'select * from emp_tab where col6 =${deptno};


    Obtendremos los registros donde la col6 = 10 en la tabla "emp_tab".

    Además, puedes declarar cualquier número de variables mientras ejecutas consultas hive. Es una mezcla de variables 
    hiveconf y hivevar, el valor al que pasaré mientras ejecuto el script: 


    hive --hivevar deptno=10 --hiveconf tablename=emp_tab -e 'select * from ${hiveconf:tablename} where col6 =${deptno};


    Podemos también ejecutar archivos scripts directamente y no solo consultas:


    hive --hivevar empid=col1 --hiveconf tablename=emp_tab --hivevar deptno=10 -f /home/alfonso/script.hql


    Todas las consultas dentro de ese script hive se ejecutaron, y las variables dentro de ese script se establecieron 
    durante la ejecución.
