/*  TABLE SAMPLING
    ==============

    ¿Qué es el "table sampling" y qué hace exactamente? Para entenderlo, primero hay que entender qué es una 
    "muestra (sample)". Una muestra, en lenguaje coloquial, significa una pequeña porción de cualquier material u 
    objeto a partir del cual podemos juzgar las propiedades de ese material. De la misma manera, en la terminología 
    de Hive, table sampling significa una muestra de datos de una tabla siguiendo una lógica. Pocos registros de
    datos entre miles de registros. Hay una diferencia entre "limit" y "table sampling" en como toman los datos. En 
    realidad, el operador "limit" no garantiza una muestra siguiendo una lógica. Es decir, puede extraer los datos de 
    una sola partición y un solo bucket. Esos datos sólo se limitarían a esa partición, a ese bucket, y no sería un 
    dataset distribuido. Obviamente, eso no puede ser considerado como una muestra. Pero el table sampling, lo que 
    hará es recoger los datos de forma distribuida a partir de un número de buckets. Déjame mostrarte la diferencia 
    en la práctica.

    Así que supongamos, que estoy tomando la muestra de datos utilizando primero el operador "limit". Estoy usando la 
    bucketed table anterior: 
    
                            
                                        SELECT * FROM dept_buck LIMIT 15;


    Así que este operador de límite nos está dando 10 filas del primer bucket solamente. Las ubicaciones, Delhi, Chennai, 
    Hyderabad, Washington, Pune, estaban presentes en el primer bucket de nuestra tabla. Así que este conjunto de datos 
    no está distribuido uniformemente.   


    Realicemos ahora un "table sampling" sobre esto. Enseguida explicaré la consulta. Primero, veamos los resultados.
    
    
            SELECT deptno, empname, sal, location, FROM dept_buck TABLESAMPLE (BUCKET 1 OUT OF 2 ON location)
    
    
    Como pueden ver, este resultado es una mezcla de ubicaciones. Lo que está haciendo la cláusula "table sample" 
    es dividir tus 4 buckets en grupos de 2 buckets cada uno, y luego seleccionar el primer bucket de cada grupo. Repito, 
    está dividiendo tus 4 buckets en grupos de 2 buckets cada uno, y seleccionando el primer bucket de cada grupo. 2 buckets 
    cada uno significa, 2 grupos que se crearán, y selecciona el primer grupo de estos dos grupos. Puedes incrementar esta 
    variable para obtener menos datos. Por ejemplo, si aumentamos esta variable a 3, Hive creará grupos de 3 buckets y 
    seleccionará el primer bucket de cada grupo, con lo que obtendremos menos datos.   


            SELECT deptno, empname, sal, location, FROM dept_buck TABLESAMPLE (BUCKET 1 OUT OF 3 ON location)  


    El table sampling se puede hacer en cualquier columna, incluso en una columna no bucketed, pero en ese caso, la cláusula 
    table sample escaneará toda la tabla y luego obtendrá la muestra. Y como ya sabes que escanear toda la tabla lleva tiempo, 
    es mejor hacer el table sampling en una columna bucketed, ya que, en este caso, Hive no necesita leer todos los datos para 
    generar la muestra, puesto que los datos ya están organizados en diferentes buckets con la columna bucketed, es decir, en 
    nuestro caso, location. Hive leerá los datos sólo de algunos buckets especificados en la consulta. 


    A continuación, el sampling también se puede hacer usando otros parámetros, como el porcentaje o el número de filas. En 
    realidad, entran dentro del "block sampling". Así que veámoslos rápidamente. En lugar de este parámetro, proporcionemos 
    un porcentaje. Esto permitirá a Hive recoger al menos el 2% del conjunto de datos. No es obligatorio que recoja 
    exactamente el 2% de los datos, también puede elegir más del 2. Este parámetro porcentual significa que Hive tiene que 
    elegir al menos el 2% de los datos. 


                    SELECT deptno, empname, sal, location, FROM dept_buck TABLESAMPLE (2 PERCENT)      


    Entonces podemos muestrear nuestros datos basándonos también en la memoria. Esto significa que Hive debe seleccionar al 
    menos 1 MB de datos como muestra. Si el tamaño de la tabla o del archivo es inferior a 1 MB, seleccionará todo el archivo.


                    SELECT deptno, empname, sal, location, FROM dept_buck TABLESAMPLE (1M) 


    El último es el muestreo de tablas por número de filas. Esto es un poco diferente de los dos anteriores. En realidad, 
    este 20 significa que Hive tiene que seleccionar 20 filas de cada división de entrada (input split ?). Así que el número 
    de resultados de esta consulta variará según el número de "input splits".         


                    SELECT deptno, empname, sal, location, FROM dept_buck TABLESAMPLE (20 ROWS)                 