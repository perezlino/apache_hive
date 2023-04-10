/*  VENTAJAS DE LAS VIEWS
    =====================

    La pregunta que surge es ¿por qué utilizar vistas cuando ya tenemos tablas presentes? Así que finalmente esta 
    pregunta nos lleva a discutir las ventajas de las vistas. Las vistas son una parte muy importante de cualquier 
    proyecto Hadoop o no Hadoop. Si algunos de ustedes tienen alguna experiencia de trabajo de TI, entonces saben 
    que en los proyectos en vivo, es muy raro que nos permiten acceder a una tabla a un usuario directamente. Si el 
    usuario tiene que obtener datos, tiene que obtenerlos a través de vistas solamente. Además, cada usuario tiene 
    un número diferente de accesos. Los usuarios más altos de la cadena tendrían acceso a todas las columnas de los 
    datos de nuestras tablas, pero el resto sólo tiene acceso a un número limitado de columnas. Permítanme dar peso 
    a mi punto con este ejemplo. Supongamos que tenemos esta tabla de datos de empleados en una empresa con todas 
    estas columnas, y que los datos de esta tabla son requeridos por varios empleados, como RRHH, administrativos, 
    personal de soporte, etc. Ahora, obviamente, los RRHH pueden tener y requerir todos los detalles de un empleado. 
    Pero el personal de soporte, solo necesitaría el ID del empleado, nombre, posición, lugar de trabajo, este tipo 
    de datos, y no hay necesidad de que comprueben la columna de salario. ¿No es así? En realidad, este es un pequeño 
    ejemplo con una tabla pequeña, pero en tiempo real cuando las tablas tienen cientos de columnas y un número de 
    nivel de accesos, esta vista encaja directamente en la imagen. Crear vistas separadas con diferente número de 
    columnas para cada nivel de acceso, y como las vistas son virtuales y no ocupan espacio real, no hay problema de 
    espacio en disco. Así que en este ejemplo, voy a crear una vista de cinco columnas, excluyendo la columna de 
    salario para el personal de soporte. Así que esta es una gran ventaja, y puedo decir que la motivación detrás de 
    la invención de las vistas, que las vistas se pueden utilizar para ocultar las columnas de la tabla subyacente 
    de algunos usuarios. 

    La segunda ventaja es que, al crear vistas, estamos protegiendo los datos de nuestras tablas base de ser 
    accidentalmente eliminados o alterados. Las vistas son de sólo lectura y sólo pueden mostrar los datos de la tabla, 
    no pueden alterarlos ni eliminarlos.  

    Otra ventaja que se puede considerar es que las vistas nos permiten crear una abreviatura para una consulta más 
    complicada, como una consulta join. Ya has visto la consulta join que ejecuté en la clase anterior. Así que en 
    lugar de usar esa compleja consulta una y otra vez, podemos simplemente crear una vista en esa tabla, con la consulta 
    join en su sentencia select, y luego acceder a los datos desde la vista escribiendo una simple consulta ""SELECT *". 
    Así que las vistas pueden ayudar a convertir las consultas largas y complicadas en consultas de una sola línea.