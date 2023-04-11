/*  PROPIEDADES ACID/TRANSACCIONALES DE HIVE
    ========================================

    En esta lección, vamos a discutir las propiedades ACID de Hive, es decir, INSERT, UPDATE y DELETE. Esto ya lo he 
    mencionado en las lecciones introductorias, que Hive ha comenzado a apoyar las características transaccionales de 
    su versión 0.14, pero todavía no es muy eficiente y tiene algunas limitaciones. Así que antes de crear nuestras 
    tablas y realizar, INSERT, UPDATE, DELETE, vamos a ver primero las limitaciones de Hive en la realización de ellos. 


    LIMITACIONES TRANSACCIONALES EN HIVE
    ------------------------------------

    ● En primer lugar, hasta ahora, sólo el formato de archivo ORC es compatible con las transacciones. Esto significa 
      que, durante la creación de una tabla, tenemos que crear sólo una tabla ORC, no podemos utilizar archivos txt, 
      parquet, avro, o cualquier otro formato de archivo, porque sólo las tablas ORC soportan características 
      transaccionales en Hive. El soporte de otros formatos de archivo puede venir en el futuro. 
    
    ● En segundo lugar, las tablas deben estar bucketed para hacer uso de las características transaccionales. No es 
      posible ejecutar funciones transaccionales en tablas no bucketed. 
      
    ● En tercer lugar, las funciones BEGIN, COMMIT y ROLLBACK tampoco están soportadas hasta ahora. Todas las operaciones 
      son auto-commit, no hay opciones de commit manual para los usuarios. 
      
    ● Por último, no se permite leer o escribir en una tabla ACID desde una sesión que no sea de usuario. Esto significa 
      que podemos trabajar con una tabla ACID sólo cuando la propiedad de concurrencia se establece en true en esa sesión. 
      Estas son algunas de las limitaciones a la hora de trabajar con tablas transaccionales en Hive. 


    Estas son algunas de las limitaciones de las tablas transaccionales en Hive. Veamos ahora cómo realizar insert, updates 
    y deletes en una tabla. Antes de crear tablas transaccionales, tenemos que establecer algunas propiedades a true para 
    habilitarlas. Así que, en primer lugar, tenemos que establecer la propiedad de concurrencia a true, y puesto que una 
    tabla sería una tabla bucketed, por lo que bucketing también debe ser true. A continuación, el modo de particionamiento 
    dinámico debe ser no estricto, y la propiedad "compactor.initiator.on" también debe ser verdadera, y los hilos de trabajo 
    del compactador (compactor worker threads) deben tener un valor positivo. El valor indica el número de hilos de 
    compactador (compactor worker threads) que se ejecutarán en esta instancia de metastore. Por último, mi 
    "hive transaction manager" debe tener el valor indicado: 


    set hive.support.concurrency = true;
    set hive.enforce.bucketing = true;
    set hive.exec.dynamic.partition.mode = nonstrict;
    set hive.compactor.initiator.on = true;
    set hive.compactor.worker.threads = 1;
    set hive.txn.manager = org.apache.hadoop.hive.ql.lockmgr.DbTxnManager;


    Aparte de estas propiedades, a veces también necesitamos establecer una propiedad en "hive-site.xml", porque esa propiedad 
    no es runtime, y no se puede establecer para una sesión. Para ello, tienes que ir a la carpeta donde está instalado Hive.
    (en caso de necesidad revisar clase).

    ------------------------------------------------------------------------------------------------------------------------

    CREAR TABLA TRANSACCIONAL
    -------------------------

    Ahora, después de establecer todas las propiedades, vamos a aprender a crear la tabla ACID, o podemos decir tabla transaccional. 
    Para ello, creamos la tabla:


                                CREATE TABLE IF NOT EXISTS employee (
                                emp_id int,
                                emp_name string,
                                emp_dep string
                                ) 
                                CLUSTERED BY (emp_id) INTO 4 BUCKETS
                                STORED AS ORC;
                                TBLPROPERTIES("transactional"="true")


  Después de establecer la propiedad transaccional de esta tabla a true, nuestra tabla de empleados se ha convertido en acid-enabled. 
  Ahora podemos realizar operaciones de INSERT, UPDATE, DELETE sobre ella. Empezando con la primera operación, esta tabla está vacía 
  hasta ahora, vamos a insertar algunos datos en ella. La consulta de inserción es casi la misma que la consulta de inserción de SQL, 
  es decir, como esta:


  INSERT INTO TABLE employee VALUES('101','Jack','HR'),('102','Frank','HR'),('103','Lul','Clerical'),('104','Smith','Accounts'),
                                   ('105','Stan','HR'),('106','Hakuna','Clerical');


  Ahora bien, si deseas volver a insertar los mismos datos en esta tabla, el Hive shell anexará los nuevos datos a los anteriores, 
  Hive no los sobrescribirá.  

  Después de INSERT, vamos a realizar la operación de UPDATE. La consulta de update es igual que la consulta de update en SQL. Así 
  que escribiremos:


                                UPDATE employee SET emp_dep="Accounts" WHERE emp_id = 102;


  Para una simple actualización de una fila, se lanza un MapReduce job, que de nuevo está tardando tiempo. Este es uno de los puntos 
  que apoyan la afirmación de que "las propiedades ACID no son muy eficientes en Hive".    

  Ten en cuenta que no podemos actualizar la columna bucketed en Hive. En nuestra tabla, si intento actualizar el ID del empleado, se 
  produce un error que dice "Updating values of bucketing columns is not supported". Esto puede considerarse una limitación más de las 
  funciones transaccionales de Hive.  

  Ahora nos quedan las operaciones de eliminar. Hagámoslo:


                                              DELETE FROM employee WHERE emp_id = 104;   


  Se eliminaron los registros que tuvieran el emp_id = 104.                                                                       