/*  INTRODUCCION A LAS UDF
    ======================

    En este video, voy a explicar el tema más importante y ampliamente utilizado en proyectos en tiempo real, que 
    es UDF. UDF significa Funciones Definidas por el Usuario. ¿Qué son las UDF? En la sección "Funciones", he 
    explicado todas las funciones disponibles en Hive, pero en proyectos en tiempo real, estas funciones aún no son 
    suficientes. Por ejemplo, Hive proporciona una función incorporada (built-in function) para convertir las 
    mayúsculas en minúsculas, y las minúsculas en mayúsculas. Pero si tenemos que cambiar sólo la primera letra de una 
    palabra, es decir, tenemos que convertir sólo la primera letra de una palabra en mayúscula, no disponemos de una 
    función incorporada para esta situación. Hive proporciona una utilidad UDF para manejar esta situación. Podemos 
    definir nuestras propias funciones, es decir, funciones definidas por el usuario, según las necesidades. Estas 
    funciones se escribirán en Java, y hay algunas reglas que se deben seguir al escribir las UDF, que explicaré al 
    escribir el código. 
    
    Este es el flujo que seguimos para ejecutar una UDF en Hive: 
    
    1.- El primer paso es crear un programa Java en cualquier plataforma, yo utilizaré Eclipse. 
    2.- El paso dos es, guardar o convertir el programa en un archivo jar. 
    3.- El paso tres es, añadir ese archivo jar en nuestro Hive shell. 
    4.- El paso cuatro es, crear una función de ese archivo jar que hemos añadido. 
    5.- Y el quinto paso es, para utilizar esas funciones en una consulta Hive de acuerdo a los requerimientos. 
    
    Todos estos pasos los realizaremos a continuación.