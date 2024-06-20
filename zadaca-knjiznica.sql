### Zadaca:
#### Napraviti Upite na bazi podataka "knjiznica"
1. Navedite sve članove koji su posudili knjige, zajedno s naslovima knjiga koje su posudili.

        // provjera broja posudbe radi kasnijeg utvrđivanja točnosti rezultata
        Način kreiranja querya/dohvaćanja podataka:
        - tablica posudbe ima sve posudbe
        - dohvaćanje imena/prezimena člana: 
        clan ID(posudba) > ime/prezime(clanovi)
        - dohvaćanje naslova knjige:
        kopija_id (kopija) ima knjiga_id > naslov (knjige)

        SELECT clanovi.ime, clanovi.prezime, knjige.naslov
        FROM posudbe
        JOIN clanovi ON posudbe.clan_id = clanovi.id
        JOIN kopija ON posudbe.kopija_id = kopija.id
        JOIN knjige ON kopija.knjiga_id = knjige.id;


2. Pronađite članove koji imaju zakašnjele knjige.

        SELECT clanovi.ime, clanovi.prezime, knjige.naslov, posudbe.datum_posudbe
        FROM posudbe
        JOIN clanovi ON posudbe.clan_id = clanovi.id
        JOIN kopija ON posudbe.kopija_id = kopija.id
        JOIN knjige ON kopija.knjiga_id = knjige.id
        WHERE posudbe.datum_povrata IS NULL AND posudbe.datum_posudbe < DATE_SUB(CURDATE(), INTERVAL 14 DAY);

3. Pronađite sve žanrove i broj dostupnih knjiga u svakom žanru.

        SELECT zanrovi.naziv, COUNT(kopija.id) AS broj_dostupnih_knjiga
        FROM zanrovi
        JOIN knjige ON zanrovi.id = knjige.zanr_id
        JOIN kopija ON knjige.id = kopija.knjiga_id
        WHERE kopija.dostupna = TRUE
        GROUP BY zanrovi.naziv;








