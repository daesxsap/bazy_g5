
/*FUNKCJA, tabela projekt_zasoby, liczy ile jest wszystkich rodzajów towaru*/

CREATE DEFINER=`stepniakk`@`localhost` FUNCTION `count_typesofresources`() RETURNS int
begin
declare typy int;
select count(*) into @typy from projekt_zasoby;
return @typy;
end

/*``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````*/


/*PROCEDURA, tabela projekt_zasoby, zmienia cenę za sztukę danego zasobu*/

CREATE DEFINER=`stepniakk`@`localhost` PROCEDURE `zmiana`(in id int,cena float(6,2))
begin
update projekt_zasoby set cena_za_sztk = cena where idprojekt_zasoby = id;
end

/*``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````*/

/*TRIGGER1, tabela projekt_zajecia, nie pozwala dodać rekordu jeżeli numer sali jest większy niż 3*/

delimiter // 
create trigger projekt_zajecia_after_insert
after insert on projekt_zajecia
for each row
begin
if new.nr_sali > 3
then
delete from projekt_zajecia where new.nr_sali > 3;
end if;
end;
delimiter//


/*``````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````````*/

/*TRIGGER2, tabela projekt_zasoby, nie pozwala dodać ceny zasobu mniejszej bądź równej 0*/

delimiter // 
create trigger projekt_zasoby_after_insert
after insert on projekt_zasoby
for each row
begin
if new.cena_za_sztk <= 0
then
delete from projekt_zasoby where new.cena_za_sztk <= 0;
end if;
end;
delimiter//
