/*  TRABAJAR CON NULOS
    ==================

    Tenemos la siguiente tabla1:

    SELECT * FROM tabla1;

                                499      ["Poole", ""GBR""]      England      141000
                                501      ["Blackburn", "GBR"]    England      140000
                                500      ["Bolton", "GBR"]       England      139020
                                502      ["Newport", "GBR"]      Wales        139000
                                503      ["Preston", "GBR"]      England      135000
                                504      ["Stockport", "GBR"]    England      132813

    ------------------------------------------------------------------------------------------------------------------------ 

    ISNULL
    ------

    SELECT ISNULL(col1) FROM tabla1;

    false
    false
    false
    false
    false
    false

    ------------------------------------------------------------------------------------------------------------------------

    ISNOTNULL
    ---------

    SELECT ISNOTNULL(col1) FROM tabla1;

    true
    true
    true
    true
    true
    true

    ------------------------------------------------------------------------------------------------------------------------

    COALESCE
    --------

    Tenemos la siguiente tabla:

    SELECT * FROM tblDates;

                                p_key       datefield1      datefield2      datefield3

                                1           NULL            NULL            1993-06-04
                                2           NULL            2005-06-12      NULL


    Entonces:

    SELECT COALESCE(datefield1, datefield2, datefield3) AS first_date_found FROM tblDates;

    1993-06-04
    2005-06-12

    ------------------------------------------------------------------------------------------------------------------------

    NVL
    ---

    La función NVL la explicaremos en base a un ejemplo. Si la columna "supplier_desc" es NULA, devolverá el valor
    de la columna "supplier_name". Y, por el contrario, si la columna "supplier_desc" no es NULA, devolverá el su 
    valor.

    SELECT NVL(supplier_desc, supplier_name) FROM suppliers;

    ------------------------------------------------------------------------------------------------------------------------