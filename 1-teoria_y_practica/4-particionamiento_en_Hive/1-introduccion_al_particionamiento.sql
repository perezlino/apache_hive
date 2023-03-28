/*  INTRODUCCION AL PARTICIONAMIENTO
    ================================

    Bienvenidos estudiantes a esta sección crucial de particionamiento y bucketing. Particionamiento y bucketing, 
    ambas son formas de organizar los datos de una tabla en partes basadas en el valor de la key de particionamiento. 
    Antes de entrar en el tema de las query, echemos un vistazo a un escenario general. En tiempo real, tendríamos 
    GBs, TBs, incluso petabytes de datos. Supongamos que tenemos un archivo de 10 GB. Digamos que este archivo (dept.txt) 
    contiene datos sobre algunos departamentos de una empresa. Y sin el concepto de particionamiento utilizado, nuestro 
    archivo o podemos decir los datos de la tabla Hive, estarán en un directorio como este; " home/user/department_table". 
    Todo el archivo de 10 GB con todas las cuentas en un solo directorio. Ahora en este directorio, cuando se dispara una 
    consulta de búsqueda para seleccionar sólo los datos del departamento de accounts, Hive tiene que escanear el archivo 
    completo y recuperar sólo aquellas filas donde department_column es igual a accounts. Así que, en este caso, hemos 
    hecho que Hive innecesariamente escanee otros departamentos cuando sólo tiene que recuperar el departamento de accounts. 
    Entonces por que no creamos un directorio separado para el departamento de accounts, y guardamos en el solo los datos 
    del departamento de accounts. Y del mismo modo, más directorios se pueden hacer para otros departamentos. Tiene sentido. 
    Asi que basicamente estamos particionando los datos en base al departamento. Después de la partición, a partir de ahora, 
    cada vez que una consulta SELECT se dispara con cualquier nombre de departamento en su cláusula "WHERE", entonces Hive 
    irá directamente a ese directorio de departamento y no irá a los demás. Esto ahorrará una enorme cantidad de tiempo y 
    los resultados se obtienen rápidamente. Muy bien. Esto es lo que la base fundamental de la partición es; segregar los 
    datos en varios directorios.