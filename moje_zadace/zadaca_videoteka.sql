### Baza podataka za poslovanje jedne videoteke.
- Kreirajte ER dijagram za poslovanje jedne videoteke.
- Videoteka članovima izdaje članske iskaznice te se na temelju članskog broja osoba identificira kako bi mogla posuditi filmove.
- Filmovi su složeni po žanrovima.
- Videoteka ima definiran cjenik za izdavanje hit filma, film koji nije hit te starog filma.
- Jedan film može biti na DVD-u, BlueRay-u ili VHS-u.
- Film se posđuje na rok od jednog dana I ako ga član ne vrati u navedeno vrijeme, zaračunava mu se zakasnina.


------------------------------------------------------------------------------------------------------------------------------


### Dopuna zadace
- kreirajte novo korisnika u MySQL-u i dajte mu povlastice samo za bazu videoteka

- Svaki film ima zalihu dostupnih kopija po mediju za koji je dostupan
- Svaka fizicka kopija filma ima svoj jedinstveni identifikacijski broj (s/n) kako bi se mogla pratiti
- Clan od jednom moze posuditi vise od jednog filma



-- /////////////////////////////////////////////////////////////////////////////////////////////////
- kreirajte novo korisnika u MySQL-u i dajte mu povlastice samo za bazu videoteka
-- //////////////////////////////////kreiranje usera u MySQL za koristenje postojece VIDEOTEKA baze:

CREATE USER 'user'@'localhost' IDENTIFIED BY 'user';

-- //////////////////////////////////dodavanje privilegija za koristenje postojece VIDEOTEKA baze:

GRANT ALL PRIVILEGES ON videoteka.* TO 'user'@'localhost';

FLUSH PRIVILEGES;

EXIT;

-- ////////////////////////////////////////////////////////////////////////login na VIDEOTEKA bazu:

mysql -u user -p videoteka


-- /////////////////////////////////////////////////////////////////////////////////////////////////
Svaki film ima zalihu dostupnih kopija po mediju za koji je dostupan
- Svaka fizicka kopija filma ima svoj jedinstveni identifikacijski broj (s/n) kako bi se mogla pratiti
-- //////////////////////////////////////////dodajemo tablicu primjerci na postojecu VIDEOTEKA bazu:

CREATE TABLE IF NOT EXISTS primjerci (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    zaliha_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (zaliha_id) REFERENCES zaliha(id),
    serijski_broj VARCHAR(50) NOT NULL UNIQUE
)ENGINE=InnoDB;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////
-- /////////////////////////////////////////////////////////////uredimo tablicu posudba baze VIDEOTEKA:


ALTER TABLE posudba DROP FOREIGN KEY posudba_ibfk_2;

ALTER TABLE posudba DROP COLUMN zaliha_id;

ALTER TABLE posudba ADD COLUMN primjerak_id INT UNSIGNED NOT NULL;

ALTER TABLE posudba ADD CONSTRAINT posudba_ibfk_3 FOREIGN KEY (primjerak_id) REFERENCES primjerci(id);

Ukoliko iznova dodajemo tablicu, mozemo ju odmah pri kreiranju kreirati na ovaj način:

CREATE TABLE IF NOT EXISTS posudba (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    datum_posudbe DATE NOT NULL,
    datum_povrata DATE,
    clan_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (clan_id) REFERENCES clanovi(id),
    primjerak_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (primjerak_id) REFERENCES primjerci(id)
)ENGINE=InnoDB;



-- //////////////////////////////////////////ili ako doajemo na novo tablicu clan_posudba u bazu VIDEOTEKA:



CREATE TABLE IF NOT EXISTS clan_posudba (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL PRIMARY KEY,
    clan_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (clan_id) REFERENCES clanovi(id),
    primjerak_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (primjerak_id) REFERENCES primjerci(id),
    datum_posudbe DATE NOT NULL,
    datum_povrata DATE,
    UNIQUE KEY (clan_id, primjerak_id)
) ENGINE=InnoDB;

-------------------------------------------------------------------------------------------------------------------------------
