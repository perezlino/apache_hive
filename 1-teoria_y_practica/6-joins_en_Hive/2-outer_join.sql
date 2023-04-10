/*  OUTER JOIN
    ==========

    Mostremos ejemplos de como se utilizan.


    LEFT OUTER JOIN
    ---------------

    SELECT 
           emp_tab.col1, 
           emp_tab.col2, 
           emp_tab.col3, 
           dept_tab.col1, 
           dept_tab.col2, 
           dept_tab.col3 
    FROM 
           emp_tab 

    LEFT OUTER JOIN   
                    dept_tab 
    ON 
           (emp_tab.col6 = dept_tab.col1);  

    ------------------------------------------------------------------------------------------------------------------------

    RIGHT OUTER JOIN
    ----------------

    SELECT 
           emp_tab.col1, 
           emp_tab.col2, 
           emp_tab.col3, 
           dept_tab.col1, 
           dept_tab.col2, 
           dept_tab.col3 
    FROM 
           emp_tab 

    RIGHT OUTER JOIN   
                     dept_tab 
    ON 
           (emp_tab.col6 = dept_tab.col1);         

    ------------------------------------------------------------------------------------------------------------------------

    FULL OUTER JOIN
    ----------------

    SELECT 
           emp_tab.col1, 
           emp_tab.col2, 
           emp_tab.col3, 
           dept_tab.col1, 
           dept_tab.col2, 
           dept_tab.col3 
    FROM 
           emp_tab 

    FULL OUTER JOIN   
                    dept_tab 
    ON 
           (emp_tab.col6 = dept_tab.col1);      

    ------------------------------------------------------------------------------------------------------------------------                              