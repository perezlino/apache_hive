/*  INTRODUCCION A LAS VIEWS
    ========================

    Las vistas en Hive son muy similares a lo que habrías aprendido antes en SQL. Permíteme recordar algunas cosas 
    sobre las vistas para empezar esta lección. ¿Qué son las vistas? Las vistas son tablas virtuales que se crean 
    como resultado de una consulta hive sobre alguna tabla. Digo tablas virtuales, ya que en realidad no contienen 
    los datos. Básicamente en Hive, vista es una especie de objeto de búsqueda en una base de datos que en sí no 
    tiene ningún dato, pero puede ser poblada por los resultados de una consulta. He aquí algunas propiedades de las 
    vistas. 

    ● La primera es que las vistas de hive no contienen datos propios, sino que son simplemente los resultados de 
      cualquier consulta de hive sobre una tabla. 

    ● La segunda es que se pueden realizar todo tipo de operaciones DML en una vista, al igual que las operaciones 
      DML de una tabla. 

    ● Las vistas pueden crearse seleccionando cualquier número de filas y columnas de una tabla o tablas base. 
      "Tablas", digo, porque las vistas también pueden reflejar los resultados del join de N número de tablas. 

    ● Una vez creadas, las vistas son independientes del esquema de su tabla base. Esto significa que, después de 
      crear una vista en una tabla con un esquema, el esquema de la vista se congela y no cambiará si se cambia el 
      esquema de la tabla base. Si desea cambiar el esquema de la vista, deberá utilizar el comando ALTER VIEW. 

    ● Y viceversa. Cambiar el esquema de la vista no cambiará el esquema de la tabla. 

    ● Las vistas son de sólo lectura. Cualquier consulta de drop o write sobre las vistas no afectará a nuestra tabla 
      base. 

    ● Además, si se elimina la tabla base, la vista de esa tabla dejará de tener efecto. Esto tiene sentido porque la 
      vista no tiene sus propios datos y sólo refleja los datos consultados de su tabla base. Así que una vez que la 
      tabla base sea eliminada, nuestra vista será como una cometa sin hilos. Así que cualquier consulta disparada en 
      esa vista fallará. 