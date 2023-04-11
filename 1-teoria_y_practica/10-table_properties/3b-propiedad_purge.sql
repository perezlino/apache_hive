/*  PROPIEDAD PURGE
    ===============

    Pasemos ahora a la purga. "Purge" es una propiedad de la tabla y se introdujo a partir de la versión 0.14 de Hive. 
    Si "purge" se establece en "true", en caso de que se elimine (drop) una tabla interna, los datos no irán a la 
    papelera, sino que desaparecerán permanentemente. Ahora, antes de seguir hablando, voy a explicar este comando purge 
    en un momento, voy a mostrar cómo establecer una propiedad purge. Para esto, voy a crear una tabla. Nombrala como 
    "tabla7". 

                                CREATE TABLE IF NOT EXISTS table7 (
                                col1 string,
                                col2 int
                                ) 
                                ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
                                LINES TERMINATED BY'\n'
                                STORED AS TEXTFILE;
                                TBLPROPERTIES("auto.purge"="true");

    Esta es la forma de establecer la propiedad de la tabla de purge a true. ¿Qué hará esta propiedad "auto.purge"="true"? 
    en un entorno normal, cuando "purge" no se establece en true, en ese caso, cuando se elimina una tabla interna, los 
    datos primero van al directorio de basura, y si la eliminación se hizo por error, los administradores de Hadoop pueden
    recuperar los datos de la basura, pero los metadatos en este caso se han ido permanentemente. Y en nuestro segundo caso, 
    como en este caso, si "purge" se establece en "true" y luego estamos eliminando una tabla, los datos no irán al directorio 
    de basura, sino que desaparecerán por completo junto con los metadatos. La misma lógica es válida para el comando 
    "truncate", que los datos desaparecerán completamente cuando se especifique "purge", pero como es un comando truncate, 
    los metadatos estarán presentes para esa tabla. 