use bank_cc3mc;

/* exibir coluna */
show columns from account;

/* exibir OPEN_EMP_IDS */
select distinct open_emp_id
from account;


/* mostrar tabela Iname, fname, name  */
SELECT fname, lname, name
FROM officer, business
WHERE officer.cust_id = business.cust_id; 

/* pesquisar a avail_balance do usuario com o id */
select account_id, cust_id, avail_balance
from account
where status = 'active'
and avail_balance > 2500;


/* esta com algul erro */
/* recuperar id da conta, cidade, primeiro nome e sobrenome do cliente 
select account_id, concat(fname, '', lname)nome, city, accouont.cust_id, avail_balance
from account, custumer, individual
where status = 'active' and avail_balance > 2500
and account.cust_id = custumer.cust_id and custumer.cust_id = individual.cust_id;*/

/* nome do superior do employee */
select concat (fname, '', lname)nome 
from employee
where superior_emp_id is null;

/* retorna nomes e nomes dos departamentos dos empregados com superior   ERROR */
/*select concat (fname, '', lname) nome, name 
from employee, departament
where superior_emp_id is not null
and departament /* /*terminar codigo*/

/* liste os clientes com sobrenome que nao terminam com r ou y */
select lname
from individual
where lname not like '%r' or lname not like '%y';

/* data de posse do funcionario mais antigo para cada dept_id com o nome do funcionario */
SELECT employee.fname, employee.lname, datas.posse, employee.dept_id
FROM employee, 
     (SELECT dept_id, MIN(start_date) AS posse
      FROM employee
      GROUP BY dept_id) datas
WHERE employee.start_date = datas.posse
  AND employee.dept_id = datas.dept_id;
  
  /* cliente (individual) mais velho para cada cidade (custumer.city) */
  


