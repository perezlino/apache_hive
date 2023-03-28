/*  FUNCIONES SPLIT(), SUBSTR() Y INSTR()
    =====================================

    SPLIT()
    -------

    SELECT SPLIT('hive:hadoop', ':');

    Y obtenemos: ["hive", "hadoop"]

    ------------------------------------------------------------------------------------------------------------------------

    SUBSTR()
    --------

    SELECT SUBSTR('hive is quering tool', 4);

    Y obtenemos: e is quering tool


    SELECT SUBSTR('hive is quering tool', 4, 3);

    Y obtenemos: e i  

    ------------------------------------------------------------------------------------------------------------------------

    INSTR()     
    -------

    Indica el primer número de indice de la cadena del caracter que se especifica como argumento.

    SELECT INSTR('hive is quering tool', 'e');

    Y obtenemos: 4

    ------------------------------------------------------------------------------------------------------------------------