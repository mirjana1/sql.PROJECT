
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

----------------------------
CREATE TABLE knjige (
    id INT AUTO_INCREMENT PRIMARY KEY,
    naslov VARCHAR(255),
    autor VARCHAR(255),
    godina_izdanja YEAR,
    datum_dodavanja DATETIME,
    broj_stranica INT
);
INSERT INTO knjige (naslov, autor, godina_izdanja, datum_dodavanja, broj_stranica) VALUES
('Gospodar prstenova', 'J.R.R. Tolkien', 1954, NOW(), 1216),
('1984', 'George Orwell', 1949, '2024-03-24 10:00:00', 328),
('Mali princ', 'Antoine de Saint-Exupéry', 1943, '2024-03-23 12:30:00', 96),
('Harry Potter i Kamen mudraca', 'J.K. Rowling', 1997, '2024-03-24 11:15:00', 223),
('Da Vincijev kod', 'Dan Brown', 2003, '2024-03-24 09:45:00', 689);

-- Izračunajte koliko dana je prošlo
 -- od datuma dodavanja svake knjige do danas 
 
 select * from knjige;
 
 select 
	naslov, 
    date_format(datum_dodavanja, '%W %M %Y') 
 as datum_dodavanja,
 datediff(now(), datum_dodavanja) as vrijeme_od_dodavanja from knjige;
 
--  Dodajte 15 dana na datum dodavanja svake knjige i prikažite novi datum

SELECT naslov, 
       datum_dodavanja,
       DATE_ADD(datum_dodavanja, INTERVAL 15 DAY) AS novi_datum_dodavanja
FROM knjige;

-- Prikazivanje dana u tjednu na kojeg je dodana svaka knjiga.

select naslov, dayofweek(datum_dodavanja) as dan_u_tjednu from knjige;
select naslov, dayname(datum_dodavanja) as dan_u_tjednu from knjige;

--  Izračunajte razliku u vremenu između 
-- trenutka dodavanja knjige i trenutnog vremena u satima.

SELECT naslov, 
       datum_dodavanja, 
       TIMESTAMPDIFF(HOUR, datum_dodavanja, NOW()) AS razlika_u_satima
FROM knjige;


-- Razlika u Satima za Knjige Dodane u Posljednjih 7 Dana
select * from books;
select naslov, timestampdiff(hour, datum_dodavanja, now()) as razlika_u_satima
from knjige
where datum_dodavanja>=current_date()- interval 7 day;



