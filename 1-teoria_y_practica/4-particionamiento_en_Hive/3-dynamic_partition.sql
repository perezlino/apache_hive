/*  DYNAMIC PARTITION
    =================

    Así pues, en el particionamiento estático, vimos que había una carga manual de los datos. Pero, ¿y si queremos 
    que Hive cree automáticamente particiones basadas en el valor de la columna de partición? Esto es lo que llamamos 
    particionamiento dinámico. En lugar de que el usuario proporcione los nombres de las particiones y seleccione los 
    datos de la fuente, Hive lo hace todo por sí mismo. Sólo tenemos que proporcionar la columna en la que la partición 
    se debe hacer, el resto es manejado por Hive. Veamos cómo hacer particiones dinámicas. Por defecto, el particionado 
    dinámico está deshabilitado, así que tenemos que habilitarlo primero mediante esta propiedad: 
    

                                        SET hive.exec.dynamic.partition=true; 


    También hay otra propiedad que se puede cambiar, me refiero al "modo":


                                        SET hive.exec.dynamic.partition.mode=nonstrict;     


    Por defecto está en modo "strict". En realidad, en modo "strict", tenemos que especificar al menos una partición estática 
    junto con las otras particiones dinámicas, en caso de que esté haciendo particiones en múltiples columnas; como en 
    nombre de departamento y salario también (PARTITIONED BY(deptname, sal)); sub-partición. En ese caso, el modo estricto 
    quiere que al menos una partición sea estática, para evitar el número accidental de particiones enormes creadas por el 
    particionamiento dinámico. De todos modos, voy a utilizar el modo "nonstrict" aquí. Bien, vamos a crear otra tabla de 
    particiones con un nombre diferente. La creación de la tabla es igual que las estáticas. 


    CREATE TABLE IF NOT EXISTS part_dept1 (
    deptno int,
    empname string,
    sal int
    ) 
    PARTITIONED BY (deptname string)
    ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
    LINES TERMINATED BY'\n'
    STORED AS TEXTFILE;  


    Cargamos los datos:

    
    INSERT INTO TABLE part_dept1 PARTITION (deptname) SELECT col1, col3, col4, col2 FROM dept;
                                                                               -----

    Aquí no estoy codificando el nombre de la partición, sólo proporcionando el nombre de la columna. Una cosa importante a 
    tener en cuenta en su sentencia SELECT es que, la columna sobre la cual se va a hacer la partición debe estar presente 
    al último. Estoy haciendo la partición en el nombre del departamento que es la columna_2 en la tabla de origen, es por 
    eso que la mantuve en último lugar. Así que vamos a ejecutarlo.

    Esta vez, como el particionado dinámico es true, Hive comprobará los valores de la columna de particionamiento y creará 
    una partición separada para cada valor único de esa columna:


                                    "user/hive/warehouse/part_dept1/deptname=Accounts"
                                    "user/hive/warehouse/part_dept1/deptname=HR"
                                    "user/hive/warehouse/part_dept1/deptname=Marketing"
                                    "user/hive/warehouse/part_dept1/deptname=Sales"


    Como había cuatro departamentos, se crearon cuatro directorios, y esta vez los directorios se crearán con el mismo nombre 
    que el valor de la columna de particionamiento. En las columnas de particionamiento, verá los nombres exactos de estos 
    directorios. 

    Así que ahora después de discutir el particionamiento estático y dinámico, esta es la pregunta clave: ¿qué tipo de 
    particionamiento utilizar y cuándo? Hablando de partición estática, ya que requiere el conocimiento de los datos, es por 
    eso que yo diría que vamos a utilizarlo cuando los datos son conocidos de antemano por nosotros. Pero, de nuevo, como 
    vimos partición estática requiere mucho esfuerzo manual, tenemos que escribir una consulta independiente para cargar cada 
    partición, por lo que es aconsejable utilizar partición estática donde los datos no son muy únicos, que a la larga se 
    traducirá en un menor número de particiones. Por el contrario, el particionado dinámico es adecuado cuando los datos son 
    desconocidos para nosotros o tienen más valores únicos en la columna de particionado. Pero recuerda, que el particionado 
    stático es más rápido que el dinámico, ya que en el primero, proporcionamos todo de antemano a Hive por lo que habría 
    menos comparaciones. Pero en dinámico, Hive por sí mismo tiene que hacer todas las comparaciones y luego cargar los datos 
    en particiones apropiadas, por lo tanto, es más lento. Así que ahora puede elegir el tipo de partición en función de sus 
    datos.

    ------------------------------------------------------------------------------------------------------------------------