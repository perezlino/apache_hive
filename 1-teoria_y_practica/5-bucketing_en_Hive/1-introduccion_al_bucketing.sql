/*  INTRODUCCIÓN AL BUCKETING
    =========================

    En este video, vamos a cubrir una característica más de almacenamiento de datos de Hadoop es decir, bucketing. Bucketing 
    es otra técnica de organización de datos en Hive, como la partición. Es una técnica para descomponer grandes conjuntos de 
    datos en puertos más manejables. La base fundamental de bucketing es que, cuando una tabla es bucketeada en una columna, 
    entonces todos los registros con el mismo valor de columna irán al mismo bucket. Podemos usar el bucketing directamente en 
    una tabla, pero el mejor resultado se obtiene cuando hacemos el bucketing y el particionado uno al lado del otro. Podemos 
    suponer que, en primer lugar, vamos a crear una partición, y dentro de la partición de los datos serán almacenados en 
    buckets. Vamos a entenderlo con un ejemplo. Supongamos que tengo una tabla con los salarios de los empleados de una empresa X. 
    Mi tabla contiene tres columnas: ID del empleado, departamento del empleado y salario del empleado. En primer lugar, para 
    obtener un buen rendimiento y una mejor organización de los datos, lo que podemos hacer es, podemos crear particiones basadas 
    en el departamento. Así que cada departamento es una partición ahora. ¿Pero qué pasa si una partición tiene muchos registros? 
    ¿Y si incluso después de crear una partición, la latencia es alta? Para lograr una mejor organización de los datos, vamos a 
    hacer bucketing en esta tabla. Así que, dentro de una partición, si estoy creando buckets para dividir los datos, estaré 
    logrando la mejor optimización. Ahora, si estoy haciendo bucketing en la columna de salario y creando dos buckets, entonces 
    dentro de cada partición, todos los empleados con 10,000 de salario estarán presentes en un solo bucket, y en ningún otro 
    lugar. Por favor, no se confunda que habrá diferentes buckets para diferentes salarios. Puede haber cualquier número de 
    salarios en un solo bucket, pero esos registros de salarios estarán presentes sólo en ese bucket. Así, por ejemplo, los 
    empleados con salarios de 10.000, 20.000 y 40.000 están en este bucket. En el segundo bucket se encuentran los empleados con 
    salarios de 30.000 y 50.000, y lo mismo para todas las particiones. Tenga en cuenta que, a diferencia de la partición, un 
    bucket es físicamente un archivo, mientras que la partición es un directorio. Internamente, qué salario irá a qué bucket, se 
    decide por un algoritmo hashing. Bien, vamos a crear una tabla mientras hacemos particiones y bucketing en ella, y tomaremos 
    un nuevo ejemplo para ello.

     _____________________________________          
    |   EMP_ID   |   DEPT   |   SALARIO   |       PARTICIONES
    |------------|----------|-------------|            | 
    |     1      |    HR    |   10.000    |            | 
    |     13     |    HR    |   20.000    |      ______|______________________________________________________
    |     44     |  ACCNT   |   30.000    |     |                               |                             |
    |     55     |  SALES   |   10.000    |     |                               |                             |
    |     95     |  ACCNT   |   40.000    |     |                               |                             |
    |     67     |    HR    |   50.000    |     ˅                               ˅                             ˅   
    |     24     |  ACCNT   |   10.000    |     HR                            ACCNT                         SALES  
    |     66     |    HR    |   10.000    |
    |     77     |    HR    |   50.000    |   BUCKETS:  
    |     09     |  SALES   |   10.000    |  _____        _____            _____        _____            _____        _____  
    |     89     |  ACCNT   |   20.000    | | --- |      | --- |          | --- |      | --- |          | --- |      | --- |
    |     54     |  SALES   |   50.000    | | --- |      | --- |          | --- |      | --- |          | --- |      | --- |     
    |     34     |  ACCNT   |   20.000    | |_____|      |_____|          |_____|      |_____|          |_____|      |_____|    
    |     23     |    HR    |   40.000    |    
    |     21     |    HR    |   30.000    |  1, 10.000   21, 30.000       10.000        30.000           10.000       30.000 
    |     43     |  SALES   |   50.000    | 66, 10.000   77, 50.000       20.000        50.000           20.000       50.000
    |     90     |  ACCNT   |   30.000    |   .                           40.000                         40.000
    |     11     |  ACCNT   |   30.000    |   .
    |     10     |    HR    |   20.000    | 13, 20.000
    |____________|__________|_____________| 10, 20.000
                                            23, 40.000                                                                                                                             