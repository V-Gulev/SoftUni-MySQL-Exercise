create database summer_olympics;
use summer_olympics;

create table countries(
	id int primary key auto_increment,
    name varchar(40) not null unique
);

create table sports(
	id int primary key auto_increment,
    name varchar(20) not null unique
);

create table disciplines(
	id int primary key auto_increment,
    name varchar(40) not null unique,
    sport_id int not null,
    constraint fk_disciplines_sports
		foreign key (sport_id) references sports(id)
);

create table athletes(
	id int primary key auto_increment,
    first_name varchar(40) not null,
    last_name varchar(40) not null,
    age int not null,
    country_id int not null,
    constraint fk_athletes_countries
		foreign key (country_id) references countries(id)
);

create table medals(
	id int primary key auto_increment,
    type varchar(10) not null unique
);

create table disciplines_athletes_medals(
	discipline_id int not null,
    athlete_id int not null,
    medal_id int not null,
    constraint fk_disciplines_athletes_medals_disciplines
		foreign key (discipline_id) references disciplines(id),
	constraint fk_disciplines_athletes_medals_athletes
		foreign key (athlete_id) references athletes(id),
	constraint fk_disciplines_athletes_medals_medals
		foreign key (medal_id) references medals(id),
	constraint pk_discipline_athlete
		primary key (discipline_id, athlete_id),
	constraint uq_discipline_medal
		unique (discipline_id, medal_id)
);



select
	upper(a.first_name),
	concat(a.last_name, ' comes from ', c.name),
    a.age + a.country_id,
    c.id
from athletes a
join countries c on a.country_id = c.id
where c.name like 'A%';

insert into athletes (first_name, last_name, age, country_id)
select
	upper(a.first_name),
	concat(a.last_name, ' comes from ', c.name),
    a.age + a.country_id,
    c.id
from athletes a
join countries c on a.country_id = c.id
where c.name like 'A%';

select id, name, replace(name, 'weight', '')
from disciplines
where name like '%weight%';

update disciplines
set name = replace(name, 'weight', '')
where name like '%weight%';

select *
from athletes
where age > 35;

delete from athletes
where age > 35;

select c.id, c.name
from countries c
left join athletes a on a.country_id = c.id
where a.id is null
order by c.name desc
limit 15;

select
	concat(a.first_name, ' ', a.last_name) full_name,
    a.age
from athletes a
join disciplines_athletes_medals dam on dam.athlete_id = a.id
order by age, athlete_id
limit 2;

select a.id, a.first_name, a.last_name
from athletes a
left join disciplines_athletes_medals dam on dam.athlete_id = a.id
where dam.medal_id is null
order by a.id;

select
	a.id,
    a.first_name,
    a.last_name,
    count(dam.medal_id) as 'medals_count',
	s.name as 'sport'
from athletes a
join disciplines_athletes_medals dam on dam.athlete_id = a.id
join disciplines d on dam.discipline_id = d.id
join sports s on d.sport_id = s.id
group by a.id, s.name
order by `medals_count` desc, a.first_name
limit 10;

select
	concat(first_name, ' ', last_name) full_name,
    case
		when age < 19 then 'Teenager'
        when age < 26 then 'Young adult'
        else 'Adult'
	end age_group
from athletes
order by age desc, first_name;

delimiter $$
create function udf_total_medals_count_by_country (name VARCHAR(40))
returns int
not deterministic
reads sql data
begin
	return(select
		count(dam.medal_id)
		from countries c
		join athletes a on a.country_id = c.id
		join disciplines_athletes_medals dam on dam.athlete_id = a.id
		where c.name = name);
end$$

delimiter ;

select c.name, udf_total_medals_count_by_country('Bahamas')
from countries c;


delimiter $$
create procedure udp_first_name_to_upper_case(letter char(1))
modifies sql data
begin
	update athletes
	set first_name = upper(first_name)
	where first_name like concat('%', letter);
end$$
delimiter ;


update athletes
set first_name = upper(first_name)
where substring(first_name, -1 ) = 's';

select id, first_name
from athletes
where first_name like concat('%', letter);

call udf_total_medals_count_by_country()