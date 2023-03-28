/*  FUNCIONES MAP
    =============

    LATERAL VIEW
    ------------ 
    
    Sirve para sacar las claves y los valores en columnas separadas de un map.
    
    Tenemos la tabla "tblMap":

        SELECT * FROM tblMap;

                                            col1        

                                            {"12":"abc"}
                                            {"34":"def"}      
                                            {"56":"ghi"}
                                            {"78":"jkl"}

        SELECT key, value FROM tblMap LATERAL VIEW EXPLODE(col1) col_virtual AS key,value;

                                            key    value

                                            12       abc
                                            34       def
                                            56       ghi
                                            78       jkl     

    ------------------------------------------------------------------------------------------------------------------------                                                                    