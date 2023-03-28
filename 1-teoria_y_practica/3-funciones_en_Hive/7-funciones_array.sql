/*  FUNCIONES ARRAY
    ===============

    EXPLODE
    -------

    Toma un array como entrada y muestra los elementos del array como filas separadas.

    Tenemos la siguiente tabla:

    SELECT * FROM tabla2;

                                            col1        col2

                                            A           [1, 2, 5]
                                            B           [9, 2, 6]
                                            C           [7]
                                            D           [6, 9]
                                            E           [0, 3]


    En realidad, la limitación de la función explode es que sólo podemos seleccionar la columna a explotar en 
    nuestra sentencia SELECT, no podemos seleccionar otras columnas de la tabla junto con la columna explotada. 
    Por ejemplo, en el caso anterior, sólo puedo utilizar la columna 2 en la sentencia SELECT, y no puedo 
    seleccionar ambas, la columna 1 y la columna 2. Si intento utilizar ambas columnas en la sentencia SELECT, 
    me daría un error.


    SELECT EXPLODE(col2) AS myCol FROM tabla2;

                                            myCol

                                            1
                                            2
                                            5
                                            9
                                            2
                                            6
                                            7
                                            6
                                            9
                                            0
                                            3

    ------------------------------------------------------------------------------------------------------------------------

    LATERAL VIEW
    ------------                                            

    La función LATERAL VIEW si nos permite seleccionar otras columnas, aparte de la columna explotada.

    Tomando la misma tabla:

    SELECT * FROM tabla2;

                                            col1        col2

                                            A           [1, 2, 5]
                                            B           [9, 2, 6]
                                            C           [7]
                                            D           [6, 9]
                                            E           [0, 3]

    SELECT col1, myCol FROM tabla2 LATERAL VIEW EXPLODE(col2) col_virtual AS myCol;

                                            col1    myCol

                                            A       1
                                            A       2
                                            A       5
                                            B       9
                                            B       2
                                            B       6
                                            C       7
                                            D       6
                                            D       9
                                            E       0
                                            E       3


    Otro ejemplo:
    -------------

    Tenemos la tabla "tblArray":

        SELECT * FROM tblArray;

                                    author_name         books_name

                                    Salman Rushide      [Grimus, Shame, Fury]
                                    Thomas Otway        [Don Carlos, The Orphan]
                                    Ben Jonson          [Volpone, Epicene]
                                    John Milton         [Arcades, Comus]


        SELECT author_name, nombre_libros FROM tblArray LATERAL VIEW EXPLODE(books_name) col_virtual AS nombre_libros;
    
                                            author_name         nombre_libros

                                            Salman Rushide      Grimus
                                            Salman Rushide      Shame
                                            Salman Rushide      Fury
                                            Thomas Otway        Don Carlos
                                            Thomas Otway        The Orphan
                                            Ben Jonson          Volpone
                                            Ben Jonson          Epicene
                                            John Milton         Arcades
                                            John Milton         Comus    

    ------------------------------------------------------------------------------------------------------------------------                                              