/*  TIPOS DE DATOS
    ==============

    TIPOS PRIMITIVOS
    ----------------

    TIPOS Numericos
    ---------------

    ● TINYINT            (1-byte, desde -128 a 127) 100Y
    ● SMALLINT           (2-byte, desde -32,768 a 32,767) 100S
    ● INT/INTEGER        (4-byte, desde -2,147,483,648 a 2,147,483,647) 280
    ● BIGINT             (8-byte, desde -9,223,372,036,854,775,808 a 9,223,372,036,854,775,808) 100L 
    ● FLOAT              (4-byte, single precision floating point number) 3.14 
    ● DOUBLE             (8-byte, double precision floating point number)
    ● DOUBLE PRECISION   (alias for DOUBLE, solo disponible desde Hive 2.2.0)
    ● DECIMAL            (Introducido en Hive 0.11.0 con una precision de 38 digitos)
    ● NUMERIC            (similar a DECIMAL) 

    TIPOS Date/Time:
    ----------------

    ● TIMESTAMP          (ejemplo, yyyy-MM-dd'T'HH:mm:ss.SSS) 
    ● DATE               (ejemplo, DATE'2013-01-01') 
    ● INTERVAL

    TIPOS String:
    ------------

    ● STRING
    ● VARCHAR
    ● CHAR

    TIPOS Misc:
    -----------

    ● BOOLEAN
    ● BINARY

    ------------------------------------------------------------------------------------------------------------------------

    TIPOS COMPLEJOS
    ---------------

                    DESCRIPCION                                                     EJEMPLO

    ● ARRAYS        ARRAY<data_type>                                                ARRAY('SAM', 'TONY')
    ● MAPS          MAP<primitive_type, data_type>                                  MAP('first', 'SAM', 'last', 'Clark')
    ● STRUCTS       STRUCT<col_name:data_type [COMMENT col_comment], ...>           STRUCT('Mike', 'Waugh')
    ● UNION         UNIONTYPE<ata_type, data_type>                                  UNIONTYPE(0:int, 1:double, 2:array<string>,
                                                                                              3:struct<a:int, b:string>)  

    ------------------------------------------------------------------------------------------------------------------------                                                                                                