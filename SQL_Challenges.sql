/*
The Marketing Manager asks you for a list of all customers.
With first name, last name and the customer's email address. */
select first_name, last_name, email from customer
/*
Write a SQL query to get the different prices!
Result
To make it easier for them order the prices from
high to low.*/
select distinct amount from payment order by amount desc

/* Create a list of all the distinct districts
customers are from.*/
select distinct district from address

--What is the latest rental date?
select rental_date from rental order by rental_date desc limit 1

--How many films does the company have?
select count(*) from film

/*How many distinct last names of the
customers are there?*/
select Distinct Count(last_name) from customer

/*You need to help the Marketing team to work more easily.
The Marketing Manager asks you to order the customer list
by the last name.
The want to start from "Z" and work towards "A".
Write a SQL query to get that list!
In case of the same last name the order should be based on
the first name – also from "Z" to "A".*/
select  first_name, last_name from customer order by last_name desc, first_name desc


/*How many payment were made by the customer
with customer_id = 100?
Write a SQL query to get the answers
Result
What is the last name of our customer with
first name 'ERICA'?*/
select Count(*) from payment where customer_id = 100
select last_name from customer where first_name = 'ERICA'

/*The inventory manager asks you how rentals have
not been returned yet (return_date is null).
Write a SQL query to get the answers!
Result
The sales manager asks you how for a list of all the
payment_ids with an amount less than or equal to $2.
Include payment_id and the amount.*/
select count(*) from rental where return_date is null
select payment_id, amount from payment where amount<= 2

/*The suppcity manager asks you about a list of all the payment of
the customer 322, 346 and 354 where the amount is either less
than $2 or greater than $10.
It should be ordered by the customer first (ascending) and then
as second condition order by amount in a descending order.*/
 select * from payment where customer_id in (322,346,354) and 
 (amount<2 or amount>10) order by customer_id asc, amount desc
 
 /*There have been 6 complaints of customers about their
payments.
Write a SQL query to get a list of the concerned payments!
Result
It should be 7 payments!
customer_id: 12,25,67,93,124,234
The concerned payments are all the payments of these
customers with amounts 4.99, 7.99 and 9.99 in January 2020.*/
select * from payment where customer_id in (12,25,67,93,124,234)
and amount in (4.99, 7.99, 9.99) and payment_date between '2020-01-01' and '2020-01-31 23:59'

/*There have been some faulty payments and you need to help to
found out how many payments have been affected.
How many payments have been made on January 26th and 27th
2020 (including entire 27th) with an amount between 1.99 and 3.99? */
select Count(*) from payment where payment_date
between '2020-01-26' and '2020-01-27 23:59'and  amount between 1.99 and 3.99

/*You need to help the inventory manager to find out:
How many movies are there that contain the "Documentary" in 
the description?*/
select count(*) from film where description like '%Documentary%'

/* How many customers are there with a first name that is
3 letters long and either an 'X' or a 'Y' as the last letter in the last
name?*/
 select count(*) from customer where length(first_name)<=3 
 (last_name like '%X' or last_name like '%Y')
 
 /*1.How many movies are there that contain 'Saga'
in the description and where the title starts either
with 'A' or ends with 'R'?
Use the alias 'no_of_movies'.*/
select count(*) as no_of_movies from film 
where description like '%Saga%' and (title like 'A%' or title like '%R')

/*2. Create a list of all customers where the first name contains
'ER' and has an 'A' as the second letter.
Order the results by the last name descendingly.*/
select * from customer where  first_name like '%ER%' and first_name like '_A%'

/*3. How many payments are there where the amount is either 0
or is between 3.99 and 7.99 and in the same time has
happened on 2020-05-01.*/
select count(*) from payment where (amount = 0 or amount between 3.99 and 7.99)
and payment_date between '2020-05-01' and '2020-05-01 23:59'

/*Your manager wants to which of the two employees (staff_id)
is responsible for more payments?
Which of the two is responsible for a higher overall payment
amount?
How do these amounts change if we don't consider amounts
equal to 0?*/
select staff_id, sum(amount),count(*) from payment group by staff_id 
select staff_id, sum(amount),count(*) from payment where amount!=0 group by staff_id 

/* There are two competitions between the two employees.
Which employee had the highest sales amount in a single day?
Which employee had the most sales in a single day (not
counting payments with amount = 0?*/
select staff_id, Date(payment_date), sum(amount) as highest_sales, count(*)  
from payment group by staff_id, Date(payment_date) order by highest_sales desc
select staff_id, Date(payment_date), sum(amount) as highest_sales, count(*)  
from payment where amount!=0 group by staff_id, Date(payment_date) order by highest_sales desc

/*Your manager wants to get a better understanding of the
films.
That's why you are asked to write a query to see the
• Minimum
• Maximum
• Average (rounded)
• Sum
of the replacement cost of the films.*/
select min(replacement_cost), max(replacement_cost), 
avg(replacement_cost), sum(replacement_cost) from film

/*In 2020, April 28, 29 and 30 were days with very high revenue.
That's why we want to focus in this task only on these days
(filter accordingly).
Find out what is the average payment amount grouped by
customer and day – consider only the days/customers with
more than 1 payment (per customer and day).
Order by the average amount in a descending order. */
select customer_id, Date(payment_date), avg(amount) from payment 
where Date(payment_date) in ('2020-04-28', '2020-04-29', '2020-04-30 23:59')
group by customer_id, Date(payment_date) having count(customer_id)>1 order by avg(amount) desc



/*In the email system there was a problem with names where
either the first name or the last name is more than 10 characters
long.
Find these customers and output the list of these first and last
names in all lower case.*/
select lower(first_name), lower(last_name), email from customer where length(first_name)>10 or length(last_name)>10

/*
In this challenge you have only the email address and the last
name of the customers.
You need to extract the first name from the email address and
concatenate it with the last name. It should be in the form:
"Last name, First name".*/
select substring(email from 1 for position(last_name in email)-2) || last_name as full_name from customer

/*Extract the last 5 characters of the email address first.
The email address always ends with '.org'.
How can you extract just the dot '.' from the email address? */
select right(email,5) from customer
select left(right(email,4),1) from customer 

/*You need to create an anonymized form of the email addresses
in the following way:
In a second query create an anonymized form of the email
addresses in the following way: */
select left(email,1) || '***'|| substring(email from position(last_name in email) for 1)
||'***'|| right(email,19) from customer
select '***' || substring(email from position(last_name in email)-2 for 2)||
 substring(email from position(last_name in email) for 1)
||'***'|| right(email,19) from customer

/* You need to analyze the payments and find out the following:
▪ What's the month with the highest total payment amount?
▪ What's the day of week with the highest total payment amount?
(0 is Sunday)
▪ What's the highest amount one customer has spent in a week?*/
select extract(month from payment_date) as month_, sum(amount) from payment group by month_ order by sum(amount) desc
select extract(DOW from payment_date) as Dow,sum(amount) from payment group by Dow  order by sum(amount) desc 
select extract(Week from payment_date) as Week, customer_id, sum(amount) from payment group by Week, customer_id  order by sum(amount) desc

			   			
/*You need to create a list for the suppcity team of all rental
durations of customer with customer_id 35.
Also you need to find out for the suppcity team
which customer has the longest average rental duration?*/
select customer_id, return_date - rental_date as rental_duration from rental where customer_id = 35
select customer_id, avg(return_date - rental_date) from rental group by customer_id order by avg(return_date - rental_date) desc


/*Your manager is thinking about increasing the prices for films
that are more expensive to replace.
For that reason, you should create a list of the films including the
relation of rental rate / replacement cost where the rental rate
is less than 4% of the replacement cost.
Create a list of that film_ids together with the percentage rounded
to 2 decimal places. For example 3.54 (=3.54%).*/
select film_id, round((rental_rate / replacement_cost * 100),2) as Percentage from 
film where (rental_rate / replacement_cost * 100) < 4 order by Percentage asc

/* You need to find out how many tickets you have sold in the
following categories:
• Low price ticket: total_amount < 20,000
• Mid price ticket: total_amount between 20,000 and 150,000
• High price ticket: total_amount >= 150,000
How many high price tickets has the company sold?*/
select count(*),
case when total_amount < 20000 then 'Low price ticket'
when total_amount < 150000 then 'Mid price ticket'
else 'High price ticket'
END as ticket_Price from bookings a group by ticket_Price


/*You need to find out how many flights have departed in the
following seasons:
• Winter: December, January, Februar
• Spring: March, April, May
• Summer: June, July, August
• Fall: September, October, November*/
select count(*), CASE WHEN EXTRACT(MONTH from scheduled_departure) in (12,1,2) THEN 'winter'
When EXTRACT(MONTH from scheduled_departure) in (3,4,5) then 'Spring'
When EXTRACT(MONTH from scheduled_departure) in (6,7,8) then 'Summer'
Else 'Fall' End as seasons from flights group by seasons

/* You want to create a tier list in the following way:
1. Rating is 'PG' or 'PG-13' or length is more then 210 min:
'Great rating or long (tier 1)
2. Description contains 'Drama' and length is more than 90min:
'Long drama (tier 2)'
3. Description contains 'Drama' and length is not more than 90min:
'Shcity drama (tier 3)'
4. Rental_rate less than $1:
'Very cheap (tier 4)'
If one movie can be in multiple categories it gets the higher tier assigned.
How can you filter to only those movies that appear in one of these 4 tiers?

*/
 select title, Case when Rating in ('PG', 'PG-13') or length>210 then 'Great rating or long (tier 1)'
 when description like '%Drama%' or length>90 then 'Long drama (tier 2)'
 when description like '%Drama%' or length<90 then  'Shcity drama (tier 3)'
 when rental_rate < 1 then 'Very cheap (tier 4)' end as movies from film 
 where Case when Rating in ('PG', 'PG-13') or length>210 then 'Great rating or long (tier 1)'
 when description like '%Drama%' or length>90 then 'Long drama (tier 2)'
 when description like '%Drama%' or length<90 then  'Shcity drama (tier 3)'
 when rental_rate < 1 then 'Very cheap (tier 4)' end is not null group by movies, title
 
 --Coalesce
 select rental_date, coalesce(cast(return_date as Varchar), 'Not Retured') as ne from rental order by ne desc
-- Replace
 select cast(replace(flight_no, 'PG', '') as int) from flights
 
 /*
The airline company wants to understand in which category they sell most
tickets.
How many people choose seats in the category
- Business
- Economy or
- Comfort?
You need to work on the seats table and the boarding_passes table.*/
select fare_conditions, count(*) from seats s inner join boarding_passes bp on s.seat_no= bp.seat_no group by fare_conditions

/*The flight company is trying to find out what their most popular
seats are.
Try to find out which seat has been chosen most frequently.
Make sure all seats are included even if they have never been
booked.
Are there seats that have never been booked?*/
select right(s.seat_no,1), s.seat_no, count(s.seat_no) from seats s 
left join boarding_passes bp on s.seat_no= bp.seat_no
group by s.seat_no order by count(s.seat_no) desc


/*Try to find out which line (A, B, …, H) has been chosen most
frequently.*/
select right(s.seat_no,1),  count(s.seat_no) from seats s
left join boarding_passes bp on s.seat_no= bp.seat_no
group by right(s.seat_no,1) order by count(s.seat_no) desc

 
 /*The company wants to run a phone call campaing on all customers in
Texas (=district).
What are the customers (first_name, last_name, phone number and their
district) from Texas?
Are there any (old) addresses that are not related to any customer?*/
select first_name, last_name, a.phone, a.district from customer c join address a on
c.address_id=a.address_id where district='Texas'
select a.address_id, a.address from address a left join customer c on
c.address_id=a.address_id where c.customer_id is null order by a.address_id

/*The company wants customize their campaigns to customers depending on
the country they are from.
Which customers are from Brazil?
Write a query to get first_name, last_name, email and the country from all
customers from Brazil.*/
select first_name, last_name, email,country from customer c join address a on
c.address_id=a.address_id join city on city.city_id= a.city_id join country
on city.country_id= country.country_id where country.country='Brazil'

/*Show only those movie titles, their associated film_id and replacement_cost
with the lowest replacement_costs for in each rating category – also show the
rating*/
select title, film_id, replacement_cost, rating from film f1 where replacement_cost in
(select  min(replacement_cost) from film f2 where f1.rating=f2.rating)
	 

/*Show only those movie titles, their associated film_id and the length that have
the highest length in each rating category – also show the rating.*/
select title, film_id, length, rating from film f1 where length in
(select  max(length) from film f2 where f1.rating=f2.rating)

/*Show all the payments plus the total amount for every customer as well as the
number of payments of each customer.*/
select payment_id, customer_id, staff_id, amount, (select sum(amount) from payment p2 where p1.customer_id=p2.customer_id), 
(select count(*) from payment p3 where p3.customer_id = p1.customer_id)
from payment p1 order by customer_id, amount desc
	
/*Show only those films with the highest replacement costs in their rating
category plus show the average replacement cost in their rating category*/
select title, replacement_cost, rating, (select round(avg(replacement_cost),2) from film f3 where f1.rating= f3.rating ) from film f1 where replacement_cost in
(select  max(replacement_cost) from film f2 where f1.rating=f2.rating)

/*Show only those payments with the highest payment for each customer's first
name - including the payment_id of that payment.*/
select first_name, amount, payment_id
from payment p1 join customer c on 
c.customer_id =p1.customer_id where amount = 
(select max(amount) from payment p2 where p2.customer_id= p1.customer_id)

/*How would you solve it if you would not need to see the payment_id?*/
select first_name, max(amount)
from payment p1 join customer c on 
c.customer_id =p1.customer_id group by first_name







 







