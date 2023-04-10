/*  MULTIPLES INDEXES EN UNA MISMA TABLA
    ====================================

    Ahora podría surgir una pregunta, ¿podemos tener diferentes indexes para la misma tabla? La respuesta es sí. 
    Podemos tener cualquier número de índices para una tabla en particular, y cualquier tipo de índices también. 
    Ya hemos creado una serie de índices compact en la tabla "data_tab". Ahora vamos a crear un bitmap index. 
    Ahora vamos a crear un bitmap index en la misma tabla:


                        CREATE INDEX i4 ON TABLE data_tab(col3) AS 'BITMAP' WITH deferred rebuild;      


    Ahora como te dije, la creación de nuestro index está incompleta sin este comando:
    

                                                ALTER INDEX I4 ON data_tab


    Podemos tener tantos índices compactos, y tantos índices de mapa de bits, en la misma tabla y en la misma columna. 
    También te mostraré cómo comprobar el número de índices, o cuántos índices se han creado para una tabla. Ahora para 
    comprobar los indices disponibles para la tabla data_tab, usamos este comando:


                                            SHOW FORMATTED INDEX ON data_tab;                                                 


    idx_name        tab_name        col_names       idx_tab_name                idx_type

    i1              data_tab        col3            default_data_tab_i1__       compact
    i2              data_tab        col3            default_data_tab_i1__       compact
    i3              data_tab        col3            default_data_tab_i1__       compact
    i4              data_tab        col3            default_data_tab_i1__       bitmap


    Se muestra que hemos creado tres indexes en la tabla de tipo compact, y un index I4 de tipo bitmap. Ahora veremos la 
    diferencia en el tiempo de obtención de resultados para ambos índices. Antes de eso, tengo que mencionar que, con 
    diferentes tipos de índices, como en compacto y mapa de bits, en las mismas columnas para la misma tabla, el índice que 
    se crea en primer lugar se toma como índice para esa tabla en las columnas especificadas. Dado que hemos creado primero 
    el índice compacto, nuestra siguiente consulta utilizará el índice compacto:


                            SELECT AVG(col1) AS avg FROM data_tab WHERE col3 = 'TP';                                            


    Ahora, esta consulta, utilizará compact index, porque en primer lugar, hemos creado compact index en la columna_3 de la 
    tabla "data_tab". Nos tomó 77 segundos.     

    Ahora, para tomar bitmap como nuestro índice de trabajo, vamos a eliminar los índices compactos. Para ello, utilizaré:


                                                DROP INDEX i1 ON data_tab                        


    Tambien eliminaremos los indices "i2" e "i3":


                                                DROP INDEX i2 ON data_tab     
                                                DROP INDEX i3 ON data_tab                                                         


    Comprobaré si sólo queda bitmap:

                                            SHOW FORMATTED INDEX ON data_tab;                                                 


    idx_name        tab_name        col_names       idx_tab_name                idx_type

    i4              data_tab        col3            default_data_tab_i1__       bitmap                                                    


    Esta vez usará el índice bitmap ya que hemos borrado todos los índices compactos:
    
    
                            SELECT AVG(col1) AS avg FROM data_tab WHERE col3 = 'TP';           
    
    
     Ya tenemos el resultado. Ahora para los indexados por mapa de bits hemos tardado casi 74 segundos. La diferencia no es 
     demasiada, porque aquí se trata de un conjunto de datos pequeño. Pero en tiempo real, donde nuestro conjunto de datos 
     está en GBs o más que eso, esta diferencia es considerable.