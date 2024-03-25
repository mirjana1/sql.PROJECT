
CREATE DATABASE SAMOSTALNI_PROJEKT;
USE SAMOSTALNI_PROJEKT;

--------------------------------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE Lokacije (
    LokacijaID INT AUTO_INCREMENT PRIMARY KEY,
    Naziv VARCHAR(255) NOT NULL,
    Adresa VARCHAR(255) NOT NULL,
    Grad VARCHAR(100) NOT NULL,
    Kapacitet INT NOT NULL
);

CREATE TABLE Konferencije (
    KonferencijaID INT AUTO_INCREMENT PRIMARY KEY,
    Naziv VARCHAR(255) NOT NULL,
    Opis TEXT NOT NULL,
    DatumPocetka DATE NOT NULL,
    DatumZavrsetka DATE NOT NULL,
    LokacijaID INT,
    FOREIGN KEY (LokacijaID) REFERENCES Lokacije(LokacijaID)
);

CREATE TABLE Sudionici (
    SudionikID INT AUTO_INCREMENT PRIMARY KEY,
    Ime VARCHAR(100) NOT NULL,
    Prezime VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Institucija VARCHAR(255)
);

CREATE TABLE Predavaci (
    PredavacID INT AUTO_INCREMENT PRIMARY KEY,
    Ime VARCHAR(100) NOT NULL,
    Prezime VARCHAR(100) NOT NULL,
    Titula VARCHAR(50),
    Institucija VARCHAR(255)
);

CREATE TABLE Predavanja (
    PredavanjeID INT AUTO_INCREMENT PRIMARY KEY,
    KonferencijaID INT,
    Naslov VARCHAR(255) NOT NULL,
    Opis TEXT NOT NULL,
    PredavacID INT,
    VrijemePocetka DATETIME NOT NULL,
    Trajanje INT NOT NULL,
    FOREIGN KEY (KonferencijaID) REFERENCES Konferencije(KonferencijaID),
    FOREIGN KEY (PredavacID) REFERENCES Predavaci(PredavacID)
);

CREATE TABLE Registracije (
    RegistracijaID INT AUTO_INCREMENT PRIMARY KEY,
    SudionikID INT,
    KonferencijaID INT,
    DatumRegistracije DATE NOT NULL,
    StatusPlacanja VARCHAR(100) NOT NULL,
    FOREIGN KEY (SudionikID) REFERENCES Sudionici(SudionikID),
    FOREIGN KEY (KonferencijaID) REFERENCES Konferencije(KonferencijaID)
);

INSERT INTO Lokacije (Naziv, Adresa, Grad, Kapacitet) VALUES
('Centar za kongrese Atrium', 'Ulica Zrtava 49', 'Zagreb', 200),
('Konferencijski centar Tower', 'Neboderova 12', 'Split', 150),
('Hotel Adriatic', 'Obalna 22', 'Dubrovnik', 100);

INSERT INTO Konferencije (Naziv, Opis, DatumPocetka, DatumZavrsetka, LokacijaID) VALUES
('Web Development Trends 2024', 'Konferencija o najnovijim trendovima u razvoju web aplikacija.', '2024-05-15', '2024-05-17', 1),
('AI & Machine Learning Expo', 'Istražite kako AI i strojno učenje mijenjaju svijet oko nas.', '2024-06-20', '2024-06-22', 2),
('Cyber Security Conference', 'Sve o sigurnosti u digitalnom dobu.', '2024-07-10', '2024-07-12', 3);

INSERT INTO Sudionici (Ime, Prezime, Email, Institucija) VALUES
('Ivana', 'Ivić', 'ivana.ivic@email.com', 'Fakultet Elektrotehnike'),
('Marko', 'Markić', 'marko.markic@email.com', 'IT Kompanija XYZ'),
('Ana', 'Anić', 'ana.anic@email.com', 'Startup ABC');

INSERT INTO Predavaci (Ime, Prezime, Titula, Institucija) VALUES
('Petar', 'Petrović', 'dr.sc.', 'Sveučilište u Zagrebu'),
('Lucija', 'Lucić', 'mag.ing.', 'Institut za tehnologiju'),
('Josip', 'Josipović', 'prof.dr.sc.', 'Fakultet Strojarstva');

INSERT INTO Predavanja (KonferencijaID, Naslov, Opis, PredavacID, VrijemePocetka, Trajanje) VALUES
(1, 'Nove mogućnosti HTML-a i CSS-a', 'Detaljan pregled novih mogućnosti.', 1, '2024-05-15 10:00:00', 90),
(2, 'Primjena AI u industriji', 'Kako AI mijenja proizvodne procese.', 2, '2024-06-21 11:00:00', 60),
(3, 'Zaštita podataka u cloudu', 'Metode i prakse zaštite podataka.', 3, '2024-07-11 09:30:00', 120);

INSERT INTO Registracije (SudionikID, KonferencijaID, DatumRegistracije, StatusPlacanja) VALUES
(1, 1, '2024-05-01', 'Plaćeno'),
(2, 2, '2024-06-05', 'Plaćeno'),
(3, 3, '2024-07-01', 'Nije plaćeno');

-- 1. Dohvaćanje svih predavanja na konferenciji
-- Ovaj upit prikazuje sve predavanja koja se održavaju na određenoj konferenciji. Pretpostavimo da želimo dohvatiti sve predavanja s konferencije čiji je ID 1.

 select * from predavanja;
 select * from konferencije;
 
 select p.predavanjeid, p.konferencijaid, p.naslov, p.vrijemepocetka, p.trajanje
 from predavanja as p
 join konferencije as k on k.konferencijaid=p.konferencijaid
 where k.konferencijaid=1;
 
-- Dohvaćanje svih konferencija u određenom gradu (bern)

select*from lokacije;

select k. konferencijaID, k.naziv, k.opis
from konferencije AS k
join lokacije as l on l.lokacijaid=k.lokacijaID
where l.grad = "zagreb";

-- Lista sudionika registriranih za konferenciju / Pretpostavljamo da je ID konferencije 1


select s.sudionikID, s.ime, s.prezime
FROM sudionici AS s
join registracije as r on s.sudionikID=r.sudionikID
JOIN konferencije as k on r.konferencijaID=k.konferencijaID
where k.konferencijaid=1;

-- Lista predavanja koja će voditi određeni predavač /  Pretpostavljamo da je ID predavača 1

select * from predavaci;

select p.predavacID, p.ime, p.prezime, p.titula
from predavaci AS p
join predavanja AS pr on p.predavacID=pr.predavacID
WHERE p.predavacID=1;

-- Dohvaćanje svih sudionika koji su registrirani za određeno predavanje / Pretpostavljamo da je ID predavanja 2

select * from registracije;

select s.sudionikID, s.ime, s.prezime
from sudionici AS s
join registracije as r on s.sudionikID=r.sudionikID
join konferencije as k on r.konferencijaID=k.konferencijaID
join predavanja as pr on k.konferencijaID=pr.konferencijaID
WHERE pr.predavanjeID=2;

-- Dohvaćanje ukupnog broja registracija po konferencijama

select k.konferencijaID, k.naziv, COUNT(r.registracijaID) AS broj_registracija
from konferencije AS k
join registracije AS r ON k.konferencijaID=r.konferencijaID
group by k.konferencijaID, k.naziv;


-- Prikazivanje punog imena i email adrese svih sudionika: 


select * from sudionici;
select concat(ime, " ",  email)  as puno_ime_i_email from sudionici;

-- Pronalaženje najranijeg i najkasnijeg datuma početka konferencije:

select * from konferencije;

select min(datumpocetka) as najraniji_datum, max(datumpocetka) as najkasniji_datum from konferencije;

-- Izračunavanje prosječnog trajanja predavanja po konferenciji:


select
	k.konferencijaID, 
    k.naziv as naziv_konferencije, 
    k.opis, 
AVG (p.trajanje) as prosjecno_trajanje
from konferencije as k
join predavanja as p on p.konferencijaID=k.konferencijaID
group by 
	k.konferencijaID, 
    k.naziv,k.opis,
    p.trajanje
ORDER BY prosjecno_trajanje desc;

-- Prikazivanje prvih 10 karaktera opisa svakog predavanja, sortiranih po datumu početka:

select 
	predavanjeID,
	substring(opis,1,10) as skraćeni_opis, 
    vrijemepocetka 
from predavanja
order by vrijemepocetka desc;


--  koliko sudionika ima na svakoj konferenciji.?

SELECT 
    k.KonferencijaID, 
    COUNT(r.SudionikID) AS BrojSudionika
FROM 
    Registracije r
JOIN 
    Konferencije k ON r.KonferencijaID = k.KonferencijaID
GROUP BY 
    k.KonferencijaID;

-- Pronalazak konferencije s najvećim brojem registriranih sudionika:

SELECT k.naziv, COUNT(r.sudionikID) AS broj_sudionika
FROM konferencije AS k
JOIN registracije AS r ON r.konferencijaID = k.konferencijaID
GROUP BY k.konferencijaID
ORDER BY broj_sudionika DESC
LIMIT 1;

-- Izračunavanje prosječnog trajanja predavanja po konferenciji, uključujući samo one konferencije s više od 3 predavanja:


SELECT 
    k.KonferencijaID, 
    k.Naziv, 
    COUNT(p.PredavanjeID) AS BrojPredavanja
FROM 
    Konferencije k
JOIN 
    Predavanja p ON k.KonferencijaID = p.KonferencijaID
GROUP BY 
    k.KonferencijaID, k.Naziv
HAVING 
    COUNT(p.PredavanjeID) > 3;
    
    -- Pronalaženje najdužeg trajanja predavanja na svakoj konferenciji
    
   SELECT 
    k.KonferencijaID, 
    k.Naziv AS NazivKonferencije, 
    MAX(p.Trajanje) AS NajduzeTrajanjePredavanja
FROM 
    Predavanja p
JOIN 
    Konferencije k ON k.KonferencijaID = p.KonferencijaID
GROUP BY 
    k.KonferencijaID, k.Naziv
ORDER BY 
    NajduzeTrajanjePredavanja DESC;
    
   --  Brojanje konferencija po godini održavanja
   
	select 
	count(k.konferencijaID) as broj_konferencija,  
	extract(year from k.datumpocetka) as godina_odrzavanja
	from konferencije as k
	group by godina_odrzavanja;
	
    
    -- Izračunavanje prosječnog trajanja predavanja po konferenciji za one koje imaju više od 2 predavanja
    
   SELECT 
    k.KonferencijaID, 
    k.Naziv, 
    AVG(p.Trajanje) AS ProsjecnoTrajanjePredavanja
FROM 
    Predavanja p
JOIN 
    Konferencije k ON k.KonferencijaID = p.KonferencijaID
GROUP BY  
    k.KonferencijaID, k.Naziv
HAVING 
    COUNT(p.PredavanjeID) > 2
ORDER BY 
    ProsjecnoTrajanjePredavanja DESC;


-- Zahtjev:

-- Izračunaj prosječno trajanje predavanja po konferenciji.
-- daberi samo one konferencije gdje je prosječno trajanje predavanja više od 60 minuta.
-- Za svaku odabranu konferenciju izračunaj ukupan broj održanih predavanja.
-- Poredaj konferencije prema ukupnom broju predavanja od najvećeg prema najmanjem.

select avg (p.trajanje) as prosjecno_trajanje, k.konferencijaID, k.naziv
from predavanja as p 
join Konferencije as k ON k.KonferencijaID = p.KonferencijaID
group by k.konferencijaID, k.naziv
having prosjecno_trajanje>60
order by prosjecno_trajanje desc;
