/*  FUNCIONES DE FECHA
    ==================

    UNIX_TIMESTAMP
    --------------

    Así que esta función devuelve el número de segundos entre la fecha especificada en el argumento, y el 
    Unix time epoch. Este Unix time epoch es un valor establecido por Unix que es 1970-01-01 00:00:00.

    SELECT UNIX_TIMESTAMP('2017-04-26 00:00:00')

    Y obtenemos: 1493145000

    ------------------------------------------------------------------------------------------------------------------------

    FROM_UNIXTIME
    -------------

    Este comando es justo lo contrario del comando anterior. Este comando devolverá la fecha a partir de segundos. 
    Devuelve la fecha, y esa fecha la está calculando desde 0 segundos, desde la Unix time epoch 1970-01-01 00:00:00.

    SELECT FROM_UNIXTIME(1234145)

    Y obtenemos: 1970-01-15 12:19:05

    ------------------------------------------------------------------------------------------------------------------------

    TO_DATE(string timestamp)
    -------------------------

    La función TO_DATE devuelve la parte de fecha del timestamp en el formato "yyyy-MM-dd".

    SELECT TO_DATE('2000-01-01 10:20:30')

    Y obtenemos: '2000-01-01'

    ------------------------------------------------------------------------------------------------------------------------

    YEAR(string date)
    -----------------

    La función YEAR devuelve el año de la fecha.

    SELECT YEAR('2000-01-01 10:20:30')

    Y obtenemos: 2000

    ------------------------------------------------------------------------------------------------------------------------

    MONTH(string date)
    ------------------

    La función MONTH devuelve el mes de la fecha.

    SELECT MONTH('2000-03-01 10:20:30')

    Y obtenemos: 3 

    ------------------------------------------------------------------------------------------------------------------------

    DAY(string date)   
    DAYOFMONTH(date)
    ----------------

    Las funciones DAY y DAYOFMONTH devuelve el día de la fecha.

    SELECT DAY('2000-03-01 10:20:30')

    Y obtenemos: 1 

    ------------------------------------------------------------------------------------------------------------------------

    HOUR(string date)
    -----------------

    La función HOUR devuelve la hora del timestamp.

    SELECT HOUR('2000-03-01 10:20:30')

    Y obtenemos: 10 

    ------------------------------------------------------------------------------------------------------------------------

    MINUTE(string date)
    -------------------

    La función MINUTE devuelve los minutos del timestamp.

    SELECT MINUTE('2000-03-01 10:20:30')

    Y obtenemos: 20     

    ------------------------------------------------------------------------------------------------------------------------

    SECOND(string date)
    -------------------

    La función SECOND devuelve los segundos del timestamp.

    SELECT SECOND('2000-03-01 10:20:30')

    Y obtenemos: 30   

    ------------------------------------------------------------------------------------------------------------------------

    WEEKOFYEAR(string date)
    -----------------------

    La función WEEKOFYEAR devuelve el numero de semana de la fecha.

    SELECT WEEKOFYEAR('2000-03-01 10:20:30')

    Y obtenemos: 9 

    ------------------------------------------------------------------------------------------------------------------------

    DATEDIFF(string date1, string date2)
    ------------------------------------

    La función DATEDIFF devuelve el número de días entre las dos fechas dadas.

    SELECT DATEDIFF('2000-03-01', '2000-01-10')

    Y obtenemos: 51     

    ------------------------------------------------------------------------------------------------------------------------

    DATE_ADD(string date, int days)
    -------------------------------

    La función DATE_ADD añade el número de días a la fecha especificada.

    SELECT DATE_ADD('2000-03-01', 5)

    Y obtenemos: '2000-03-06'       

    ------------------------------------------------------------------------------------------------------------------------

    DATE_SUB(string date, int days)
    -------------------------------

    La función DATE_SUB resta el número de días hasta la fecha especificada.

    SELECT DATE_SUB('2000-03-01', 5)

    Y obtenemos: '2000-02-25' 

    ------------------------------------------------------------------------------------------------------------------------       