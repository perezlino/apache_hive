SELECT ${empid}, col2, col3, col4, col5 FROM emp_tab;
SELECT col1, col6 FROM ${hiveconf:tablename};
SELECT * FROM emp_tab WHERE col6 = ${deptno}