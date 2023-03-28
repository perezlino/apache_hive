/*  FUNCION RLIKE
    =============

    RLIKE
    -----

    RLIKE es la abreviatura de "Right like". RLIKE es una función especial en Hive, donde si cualquier subcadena 
    de A coincide con B, entonces se evalúa como verdadero. Normalmente, al buscar una subcadena, ponemos un 
    símbolo "%" antes o después de la subcadena. Pero aquí en RLIKE, los usuarios no necesitan poner el símbolo % 
    para una simple coincidencia. Y esta es la sintaxis:
    
    
                                            SELECT 'hadoop' RLIKE 'ha';
     
     
     Supongamos que esta es mi cadena principal ("hadoop") y esta es la función RLIKE, y esta es la subcadena ("ha"). 
     Esta función hará coincidir la subcadena "ha" con la cadena completa, y si encuentra esta subcadena en cualquier 
     parte de la cadena completa, devuelve "true".

     
    Otros ejemplos:

    SELECT 'hadoop' RLIKE 'ha*'; ------> true


    RLIKE será útil cuando la cadena tenga algunos espacios. Generalmente, si una cadena contiene espacios, primero 
    recortamos esos espacios usando el comando TRIM y luego hacemos coincidir la cadena. Pero la función RLIKE no necesita 
    ningún recorte. Como en este ejemplo,

    SELECT 'hadoop        ' RLIKE 'hadoop'; ------> true

    ------------------------------------------------------------------------------------------------------------------------