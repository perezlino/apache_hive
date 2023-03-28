/*  ESTRUCTURA DE CONTROL
    =====================

    Tenemos la siguiente tabla1:

    SELECT * FROM tabla1;

    499      ["Poole", ""GBR""]      England      141000
    501      ["Blackburn", "GBR"]    England      140000
    500      ["Bolton", "GBR"]       England      139020
    502      ["Newport", "GBR"]      Wales        139000
    503      ["Preston", "GBR"]      England      135000
    504      ["Stockport", "GBR"]    England      132813

    ------------------------------------------------------------------------------------------------------------------------ 

    CONDICIONAL IF
    --------------

    SELECT IF(col3 = 'England', col1, col4) FROM tabla1;

    499
    501
    500
    139000
    503
    504

    ------------------------------------------------------------------------------------------------------------------------

    CASE
    ----

    Primera forma:

    CASE Fruit
        WHEN 'APPLE' THEN 'The owner is APPLE'
        WHEN 'ORANGE' THEN 'The owner is ORANGE'
        ELSE 'It is another Fruit'        
    END


    Segunda forma:

    CASE WHEN Fruit = 'APPLE' THEN 'The owner is APPLE'
         WHEN Fruit = 'ORANGE' THEN 'The owner is ORANGE'
         ELSE 'It is another Fruit'        
    END  

    ------------------------------------------------------------------------------------------------------------------------  