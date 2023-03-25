/*  AVANCE DE COMO TRABAJAR EN HIVE
    ===============================

    Antes de escribir nuestras consultas, quiero explicar brevemente la idea central de Hive. Supongamos que este es 
    un archivo HDFS. Es un archivo de formato de texto simple y tenemos que procesar este archivo en Hive. Digamos que 
    tenemos que contar el número de empleados en el departamento de contabilidad. Ahora un ciclo de vida básico de 
    este caso de uso en Hive será, crear una tabla sobre este archivo, cargar los datos en ella, y luego ejecutar la 
    consulta Hive en esa tabla. Todos estos pasos los vamos a discutir en detalle en este curso. De acuerdo. A primera 
    vista, podemos ver que se trata de un archivo estructurado, y tiene tres columnas en el mismo. Así que vamos a crear 
    una tabla de tres columnas, con la primera columna de tipo string, la segunda columna será de tipo integer, y la 
    tercera será de nuevo de tipo string. Una vez creada la tabla, el segundo paso es cargar los datos en esta tabla Hive.

    He utilizado muy fácilmente la palabra "cargar" aquí, pero tenga en cuenta que la carga no significa en absoluto que 
    estaría moviendo estos datos a Hive. Ya he mencionado en la introducción que Hive no es una base de datos, por lo que 
    no estamos almacenando ningún dato en Hive.

    ¿Qué significa cargar? Cargar aquí significa que, estoy mapeando el esquema de la tabla Hive a este archivo en HDFS. 
    Después de la carga, Hive verá este archivo HDFS como una tabla de tres columnas, y esta cantidad de datos en ella. 
    Repito, después de la carga, Hive verá este archivo de forma tabular, y no hay tal movimiento de datos. Y por fin, 
    cuando nuestra tabla está lista, podemos consultar estos datos similares como nuestro buen viejo SQL. Puedes hacer 
    todas esas consultas, count, sum, group by, where, etc., en esta tabla Hive. En nuestro caso, tenemos que calcular el 
    número de empleados del departamento de contabilidad. Así que es una consulta básica. Puedes ver que esta consulta es 
    exactamente la misma que nuestra SQL. Esa es la belleza de Hive. A lo largo del curso, veremos que todas las consultas 
    se pueden correlacionar fácilmente con SQL. Así que eso es todo para la idea central.  

     __________________________      __________________________      _______________________________
    |                          |    |                          |    |                               |
    |    1. CREAR UNA TABLA    |    |     2. CARGAR DATOS      |    |   3. LANZAR QUERIES EN HIVE   |    
    |__________________________|    |__________________________|    |_______________________________|         
                                                                    ____________________________________
    Mchohan,30,Accounts                                            |  Nombre  |  Edad  |  Departamento  |
    Clarke,28,Dev                       Crear Tabla & Cargar       |----------|--------|----------------|
    Smita,22,Accounts                          datos               | Mchohan  |   30   |    Accounts    |
    Johnny,25,Accounts                       =========>            | Clarke   |   28   |      Dev       |
    Charlie,26,Clerk                                               | Smita    |   22   |    Accounts    | 
                                                                   | Johnny   |   25   |    Accounts    | 
                                                                   | Charlie  |   26   |      Clerk     |
                                                                   |__________|________|________________|