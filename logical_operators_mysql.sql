select title, released_year from books where released_year != 2017;

select title,	author_lname from books where author_lname = 'harris';

select title from books where title NOT like '%W%';


select * from books 
where released_year >= 2000;

select title, author_lname from books
where released_year > 2000 
&& author_lname ='eggers';


select name, birthdt from people 
where birthdt between cast('1980-01-01' as datetime) and cast('2000-01-01' as datetime);

select title, author_lname, author_lname 
from books
where author_LNAME IN ('CARVER', 'SMITH', 'LAHIRI');

SELECT TITLE, RELEASED_YEAR 
From books
where released_year IN (2017,2000,1945,1985);


select title, author_lname, author_lname 
from books
where author_LNAME NOT IN ('CARVER', 'SMITH', 'LAHIRI');

SELECT TITLE, releaseD_YEAR FROM books
where released_year not in (2000,2005,2007,2016,2018,2014);

select TITLE, releaseD_YEAR 
FROM books
where released_year > 1985
and  released_year not in (2005,2007,2016,2018,2003)
order by released_year asc;

select title, released_year,
case when released_year>= 2000 then 'modern lit'
else '20th century lit'
end AS GENRE
FROM books;

select title, stock_quantity,
case
 when stock_quantity between 0 and 50 then '*'
when stock_quantity between 51 and 100 then '**'
else '***'
end as stock
from books;