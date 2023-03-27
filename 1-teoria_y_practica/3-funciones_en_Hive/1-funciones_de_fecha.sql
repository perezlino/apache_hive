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