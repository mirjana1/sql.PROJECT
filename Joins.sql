CREATE DATABASE customers_and_orders;
use customers_and_orders;

create table customers
(
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	email VARCHAR(100)
);


create table orders
(
	order_id INT PRIMARY KEY AUTO_INCREMENT,
	order_date DATE,
	amount DECIMAL(8,2),
	customer_id INT,
	FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (first_name, last_name, email) 
VALUES ('Boy', 'George', 'george@gmail.com'),
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');
       
INSERT INTO orders (order_date, amount, customer_id)
VALUES ('2016/02/10', 99.99, 1),
       ('2017/11/11', 35.50, 1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11', 450.25, 5);
      
      select * from orders;
      select * from customers;
      
     -- explicit inner join 
     
   select  o.amount, o.order_date,  concat(first_name, " " , last_name) as full_name
   from orders as o 
   join customers as c on c.customer_id=o.customer_id;
   
   SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

   select 
   c.first_name,
   c.last_name,
   o.amount
   from customers as c
   join orders as o  on c.customer_id=o.customer_id
   group by  o.customer_id
   order by o.amount desc;


select 
   c.first_name,
   c.last_name,
   o.amount
   from customers as c
   join orders as o  on c.customer_id=o.customer_id
   group by  o.customer_id
   order by o.amount desc;
   
      SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
  
  -- left join 
  
select 
	first_name,
    last_name, 
    ifnull(sum(amount), 0) as amount
from customers as c 
left join orders as o
on c.customer_id=o.customer_id
group by c.customer_id;

create table reviewers (
reviewer_id int primary key auto_increment,
first_name varchar(100),
last_name varchar (100));


create table series(
serie_id int primary KEY auto_increment,
title varchar (100),
released_year YEAR,
genre varchar (100));


INSERT INTO series (title, released_year, genre) VALUES
    ('Archer', 2009, 'Animation'),
    ('Arrested Development', 2003, 'Comedy'),
    ("Bob's Burgers", 2011, 'Animation'),
    ('Bojack Horseman', 2014, 'Animation'),
    ("Breaking Bad", 2008, 'Drama'),
    ('Curb Your Enthusiasm', 2000, 'Comedy'),
    ("Fargo", 2014, 'Drama'),
    ('Freaks and Geeks', 1999, 'Comedy'),
    ('General Hospital', 1963, 'Drama'),
    ('Halt and Catch Fire', 2014, 'Drama'),
    ('Malcolm In The Middle', 2000, 'Comedy'),
    ('Pushing Daisies', 2007, 'Comedy'),
    ('Seinfeld', 1989, 'Comedy'),
    ('Stranger Things', 2016, 'Drama');
    
    
    INSERT INTO reviewers (first_name, last_name) VALUES
    ('Thomas', 'Stoneman'),
    ('Wyatt', 'Skaggs'),
    ('Kimbra', 'Masters'),
    ('Domingo', 'Cortes'),
    ('Colt', 'Steele'),
    ('Pinkie', 'Petit'),
    ('Marlon', 'Crafford');
    
  create table reviews (
  review_id int primary key auto_increment,
  rating decimal (2,1),
  serie_id int,
  reviewer_id int,
  foreign key(serie_id) references series(serie_id),
  foreign key (reviewer_id) references reviewers(reviewer_id));
  
  
  INSERT INTO reviews(serie_id, reviewer_id, rating) VALUES
    (1,1,8.0),(1,2,7.5),(1,3,8.5),(1,4,7.7),(1,5,8.9),
    (2,1,8.1),(2,4,6.0),(2,3,8.0),(2,6,8.4),(2,5,9.9),
    (3,1,7.0),(3,6,7.5),(3,4,8.0),(3,3,7.1),(3,5,8.0),
    (4,1,7.5),(4,3,7.8),(4,4,8.3),(4,2,7.6),(4,5,8.5),
    (5,1,9.5),(5,3,9.0),(5,4,9.1),(5,2,9.3),(5,5,9.9),
    (6,2,6.5),(6,3,7.8),(6,4,8.8),(6,2,8.4),(6,5,9.1),
    (7,2,9.1),(7,5,9.7),
    (8,4,8.5),(8,2,7.8),(8,6,8.8),(8,5,9.3),
    (9,2,5.5),(9,3,6.8),(9,4,5.8),(9,6,4.3),(9,5,4.5),
    (10,5,9.9),
    (13,3,8.0),(13,4,7.2),
    (14,2,8.5),(14,3,8.9),(14,4,8.9);
    
    select * from series;
    select * from reviews;
    
    select title,rating from series as s
   inner join reviews as r on s.serie_id=r.serie_id;
   SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
  
  select title, avg(rating) as avg_rating from series as s
   inner join reviews as r on s.serie_id=r.serie_id
   group by title
   order by avg(rating);
   
   select * from reviewers;
   select * from reviews;
   
   select concat (first_name, " ", last_name) as full_name, rating from reviewers as rv
   inner join  reviews as r on rv.reviewer_id=r.reviewer_id
   group by full_name 
   order by rating desc;
   
select title from series as s 
left join reviews as r on r.serie_id=s.serie_id
where rating is null;


select genre, round(avg(rating) , 2) as avg_rating from series as s 
join reviews as r on s.serie_id=r.serie_id
group by genre
order by rating desc;
 
 SET SESSION sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
 
select concat(first_name, " ", last_name) as reviewer,rating,title from reviewers as rv
inner join reviews  as r on rv.reviewer_id=r.reviewer_id
join series as s on s.serie_id=r.serie_id
order by title;

select 
	first_name, 
    last_name, 
    count(rating) as count,
  ifnull( min(rating),0) as min,
  ifnull (max(rating),0) as max,
 ifnull(avg(rating),0) as avg,
case
when count(rating)>=1 then 'active'
else 'inactive'
end as Status
from reviewers as rv
left join 
	reviews  as r on rv.reviewer_id=r.reviewer_id
group by r.reviewer_id;
    
    
    
select 
first_name, 
last_name, 
count(rating) as count,
ifnull( min(rating),0) as min,
ifnull (max(rating),0) as max,
ifnull(avg(rating),0) as avg,
if(count(rating)>=1, 'active', 'inactive') as status
from reviewers as rv
left join 
	reviews  as r on rv.reviewer_id=r.reviewer_id
group by r.reviewer_id;



    
