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

    Now after all the properties are set, let us learn how to create the ACID table, or we can say transactional table. For that, create table. I'm creating a table "employee". Emp_id is of INT data type, emp name of string data type, then emp department, that is also a string data type. Since it was mandatory that for transactional features, a table should be bucketed, so we are creating a bucketed table. I'm choosing 4 buckets, stored as ORC file, because only ORC file format supports transactional features. Here are my table properties. After setting this transactional property of this table to true, our employee table has now become acid-enabled. We can now perform insert, update, delete, operations on it. So starting with our first operation, this table is empty till now, let us insert some data in it. The insert query is almost same like insert query of SQL i.e. like this, "INSERT INTO TABLE [tablename] [Values to be inserted]". This is my first column value, second column value, and third column value. Each row values are separated by braces. It means this is my first row, this is my second row, third row, fourth row, and so on. This query is similar like we do insert in SQL, so let us do. Insert will launch a MapReduce job. the data got inserted. Let us check. It has inserted all the rows. Now if you want to insert the same data into this table again, then Hive shell will append the new data with the previous data, Hive won't overwrite it. The new data will get appended to the old data. Let us insert the same data. As you can see, this is the old row and this is the new row. Rather than overriding, it has appended the new data. After insert, let us perform update operation. Update query is also same like update query in SQL. So we'll type "UPDATE tablename", "UPDATE employee SET m_department=accounts", I'm changing the department name, [WHERE emp_id=102]. This query will change the employee department to accounts, where employee ID is 102. As you can see, for a simple update of one row, it has launched a MapReduce job, which again is taking time. This is one of the points which support the statement that "ACID properties are not very efficient in Hive". It has updated and taken quite a long time. "SELECT * FROM employee". As you can see, 102 has changed to accounts. Please note that we cannot update the bucketed column in Hive. In our table, if I try to update employee ID, then it would throw an error saying "Updating values of bucketing columns is not supported". This can be considered as one more limitation in transactional features of Hive. We are now left with delete operations. Let us do that. "DELETE FROM employee" [WHERE emp_id=104]". For this delete also, it will launch a MapReduce job. Let us see. It has deleted the employees of 104 ID. With this, we have completed our ACID or transactional features of Hive. See you in next video.
