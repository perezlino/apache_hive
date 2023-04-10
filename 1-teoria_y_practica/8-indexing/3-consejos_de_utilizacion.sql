/*  CONSEJOS DE UTILIZACION
    =======================

    Indexar es útil para obtener consultas más rápido, pero no debemos usarlo en todos los casos, porque en diferentes 
    escenarios puede ser desventajoso también. A este respecto, ahora discutiremos cuándo usar indexación y cuándo no. 

    En primer lugar, cuándo utilizarla: 
    -----------------------------------

    Podemos utilizar la indexación siempre que el conjunto de datos sea muy grande, es decir, que el conjunto de datos 
    sea de gigabytes o más... En segundo lugar, si se trata de velocidad en la ejecución de la consulta; cuando la 
    latencia importa. En tercer lugar, la indexación puede utilizarse cuando la consulta se basa en el uso frecuente de 
    la cláusula WHERE en la sentencia select. 

    Por el contrario, no deberíamos usar indexación:
    ------------------------------------------------

    Cuando el conjunto de datos es pequeño, ya que la creación de índices requiere mucho tiempo y la creación de un mayor 
    número de índices también puede reducir el rendimiento de la consulta. En segundo lugar, no debemos utilizar indexación 
    cuando el conjunto de datos esté formado por filas casi únicas, porque en ese caso habrá muchos ID de índice para cada 
    valor de columna. 

    Para terminar, el tipo de index a crear debe ser identificado antes de su creación. Debemos crear índices analizando 
    nuestros datos. Si nuestros datos requieren un índice bitmap, entonces crear un índice bitmap. Si requiere un índice 
    compacto, cree un índice compact.
