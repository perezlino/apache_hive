/*  FUNCIONES DE RANKING
    ====================

    Antes de empezar creamos la tabla y cargamos los datos:

    CREATE TABLE IF NOT EXISTS tblRank (
    col1 string,
    col2 int
    ) 
    ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
    LINES TERMINATED BY '\n'
    STORED AS TEXTFILE;

    LOAD DATA LOCAL INPATH '/home/alfonso/files/rankfunctions' OVERWRITE INTO TABLE tblRank;

    
    Consultamos los datos:

        SELECT * FROM tblRank;


    ------------------------------------------------------------------------------------------------------------------------

    RANK() OVER()
    -------------

    SELECT col1, col2, RANK() OVER(ORDER BY col2 DESC) AS ranking FROM tblRank;

                                                    col1         col2         ranking

                                                    John         1300         1
                                                    Lui          1300         1                                           
                                                    Albert       1200         3  
                                                    Frank        1150         4  
                                                    Loopa        1100         5  
                                                    Mark         1000         6  
                                                    fransis      1000         6                                             
                                                    Lesa         900          8  
                                                    John         900          8                                           
                                                    Pars         800          10  
                                                    John         700          11                                          
                                                    leo          700          11  
                                                    lock         650          13  
                                                                 NULL         14  

    ------------------------------------------------------------------------------------------------------------------------

    DENSE_RANK() OVER()
    -------------------

    SELECT col1, col2, DENSE_RANK() OVER(ORDER BY col2 DESC) AS ranking FROM tblRank;

                                                    col1         col2         ranking

                                                    John         1300         1
                                                    Lui          1300         1                                           
                                                    Albert       1200         2  
                                                    Frank        1150         3  
                                                    Loopa        1100         4  
                                                    Mark         1000         5  
                                                    fransis      1000         5                                             
                                                    Lesa         900          6  
                                                    John         900          6                                           
                                                    Pars         800          7  
                                                    John         700          8                                          
                                                    leo          700          8  
                                                    lock         650          9  
                                                                 NULL         10  

    ------------------------------------------------------------------------------------------------------------------------

    ROW_NUMBER() OVER()
    -------------------

    SELECT col1, col2, ROW_NUMBER() OVER(ORDER BY col2 DESC) AS ranking FROM tblRank;

                                                    col1         col2         ranking

                                                    John         1300         1
                                                    Lui          1300         2                                           
                                                    Albert       1200         3  
                                                    Frank        1150         4  
                                                    Loopa        1100         5  
                                                    Mark         1000         6  
                                                    fransis      1000         7                                             
                                                    Lesa         900          8  
                                                    John         900          9                                           
                                                    Pars         800          10  
                                                    John         700          11                                          
                                                    leo          700          12  
                                                    lock         650          13  
                                                                 NULL         14

    ROW_NUMBER() OVER(PARTITION())
    ------------------------------                                                                   

    SELECT col1, col2, ROW_NUMBER() OVER(PARTITION BY col1 ORDER BY col2 DESC) AS ranking FROM tblRank;

                                                    col1         col2         ranking

                                                                 NULL         1
                                                    Albert       1200         1 
                                                    Frank        1150         1                                                       
                                                    John         1300         1
                                                    John         900          2 
                                                    John         700          3                                                                                                              
                                                    Lesa         900          1                                                      
                                                    Lui          1300         1                                           
                                                    Loopa        1100         1  
                                                    Mark         1000         1                                                                         
                                                    Pars         800          1 
                                                    fransis      1000         1                                                                                                
                                                    leo          700          1  
                                                    lock         650          1  
                                                          
    ------------------------------------------------------------------------------------------------------------------------