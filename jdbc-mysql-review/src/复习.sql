SELECT employee_id, salary "月工资", salary * (1 + IFNULL(commission_pct, 0)) * 12 "年工资", commission_pct
FROM `employees`;

SELECT employee_id, first_name, salary * 12 AS "ANNUAL SALARY", commission_pct
FROM `employees`;

SELECT employee_id, first_name, salary * 12 * (1 + IFNULL(commission_pct, 0)) AS "ANNUAL SALARY", commission_pct
FROM employees;

SELECT DISTINCT job_id
FROM employees;

SELECT last_name, first_name, salary
FROM employees
WHERE salary > 12000;

SELECT first_name, department_id
FROM employees
WHERE employee_id = 176;

DESC departments;

SELECT * FROM departments;

SELECT 1 <=> NULL, NULL <=> NULL;

SELECT LEAST('g','b','t','m','f'), GREATEST('g','b','t','m','f');


SELECT first_name, salary
FROM employees
WHERE salary < 5000 OR salary > 12000;

SELECT first_name, department_id
FROM employees
WHERE department_id IN (20, 50);
# where department_id = 20 or department_id = 50;


SELECT first_name, job_id
FROM employees
WHERE manager_id IS NULL;
# where manager_id <=> null;

SELECT first_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;
# where not commission_pct <=> null;

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '__a%';


SELECT last_name
FROM employees 
WHERE last_name LIKE '%a%k%' OR last_name LIKE '%k%a%';

SELECT first_name
FROM employees
WHERE first_name LIKE '%e';
# where first_name regexp 'e$';

SELECT last_name, job_id 
FROM employees
WHERE department_id BETWEEN 80 AND 100;

SELECT last_name, salary, manager_id
FROM employees
WHERE manager_id IN (100, 101, 110);


SELECT last_name, department_id, salary * 12 annual_salary
FROM employees
ORDER BY annual_salary DESC, last_name ASC;

SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 8000 AND 17000
ORDER BY salary DESC
LIMIT 20 OFFSET 20;
# limit 20, 20

SELECT employee_id, last_name, email, department_id
FROM employees
WHERE email REGEXP '[e]'
ORDER BY LENGTH(email) DESC, department_id ASC; 


SELECT emp.last_name, emp.department_id, depart.department_name
FROM employees emp LEFT JOIN departments depart
ON emp.department_id = depart.department_id;


SELECT e.job_id, d.location_id
FROM employees e JOIN departments d
ON e.department_id = d.department_id
WHERE e.department_id = 90;


SELECT e.last_name, d.department_name, d.location_id, city
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
LEFT JOIN locations l
ON d.location_id = l.location_id
WHERE e.commission_pct IS NOT NULL;


SELECT e.last_name, e.job_id, e.department_id, d.department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id
WHERE l.city = 'Toronto';


SELECT d.department_name, l.street_address, e.last_name, e.job_id, e.salary
FROM employees e JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id
WHERE d.department_name = 'Executive';


SELECT e1.last_name, e1.employee_id, e2.last_name man_name, e2.employee_id man_id
FROM employees e1 LEFT JOIN employees e2 
ON e1.manager_id = e2.employee_id;

SELECT d.department_id 
FROM departments d LEFT JOIN employees e
ON d.department_id = e.department_id
WHERE e.department_id IS NULL;



SELECT l.city
FROM locations l LEFT JOIN departments d
ON l.location_id = d.location_id
WHERE d.location_id IS NULL;


SELECT e.employee_id, e.last_name, e.department_id
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_name IN ('Sales', 'IT');




SELECT MAX(salary) max_sal, MIN(salary) min_sal, AVG(salary) avg_sal, SUM(salary) sum_sal
FROM employees;

SELECT job_id, MAX(salary) max_sal, MIN(salary) min_sal, AVG(salary) avg_sal, SUM(salary) sum_sal
FROM employees
GROUP BY job_id;

SELECT job_id, COUNT(*)
FROM employees
GROUP BY job_id;

SELECT MAX(salary) - MIN(salary) AS diff
FROM employees;

SELECT manager_id, MIN(salary) 
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary) >= 6000;


SELECT d.department_name, d.location_id, COUNT(employee_id), AVG(e.salary)
FROM departments d LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_name, location_id;

SELECT d.department_name, je.ob_id, MIN(salary)
FROM departments d LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY department, job_id;



SELECT employee_id, last_name, email
FROM employees
WHERE salary > (
		SELECT salary
		FROM employees
		WHERE employee_id = 149
);

SELECT last_name, job_id, salary
FROM employees
WHERE job_id = (
		SELECT job_id
		FROM employees
		WHERE employee_id = 141
		)
	AND salary > (SELECT salary 
			FROM employees
			WHERE employee_id = 143);


SELECT last_name, job_id, salary
FROM employees
WHERE salary = (SELECT MIN(salary)
		FROM employees);
	
	
SELECT employee_id, manager_id, department_id
FROM employees
WHERE manager_id = (SELECT manager_id FROM employees WHERE employee_id = 141)
AND department_id = (SELECT department_id FROM employees WHERE employee_id = 141)
AND employee_id <> 141;


SELECT department_id, MIN(salary)
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
HAVING MIN(salary) > (SELECT MIN(salary) FROM employees WHERE department_id = 110)


SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE job_id <> 'IT_PROG'
AND salary < ANY(
	SELECT salary FROM employees
	WHERE job_id  = 'IT_PROG' );
	
	

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE job_id <> 'IT_PROG'
AND salary < ALL(
	SELECT salary FROM employees
	WHERE job_id  = 'IT_PROG' );


SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
HAVING AVG(salary) <= ALL(
		SELECT AVG(salary) 
		FROM employees
		GROUP BY department_id);
		
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
HAVING AVG(salary) = (SELECT MIN(avg_sal)
		      FROM (
			SELECT AVG(salary) avg_sal
			FROM employees
			GROUP BY department_id
			) t_dept_avg_sal	 
		); 
		
		
SELECT e1.last_name, e1.salary, e1.department_id
FROM employees e1
WHERE salary > (SELECT AVG(e2.salary)
		FROM employees e2
		WHERE e1.department_id = e2.department_id
		GROUP BY department_id
		)
		
SELECT e1.employee_id, e1.salary,
FROM employees e1
ORDER BY (SELECT d.department_name
	  FROM departments d
	  WHERE d.department_id = e1.department_id) ASC;
		





























# 1.返回job_id与141号员工相同，salary比143号员工多的员工姓名，job_id和工资
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = (SELECT job_id FROM employees WHERE employee_id = 141)
AND salary >(SELECT salary FROM employees WHERE employee_id = 143)

# 2.返回公司工资最少的员工的 last_name,job_id 和salary
SELECT last_name, job_id, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees)

# 3.查询与141号或174号员工的manager_id和department_id相同的其他员工的employee_id，manager_id
SELECT employee_id, manager_id
FROM employees
WHERE (manager_id, department_id) IN (SELECT manager_id, department_id FROM employees WHERE employee_id IN (141, 174))
AND employee_id NOT IN (141, 174)

# 4.查询最低工资大于50号部门最低工资的部门id和其最低工资
SELECT department_id, MIN(salary)
FROM employees 
GROUP BY department_id
HAVING MIN(salary) > (SELECT MIN(salary) FROM employees WHERE department_id = 50)


# 5.返回其它job_id中比job_id为‘IT_PROG’部门任一工资低的员工的员工号、姓名、job_id 以及salary
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE job_id <> 'IT_PROG'
AND salary < ANY(SELECT salary FROM employees WHERE job_id <=> 'IT_PROG')


# 6.查询平均工资最低的部门id
SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
HAVING AVG(salary) = (
		SELECT MIN(avg_sal)
		FROM (SELECT AVG(salary) avg_sal FROM employees GROUP BY department_id) t_avg_sal
		);
		   
# 7.查询员工中工资大于本部门平均工资的员工的last_name,salary和其department_id
SELECT e1.last_name, e1.salary, e1.department_id
FROM employees e1
WHERE salary > (SELECT AVG(salary) FROM employees e2 WHERE e1.department_id = e2.department_id)

# 8.查询员工的id,salary,按照department_name 排序
SELECT e.employee_id, e.salary, d.department_name
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY d.department_name;

# 9.若employees表中employee_id与job_history表中employee_id相同的数目不小于2，输出这些相同id的员工的employee_id,last_name和其job_id
SELECT e.employee_id, e.last_name, e.job_id
FROM employees e LEFT JOIN job_history j
ON e.employee_id = j.employee_id
WHERE COUNT()

SELECT e.employee_id, e.last_name, e.job_id
FROM employees e
WHERE 2 <= (SELECT COUNT(*) FROM job_history j WHERE e.employee_id = j.employee_id)

# 10.查询公司管理者的employee_id，last_name，job_id，department_id信息
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE employee_id IN (SELECT manager_id FROM employees)

SELECT e.employee_id, e.last_name, e.job_id, e.department_id
FROM employees e
WHERE EXISTS(SELECT * FROM employees e1 WHERE e.employee_id = e1.manager_id)
	
# 11.查询departments表中，不存在于employees表中的部门的department_id和department_name
SELECT d.department_id, d.department_name
FROM departments d
WHERE d.department_id NOT IN (SELECT department_id FROM employees WHERE department_id IS NOT NULL)
# 由于有 null 值的出现导致了空值问题

# 12.在employees中增加一个department_name字段，数据为员工对应的部门名称









#1.查询和Zlotkey相同部门的员工姓名和工资
SELECT last_name, salary
FROM employees
WHERE department_id = (SELECT department_id FROM employees WHERE last_name = 'Zlotkey')


#2.查询工资比公司平均工资高的员工的员工号，姓名和工资。
SELECT employee_id, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)


#3.选择工资大于所有JOB_ID = 'SA_MAN'的员工的工资的员工的last_name, job_id, salary
SELECT last_name, job_id, salary
FROM employees
WHERE salary > ALL(SELECT salary FROM employees WHERE job_id = 'SA_MAN')


#4.查询和姓名中包含字母u的员工在相同部门的员工的员工号和姓名
SELECT employee_id, last_name
FROM employees
# where last_name like '%u%';
WHERE last_name REGEXP '[u]';



#5.查询在部门的location_id为1700的部门工作的员工的员工号
SELECT e.employee_id
FROM employees e LEFT JOIN departments d
ON e.department_id = d.department_id
WHERE d.location_id = 1700;

SELECT employee_id
FROM employees
WHERE department_id IN (SELECT department_id FROM departments WHERE location_id = 1700)

#6.查询管理者是King的员工姓名和工资
SELECT last_name, salary, manager_id
FROM employees
WHERE manager_id IN (SELECT employee_id FROM employees WHERE last_name = 'King')


#7.查询工资最低的员工信息: last_name, salary
SELECT last_name, salary
FROM employees
WHERE salary <= ALL(SELECT salary FROM employees)


#8.查询平均工资最低的部门信息
#方式1：聚合函数
SELECT * 
FROM departments 
WHERE department_id IN (# 平均工资最低的部门ID
			SELECT department_id FROM employees
			GROUP BY department_id
			HAVING AVG(salary) = (#平均工资等于最低工资
					SELECT MIN(avg_sal)
					FROM (SELECT AVG(salary) avg_sal 
					FROM employees GROUP BY department_id) t_avg_sal
					)
			)
#方式2：ALL
SELECT *
FROM departments
WHERE department_id = (
			SELECT department_id
			FROM employees
			GROUP BY department_id
			HAVING AVG(salary ) <= ALL(
						SELECT AVG(salary)
						FROM employees
						GROUP BY department_id
						)
			);
#方式3： LIMIT
SELECT *
FROM departments 
WHERE department_id IN (# 平均工资最低的部门ID
			SELECT department_id FROM employees
			GROUP BY department_id
			HAVING AVG(salary) = (#平均工资等于最低工资
					SELECT AVG(salary) avg_sal 
					FROM employees 
					GROUP BY department_id
					ORDER BY avg_sal ASC
					LIMIT 1 OFFSET 0
					)
			)

#方式4：
SELECT d.*
FROM departments d, (
		  SELECT e.department_id, AVG(salary) avg_sal
		  FROM employees e
		  GROUP BY e.department_id
		  ORDER BY avg_sal ASC
		  LIMIT 1 OFFSET 0
		  # 这样的话筛选的就是最低工资的那个部门的 ID 和平均最低工资
) t_tab_avg_sal
WHERE d.department_id = t_tab_avg_sal.department_id;
	
		
#9.查询平均工资最低的部门信息和该部门的平均工资（相关子查询）
#方式1：
SELECT d.*, (SELECT AVG(salary) FROM employees e WHERE e.department_id = d.department_id) avg_sal
FROM departments d
WHERE department_id IN (# 平均工资最低的部门ID
			SELECT department_id FROM employees
			GROUP BY department_id
			HAVING AVG(salary) = (#平均工资等于最低工资
					SELECT MIN(avg_sal)
					FROM (SELECT AVG(salary) avg_sal 
					FROM employees GROUP BY department_id) t_avg_sal
					)
			)

#方式2：

#方式3： LIMIT

#方式4：


#10.查询平均工资最高的 job 信息

#方式1：
SELECT * 
FROM jobs 
WHERE job_id IN (SELECT job_id 
		 FROM employees 
		 GROUP BY job_id
		 HAVING AVG(salary) >= ALL(
				       SELECT AVG(salary) 
				       FROM employees 
				       GROUP BY job_id) )
#方式2：
SELECT * 
FROM jobs 
WHERE job_id IN (SELECT job_id 
		 FROM employees 
		 GROUP BY job_id
		 HAVING AVG(salary) = (
				      SELECT MAX(avg_sal)
				      FROM (SELECT AVG(salary) avg_sal
					    FROM employees 
					    GROUP BY job_id
					   )t_tab_avg_sal
				       )
		)
#方式3：

#方式4：
		
#11.查询平均工资高于公司平均工资的部门 id 有哪些?
SELECT department_id
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
HAVING AVG(salary) > (SELECT AVG(salary) FROM employees )


#12.查询出公司中所有 manager 的详细信息

#方式1：自连接  xxx worked for yyy
SELECT DISTINCT e1.employee_id, e1.last_name, e1.job_id, e1.department_id
FROM employees e1 LEFT JOIN employees e2
ON e1.employee_id = e2.manager_id;

#方式2：子查询
SELECT e1.employee_id, e1.last_name, e1.job_id, e1.department_id
FROM employees e1
WHERE e1.employee_id IN (SELECT manager_id FROM employees)

#方式3：使用EXISTS
SELECT e1.employee_id, e1.last_name, e1.job_id, e1.department_id
FROM employees e1
WHERE EXISTS (SELECT * FROM employees e2 WHERE e1.employee_id = e2.manager_id) 

#13.各个部门中 最高工资中最低 的那个部门的 最低工资是多少?

#方式1：
SELECT MIN(salary)
FROM employees
GROUP BY department_id
HAVING department_id = (# 最高工资最低的部门ID
			SELECT department_id
			FROM employees
			GROUP BY department_id
			HAVING MAX(salary) = (SELECT MIN(max_sal)
				              FROM (SELECT MAX(salary) max_sal
				              FROM employees 
				              GROUP BY department_id) t_max_sal
					)
		)

#方式2：
SELECT MIN(salary)
FROM employees
GROUP BY department_id
HAVING department_id = (# 最高工资最低的部门ID
			SELECT department_id
			FROM employees
			GROUP BY department_id
			HAVING MAX(salary) <= ALL (SELECT MAX(salary) max_sal
				              FROM employees 
				              GROUP BY department_id
					)
		)
#方式3：
SELECT MIN(salary)
FROM employees
GROUP BY department_id
HAVING department_id = (# 最高工资最低的部门ID
			SELECT department_id
			FROM employees
			GROUP BY department_id
			HAVING MAX(salary) = (SELECT MAX(salary) max_sal 
				              FROM employees 
				              GROUP BY department_id
				              ORDER BY max_sal ASC
				              LIMIT 1 OFFSET 0
					)
		)
#方式4：
SELECT MIN(salary)
FROM employees e, (# 获得最高工资最低的部门 ID 和其最高工资
		   SELECT department_id, MAX(salary) max_sal
		   FROM employees 
		   GROUP BY department_id
		   ORDER BY max_sal ASC 
		   LIMIT 1 OFFSET 0) t_max_sal
WHERE e.department_id = t_max_sal.department_id;


#14.查询平均工资最高的部门的 manager 的详细信息: last_name, department_id, email, salary
#方式1：
SELECT last_name, department_id, email, salary
FROM employees 
WHERE employee_id = (# 查询该部门的管理者的 ID
		    SELECT manager_id
		    FROM departments
		    WHERE department_id = (# 平均工资最高的部门
					SELECT department_id
					FROM employees
					GROUP BY department_id
					HAVING AVG(salary) = (SELECT MAX(avg_sal)
							      FROM (SELECT AVG(salary) avg_sal FROM employees
							      GROUP BY department_id) t_avg_sal
							)
					)
		)

#方式2：


#方式3：



#15. 查询部门的部门号，其中不包括job_id是"ST_CLERK"的部门号
#方式1：
SELECT department_id
FROM departments
WHERE department_id NOT IN (
			SELECT department_id FROM employees 
			WHERE job_id = 'ST_CLERK'
			AND department_id IS NOT NULL
			)

#方式2：
SELECT d.department_id
FROM departments d
WHERE NOT EXISTS(SELECT e.department_id FROM employees e
		 WHERE job_id = 'ST_CLERK'
	         AND d.department_id <=> e.department_id
		 )



#16. 选择所有没有管理者的员工的last_name
SELECT last_name, manager_id
FROM employees
WHERE manager_id IS NULL;


#17．查询工号、姓名、雇用时间、工资，其中员工的管理者为 'De Haan'
#方式1：
SELECT employee_id,last_name,hire_date,salary
FROM employees
WHERE manager_id = (SELECT employee_id
		FROM employees
		WHERE last_name = 'De Haan' )

#方式2：



#18.查询各部门中工资比本部门平均工资高的员工的员工号, 姓名和工资（相关子查询）

#方式1：使用相关子查询
SELECT e1.employee_id, e1.last_name, e1.salary
FROM employees e1
WHERE e1.department_id IS NOT NULL
AND e1.salary > (SELECT AVG(salary) 
		 FROM employees e2
		 WHERE e1.department_id = e2.department_id 
		 GROUP BY department_id
		)

#方式2：在FROM中声明子查询
SELECT e1.employee_id, e1.last_name, e1.salary
FROM employees e1, (SELECT department_id, AVG(salary) avg_sal
		    FROM employees e2 
		    GROUP BY department_id
		   ) t_avg_sal
WHERE e1.salary > t_avg_sal.avg_sal
AND e1.department_id = t_avg_sal.department_id;


#19.查询每个部门下的部门人数大于 5 的部门名称（相关子查询）
SELECT department_name
FROM departments d
WHERE 5 < (
	   SELECT COUNT(*)
	   FROM employees e
	   WHERE d.department_id = e.`department_id`
	  );


#20.查询每个国家下的部门个数大于 2 的国家编号（相关子查询）

SELECT * FROM locations;

SELECT country_id
FROM locations l
WHERE 2 < (
	   SELECT COUNT(*)
	   FROM departments d
	   WHERE l.`location_id` = d.`location_id`
	 );

























