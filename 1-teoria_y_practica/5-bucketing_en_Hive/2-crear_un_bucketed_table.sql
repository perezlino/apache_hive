/*  CREAR UN BUCKETED TABLE
    =======================

    Vamos a empezar a crear bucketed tables. Lo que voy a hacer es particionar los datos por "departamentos". Luego, 
    dentro de cada departamento, habrá buckets separados por "localización". Así que esta sería mi tabla de origen.

    Creamos la tabla y cargamos los datos del archivo "dept_loc.txt":

                                CREATE TABLE IF NOT EXISTS dept_with_loc (
                                col1 int,
                                col2 string,
                                col3 string,
                                col4 int,
                                col5 string
                                ) 
                                ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
                                LINES TERMINATED BY'\N'
                                STORED AS TEXTFILE;

                                LOAD DATA LOCAL INPATH '/home/alfonso/dept_loc.txt' INTO TABLE dept_with_loc;


    Ahora si visualizamos la tabla recién creada:

    SELECT * FROM dept_with_loc;

    dept_with_loc.col1       dept_with_loc.col2       dept_with_loc.col3       dept_with_loc.col4       dept_with_loc.col5

    10                       Accounts                 Joyce                     2098                       Delhi
    20                       Sales                    Richard                   2743                       Hyderabad
    40                       HR                       Yumi                      3154                       Los Angeles
    40                       HR                       Michiyo                   2239                       Washington
    30                       Marketing                Victor                    2365                       Houston
    40                       HR                       Gordon                    2780                       Austin
    10                       Accounts                 Sandy                     3284                       New York
    10                       Accounts                 Alex                      2562                       Washington
    20                       Sales                    Ana                       3457                       Washington
    40                       HR                       Valerie                   2091                       Denver
    ...                      ...                      ...                       ...                        ...   
    ...                      ...                      ...                       ...                        ...


    Ahora creamos una partición con la bucketed table e insertamos estos datos en ella. Por defecto, el bucketing no está
    habilitado. Así que debemos habilitarlo con: 
    

                                                SET hive.enforce.bucketing=true 
    
    
    Además, como voy a realizar una inserción dinámica de particiones, configuramos el modo como no-estricto: 
    
    
                                        SET hive.exec.dynamic.partition.mode=nonstrict

    ------------------------------------------------------------------------------------------------------------------------

    CREAR LA "BUCKETED TABLE"
    -------------------------

    Ahora creemos la bucketed table:

                                CREATE TABLE IF NOT EXISTS dept_buck (
                                deptno int,
                                empname string,
                                sal int,
                                location string
                                ) 
                                PARTITIONED BY (deptname string)
                                CLUSTERED BY (location string) INTO 4 BUCKETS      <------------ 
                                ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
                                LINES TERMINATED BY'\N'
                                STORED AS TEXTFILE;

    Cargamos los datos:

    
    INSERT INTO TABLE dept_buck PARTITION (deptname) SELECT col1, col3, col4, col5, col2 FROM dept_with_loc;  


    Veamos las particiones:


                                          SHOW PARTITIONS dept_buck;

    partition
    deptname=Accounts
    deptname=HR
    deptname=Marketing
    deptname=Sales            


    Ahora para ver los buckets, voy a ir a través de la UI. Puedes hacerlo a través de CLI también, pero UI es más fácil. 
    Navega por el sistema de archivos. Este es el nombre de mi tabla. Contiene 4 particiones, y dentro de las particiones 
    hay 4 buckets. Si por ejemplo, ingresamos a la partición "Accounts". El primer bucket contiene Hyderabad, Delhi, 
    Washington, Chennai y Pune. Estas ubicaciones están asignadas al primer bucket y no estarán presentes en ningún otro 
    bucket de esta partición. Vamos al segundo bucket. Contiene Nueva York, Chandigarh y Los Angeles. Y asi sucesivamente 
    con los 2 buckets restantes.

    ------------------------------------------------------------------------------------------------------------------------

    Concluiremos la creación de buckets con algunos puntos clave:
    -------------------------------------------------------------

    ● En primer lugar, cada bucket es físicamente un archivo en una jerarquía de directorios de tablas. 
   
    ● Podemos establecer explícitamente el número de buckets cuando creemos la tabla

    ● Ahora bien, si comparamos el particionado y el bucketing, en la mayoría de los casos se utilizan uno al lado del otro 
      para lograr el mayor nivel de optimización, pero a veces sólo el bucketing nos da la mejor optimización que la 
      utilizada con el particionado. Por ejemplo, supongamos que tenemos un data set en el que tenemos rangos de datos muy 
      singulares. Como si asumiéramos, en nuestro ejemplo anterior del salario de los empleados, que tenemos un total de 500 
      registros en esa tabla, y en esos 500 registros hay 100 departamentos únicos diferentes. Así que en ese caso, si 
      hacemos la partición, habrá 100 particiones en sí, que es un total no para la optimización. El uso de la partición será 
      ineficaz en ese caso. Así que, en lugar de particionar, en este caso sólo podemos realizar bucketing, ya que un bucket 
      es sólo un archivo y, además, podemos controlar el número de buckets creados, ya que se menciona explícitamente durante 
      la creación de la tabla.

    ● También tenemos una limitación en el bucketing. Es que, no asegura si los datos están correctamente cargados o no, en 
      una tabla. Tenemos que manejar esta carga de datos en buckets por nosotros mismos.        

    ------------------------------------------------------------------------------------------------------------------------      