
-- ------------ select all book written by lahiri published after 2000 -------- 

select title, concat ( AUTHOR_FNAME, ' ' , AUTHOR_LNAME) as full_name from books 
where author_lname ='Lahiri' and
released_year > 2000 ;


-- ---------- select all books with page counts between 100 and 200 -----------

select title, pages from books
where pages between 100 and 200;


-- select all books where author_lnae starts with c or s -- 

select title, AUTHOR_lname from books
where author_lname like 'C%' or author_lname LIKE 'S%';

-- or-- 

select title, AUTHOR_lname
from books
where
substr(author_lname, 1,1)='c' or
substr(author_lname, 1,1)='s';

-- or--

select title, AUTHOR_lname
from books
where
substr(author_lname,1,1) in ('c', 's');


-- --- case statement ----------

select title, author_lname,
case 
when title='%stories%' THEN ' SHORT stories'
WHEN title='%just kids%' or title='%heartbreaking work%' then 'memoir'
else 'novel'
end as Title_selection
from books;

-- case statement ---


select author_lname, 
case 
when count(*)=1 then '1 book'
else concat(count(*) , ' books')
end as count
from books
group by author_lname, author_fname;




-- ---------select all books written before 1980 ------------------

select title, released_year,
concat (author_fname, ' ', author_lname) as ' full name' 
from books
where released_year < 1980;


-- --------------select all books where author last name is Eggers or Chabon --

select title, 
concat (author_fname, ' ', author_lname) as ' full name' 
from books
where author_lname='eggers' or author_lname='chabon';


select title, 
concat (author_fname, ' ', author_lname) as ' full name' 
from books
where author_lname in ('eggers', 'chabon');



