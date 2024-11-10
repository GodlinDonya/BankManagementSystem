--Tasks 1: Database Design: 
/*1. Create the database named "HMBank"
2. Define the schema for the Customers, Accounts, and Transactions tables based on the 
provided schema.
4. Create an ERD (Entity Relationship Diagram) for the database.
5. Create appropriate Primary Key and Foreign Key constraints for referential integrity.
6. Write SQL scripts to create the mentioned tables with appropriate data types, constraints, 
and relationships. 
• Customers
• Accounts
• Transaction*/
--creating a database 
create database HMBank
--navigating to the database
use HMBank
--creating tables
create table Customers(
customer_id int primary key,
first_name varchar(20) not null,
last_name varchar(20) not null,
DOB date,
email varchar(30) not null,
phone_number varchar(15),
address text
)
create table Accounts(
account_id int primary key,
customer_id int,
account_type varchar(20),
balance int,
foreign key (customer_id) references Customers(customer_id)
)
create table Transactions(
transaction_id int primary key,
account_id int,
transaction_type varchar(20),
amount int,
transaction_date date,
foreign key (account_id) references Accounts(account_id)
)



alter table accounts
drop constraint FK__Accounts__custom__3A81B327
alter table accounts
add constraint FK_Accounts_customerid
foreign key (customer_id) references customers(customer_id) on delete cascade

--Tasks 2: Select, Where, Between, AND, LIKE
/*1. Insert at least 10 sample records into each of the following tables. 
• Customers
• Accounts
• Transactions*/

insert into Customers values(1,'kathir','kumar','2000-09-22','kathir@gmail.com','123456','123 good street,bangalore'),
(2,'john','peter','2002-08-22','john@gmail.com','222333','456 oak street,bangalore'),
(3,'george','duke','1999-10-12','george@gmail.com','333444','178 john street,chennai'),
(4,'henry','mathew','1995-10-11','henry@gmail.com','444555','321 paul street,bangalore'),
(5,'bobby','brown','1990-09-10','bobby@gmail.com','555666','234 nehru street,bangalore'),
(6,'alice','brown','1988-10-09','alice@gmail.com','666777','345 court road,bangalore'),
(7,'grace','sofia','1980-09-08','grace@gmail.com','777888','678 book street,coimbatore'),
(8,'david','miller','1977-01-01','david@gmail.com','999111','910 pine street,chennai'),
(9,'john','doe','1975-12-25','johndoe@gmail.com','111222','019 paper street,bangalore'),
(10,'john','carlson','2015-05-22','carlson@gmail.com','777222','432 pillow street,bangalore')
insert into Customers values(11,'gracia','mercy','2017-06-15','gracia@gmail.com','333777','332 cloud street,chennai')
insert into accounts values
(1, 1, 'savings', 5000),
(2, 2, 'current', 3000),
(3, 3, 'savings', 7500),
(4, 4, 'current', 1200),
(5, 5, 'current', 6000),
(6, 6, 'savings', 3500),
(7, 7, 'current', 2000),
(8, 8, 'savings', 8000),
(9, 9, 'zero_balance', 1000),
(10, 10, 'savings', 0)
insert into accounts values(10, 10, 'savings', 0)
insert into accounts values(12, 10, 'savings', 500)
insert into Accounts values (21,6,'savings',6000)
insert into transactions values
(1, 1, 'deposit', 500, '2024-01-10'),
(2, 2, 'withdrawal', 300, '2024-01-15'),
(3, 3, 'deposit', 1200, '2024-01-20'),
(4, 4, 'transfer', 150, '2024-01-25'),
(5, 5, 'deposit', 600, '2024-01-30'),
(6, 6, 'withdrawal', 200, '2024-02-05'),
(7, 7, 'transfer', 800, '2024-02-10'),
(8, 8, 'withdrawal', 400, '2024-02-15'),
(9, 9, 'deposit', 300, '2024-02-20'),
(10, 10, 'withdrawal', 250, '2024-02-25')

insert into transactions values
(11, 1, 'deposit', 1500, '2024-01-10')
insert into transactions values
(12, 1, 'deposit', 1500, '2024-01-10')
insert into transactions values
(13, 1, 'deposit', 1500, GETDATE())


--2. Write SQL queries for the following tasks:

--1. Write a SQL query to retrieve the name, account type and email of all customers. 

select distinct CONCAT_WS(' ',c.first_name,c.last_name),a.account_type,c.email
from Customers c
join Accounts a
on c.customer_id=a.customer_id

--2. Write a SQL query to list all transaction corresponding customer.
select CONCAT_WS(' ',c.first_name,c.last_name) as [Customer Name],t.transaction_id,t.transaction_type,t.transaction_date
from transactions t
join accounts a
on a.account_id=t.account_id
join customers c
on c.customer_id=a.customer_id

--3. Write a SQL query to increase the balance of a specific account by a certain amount.
update accounts
set balance=balance+10
where account_id=2

--4. Write a SQL query to Combine first and last names of customers as a full_name.
select first_name+' '+last_name full_name
from Customers

 --5. Write a SQL query to remove accounts with a balance of zero where the account type is savings.
 delete from Accounts
 where balance=0 and account_type ='savings'
 --select*from Accounts
 --select*from Transactions

 --6. Write a SQL query to Find customers living in a specific city.
select concat_ws(' ',first_name,last_name) as [Customer Name],address
from Customers
where address like '%bangalore%'

--7. write a SQL query to Get the account balance for a specific account.
select balance from Accounts
where account_id = 3

--8. Write a SQL query to List all current accounts with a balance greater than $1,000.
select * from accounts
where account_type='current' and balance > 1000

--9. Write a SQL query to Retrieve all transactions for a specific account.
select * from transactions
where amount=600

--10. Write a SQL query to Calculate the interest accrued on savings accounts based on a given interest rate.
select account_id,balance,balance*(30.0/100) interest_accrued
from Accounts
where account_type='savings'

 --11. Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit.
 select * from accounts
 where balance<500

 --12. Write a SQL query to Find customers not living in a specific city.
 select * from customers 
 where address not like '%chennai'

 --Tasks 3: Aggregate functions, Having, Order By, GroupBy and Joins:

--1. Write a SQL query to Find the average account balance for all customer
select customer_id,avg(balance) as avg_balance
from Accounts
group by customer_id

--2. Write a SQL query to Retrieve the top 10 highest account balances.
select top 10 balance
from Accounts
order by balance desc

--3. Write a SQL query to Calculate Total Deposits for All Customers in specific date.
select sum(t.amount) as tot_deposits
from transactions t
where t.transaction_date='2024-01-10' and t.transaction_type='deposit'

--4. Write a SQL query to Find the Oldest and Newest Customers.
select * 
from (
select top 1 customer_id,first_name,last_name,dob
from customers
order by dob asc  
) as oldestcustomer
union all
 select * 
from (
select top 1 customer_id,first_name,last_name, dob
from customers
order by dob desc  
) as newestcustomer

--5. Write a SQL query to Retrieve transaction details along with the account type.
select t.transaction_id,t.transaction_type,t.amount,t.transaction_date,a.account_type
from Transactions t
join accounts a
on a.account_id=t.account_id

--6. Write a SQL query to Get a list of customers along with their account details.
select CONCAT_WS(' ',c.first_name,c.last_name) as [Customer names],a.account_id,a.account_type
from Customers c
join Accounts a
on a.customer_id=c.customer_id

--7. Write a SQL query to Retrieve transaction details along with customer information for a specific account.
select c.customer_id,CONCAT_WS(' ',c.first_name,c.last_name) as [name],c.DOB,c.email,t.transaction_id,t.transaction_type,t.transaction_date
from Customers c
join Accounts a
on a.customer_id=c.customer_id
join Transactions t
on t.account_id=a.account_id
where a.account_id=1

--8. Write a SQL query to Identify customers who have more than one account
select customer_id,count(account_id) as [count]
from Accounts
group by customer_id 
having count(account_id) > 1

--9. Write a SQL query to Calculate the difference in transaction amounts between deposits and withdrawals.
select
(select sum(amount) from transactions where transaction_type = 'deposit') -
(select sum(amount) from transactions where transaction_type = 'withdrawal') 
as [difference]

--10 Write a SQL query to Calculate the average daily balance for each account over a specified period.
select a.account_id,AVG(a.balance) as [average balance]
from accounts a
join Transactions t
on t.account_id=a.account_id
where t.transaction_date between '10-01-24' and '08-11-2024'
group by a.account_id

--11. Calculate the total balance for each account type
select account_type, sum(balance) as tot_balance
from Accounts
group by account_type

--12. Identify accounts with the highest number of transactions order by descending order.
select a.account_id,count(t.transaction_id) as [no.of.transactions]
from Accounts a
join Transactions t
on a.account_id=t.account_id
group by a.account_id
order by count(transaction_id) desc

--13. List customers with high aggregate account balances, along with their account types.
select concat_ws(' ',c.first_name,c.last_name) as [Cutomer Name],a.account_type,sum(a.balance) as [Total Balance]
from accounts a
join Customers c
on c.customer_id=a.customer_id
group by a.account_type,c.first_name,c.last_name
having SUM(a.balance)>5000
order by sum(a.balance) desc

--14. Identify and list duplicate transactions based on transaction amount, date, and account.
select account_id,amount,transaction_date
from transactions
group by account_id,amount,transaction_date
having count(*)>1

--Tasks 4: Subquery and its type:
--1. Retrieve the customer(s) with the highest account balance
select concat_ws(' ', first_name, last_name) as customername
from customers
where customer_id in (
select customer_id
from accounts
where balance = (
select max(balance)
from accounts
)
)

--2. Calculate the average account balance for customers who have more than one account.
select avg(balance) as average_balance
from accounts 
where customer_id in (
select customer_id
from accounts
group by customer_id
having count(account_id) > 1
)

--3. Retrieve accounts with transactions whose amounts exceed the average transaction amount.
select account_id, transaction_id, amount
from transactions
where amount > (
select avg(amount)
from transactions
)
--4. Identify customers who have no recorded transactions.
select customer_id, concat_ws(' ',first_name, last_name) as [Customer Names]
from customers
where customer_id not in (
 select distinct customer_id
 from accounts
 where account_id in (
 select distinct account_id
 from transactions
 ))
--5. Calculate the total balance of accounts with no recorded transactions.
select sum(balance) as totalbalance
from accounts where 
account_id not in
(select account_id 
from Transactions)

--6. Retrieve transactions for accounts with the lowest balance.
select * from Transactions
where account_id in
(select account_id 
from Accounts
where balance in
(select min(balance)
from Accounts )
)

--7. Identify customers who have accounts of multiple types.
select concat_ws(' ',first_name,last_name) as [customer names]
from customers
where customer_id in
(select customer_id
from Accounts
group by customer_id
having count(account_type)>1)


--8. Calculate the percentage of each account type out of the total number of accounts.
select account_type,(count(account_type)*100.0)/(select count(*) from Accounts) as [percentage]
from Accounts
group by account_type

--9. Retrieve all transactions for a customer with a given customer_id.
select * from Transactions
where account_id in
(select account_id 
from Accounts
where customer_id=1)

--10. Calculate the total balance for each account type, including a subquery within the SELECT clause.
select account_type,(select sum(balance) as total 
from accounts a
where a.account_type = b.account_type
)as totalbalance
from Accounts b
group by account_type



