/*  FUNCIONES STRING
    ================

    Tenemos la siguiente tabla1:

    SELECT * FROM tabla1;

    499      ["Poole", ""GBR""]      England      141000
    501      ["Blackburn", "GBR"]    England      140000
    500      ["Bolton", "GBR"]       England      139020
    502      ["Newport", "GBR"]      Wales        139000
    503      ["Preston", "GBR"]      England      135000
    504      ["Stockport", "GBR"]    England      132813

    ------------------------------------------------------------------------------------------------------------------------    

    CONCAT
    ------

    SELECT CONCAT(col1, '-', col3) FROM tabla1;

    499-England
    501-England
    500-England
    502-Wales
    503-England
    504-England

    ------------------------------------------------------------------------------------------------------------------------

    LENGTH
    ------

    SELECT LENGTH(col3) FROM tabla1;

    7
    7
    7
    5
    7
    7

    ------------------------------------------------------------------------------------------------------------------------

    LOWER
    -----

    SELECT LOWER(col3) FROM tabla1;

    england
    england
    england
    wales
    england
    england

    ------------------------------------------------------------------------------------------------------------------------

    UPPER
    -----

    SELECT UPPER(col3) FROM tabla1;

    england
    england
    england
    wales
    england
    england

    ------------------------------------------------------------------------------------------------------------------------

    LPAD (LEFT-PAD)
    ----

    En el primer argumento le indicamos la columna que queremos trabajar, en el segundo parámetro indicamos el
    total de caracteres que tendrá el valor de la columna y en el tercer parámetro indicamos el caracter que se
    agregará. 

    SELECT LPAD(col3, 10, 'v') FROM tabla1;

    vvvEngland
    vvvEngland
    vvvEngland
    vvvvvWales
    vvvEngland
    vvvEngland

    ------------------------------------------------------------------------------------------------------------------------

    RPAD (RIGHT-PAD)
    ----

    En el primer argumento le indicamos la columna que queremos trabajar, en el segundo parámetro indicamos el
    total de caracteres que tendrá el valor de la columna y en el tercer parámetro indicamos el caracter que se
    agregará. 

    SELECT LPAD(col3, 10, 'v') FROM tabla1;

    Englandvvv
    Englandvvv
    Englandvvv
    Walesvvvvv
    Englandvvv
    Englandvvv

    ------------------------------------------------------------------------------------------------------------------------

    TRIM, LTRIM y RTRIM
    -------------------

    SELECT TRIM('   Alfonso   ')

    Alfonso

    SELECT LTRIM('   Alfonso')    

    Alfonso

    SELECT RTRIM('Alfonso   ')       

    Alfonso

    ------------------------------------------------------------------------------------------------------------------------

    REPEAT
    ------

    SELECT REPEAT(col3, 2) FROM tabla1;

    EnglandEngland
    EnglandEngland
    EnglandEngland
    WalesWales
    EnglandEngland
    EnglandEngland    

    ------------------------------------------------------------------------------------------------------------------------

    REVERSE
    -------

    SELECT REVERSE(col3) FROM tabla1;

    dnalgnE
    dnalgnE
    dnalgnE
    selaW
    dnalgnE
    dnalgnE   

    ------------------------------------------------------------------------------------------------------------------------