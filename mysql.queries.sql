create database  mj;
use mj;

create table books (
book_id int not null auto_increment,
title varchar (100),
author_fname varchar (100),
author_lname varchar (100),
released_year int,
stock_quantity int,
pages int,
primary key (book_id));


INSERT INTO books (title, author_fname, author_lname, released_year, stock_quantity, pages)
VALUES
('The Namesake', 'Jhumpa', 'Lahiri', 2003, 32, 291),
('Norse Mythology', 'Neil', 'Gaiman',2016, 43, 304),
('American Gods', 'Neil', 'Gaiman', 2001, 12, 465),
('Interpreter of Maladies', 'Jhumpa', 'Lahiri', 1996, 97, 198),
('A Hologram for the King: A Novel', 'Dave', 'Eggers', 2012, 154, 352),
('The Circle', 'Dave', 'Eggers', 2013, 26, 504),
('The Amazing Adventures of Kavalier & Clay', 'Michael', 'Chabon', 2000, 68, 634),
('Just Kids', 'Patti', 'Smith', 2010, 55, 304),
('A Heartbreaking Work of Staggering Genius', 'Dave', 'Eggers', 2001, 104, 437),
('Coraline', 'Neil', 'Gaiman', 2003, 100, 208),
('What We Talk About When We Talk About Love: Stories', 'Raymond', 'Carver', 1981, 23, 176),
("Where I'm Calling From: Selected Stories", 'Raymond', 'Carver', 1989, 12, 526),
('White Noise', 'Don', 'DeLillo', 1985, 49, 320),
('Cannery Row', 'John', 'Steinbeck', 1945, 95, 181),
('Oblivion: Stories', 'David', 'Foster Wallace', 2004, 172, 329),
('Consider the Lobster', 'David', 'Foster Wallace', 2005, 92, 343);

SELECT * FROM BOOKS;

select concat(author_fname,' ',author_lname) as 'full name'
from books;

select substring("Where I'm Calling From: Selected Stories",1,22);

select substring(title,1,10) as short_title from books;

elect upper (title) from books;

select concat('my favorite book is the  ' ,upper(title)) from books;

select concat
(substring(title,1,22),
'...') as short_title
from books;

-- 1 practice

select reverse(upper('why does my cat look at me with such hatred?'));

select replace(concat('I', ' ', 'like', ' ', 'cats'), ' ', '-');

select replace( title, ' ', '<-'   ) from books;

select 
upper( concat(author_fname, ' ', author_lname)) as ' full name in caps' from books;

select concat(title, ' was released in ' , released_year ) as 'short description' from books;

select title, char_length(title) from books;

select concat
(substring(title, 2, 10),'...')  as 'short title'
from books;

insert into books (title, author_fname, author_lname, released_year, stock_quantity, pages) values ('10% happier', 'dan', 'harris', 2014 , 29, 256),
('fake book', 'freida', 'harris', 2001, 287, 428),
('lincoln in the bardo', 'george', 'saunders', 2017, 1000, 367);


select distinct author_lname from books;

select distinct(concat(author_fname , ' ',  author_lname)) as 'distinct full name' from books;

select author_lname from books
order by author_lname;

select title, author_lname, pages from books
order by author_lname desc;

select  title, author_lname, pages from books
order by 2 desc;

select * from books limit 
 2;
 
 select title, author_fname, released_year from books 
 order by 1 desc 
 limit 5;
 
 select title, author_fname, released_year from books 
 order by 1 desc 
 limit 2, 5;
 
 select * from books;
 
 select title, author_fname from books where author_fname like '%D%';
 
 select stock_quantity from books where stock_quantity like '__';
 
 select title from books where title like '%/_%';
 
 select title from books where title like '%stories%';
 
 select title, pages from books order by pages desc
 limit 0,3;
 
 select concat(title, '-', released_year) from books order by released_year desc
 limit 3;
 
 select concat('my favorite author is', ' ' , upper(author_fname), ' ', upper(author_lname)) 
 as yell from books 
 order by author_fname
 limit 6,5;

select count(*) from books;
 
 select count(distinct author_fname) from books;
 
 select count(distinct author_lname, author_fname) from books;
 
 select title from books where title like '%the%';
 select count(*) from books where title like '%the%';
 
 select author_lname, author_fname, count(*)
 from books group by author_lname, author_fname;
 
 select title, released_year, count(*) from books
 group by released_year, title ;
 
 select concat( 'in', ' ', released_year , ' ' , count(*) , ' book(s) ', 'released') 
 as year from books 
 group by released_year;
 
 select min(pages) from books;
 select max(pages), title from books;

select title, pages from books 
where pages = (select max(pages) from books);

select title, pages from books
 where pages= (select min(pages)from books);
 
 select title, pages from books order by pages asc limit 1;
 select title, pages from books order by pages desc limit 1;
 
 select author_fname, author_lname, min(released_year)
 from books
 group by author_fname, author_lname;
 
 select author_fname,author_lname, max(pages)
 from books
 group by author_fname,author_lname;
 
 select concat(author_fname, ' ' , author_lname) as 'full name', max(pages) as ' longest book '
 from books
 group by author_fname, author_lname;


select title, author_lname, 
case 
when title like "%stories%" then "short stories"
when title like "%just kids%" OR title like "a heartbreaking work%" then "memoir"
else "novel"
end as type 
FROM BOOKS;	
