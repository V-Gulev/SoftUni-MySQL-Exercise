create database foods_friends;
use foods_friends;

create table restaurants(
	id int primary key auto_increment,
	name varchar(40) not null unique,
    type varchar(20) not null,
    non_stop boolean not null
);

create table offerings(
	id int primary key auto_increment,
    name varchar(40) not null unique,
	price decimal(19,2) not null,
    vegan boolean not null,
    restaurant_id int not null,
    constraint fk_offerings_restaurants
		foreign key (restaurant_id) references restaurants(id)
);

create table customers(
	id int primary key auto_increment,
    first_name varchar(40) not null,
    last_name varchar(40) not null,
    phone_number varchar(20) not null unique,
    regular boolean not null,
	constraint uq_first_last_name unique (first_name, last_name)
);

create table orders(
	id int primary key auto_increment,
    number varchar(10) not null unique,
    priority varchar(10) not null,
    customer_id int not null,
    restaurant_id int not null,
    constraint fk_orders_customers
		foreign key (customer_id) references customers(id),
	constraint fk_orders_restaurants
		foreign key (restaurant_id) references restaurants(id)
);

create table orders_offerings(
	order_id int not null,
    offering_id int not null,
    restaurant_id int not null,
    primary key (order_id, offering_id),
    constraint fk_orders_offerings_orders
		foreign key (order_id) references orders(id),
	constraint fk_orders_offerings_offerings
		foreign key (offering_id) references offerings(id),
	constraint fk_orders_offerings_restaurants
		foreign key (restaurant_id) references restaurants(id)
);


insert into offerings(name, price, vegan, restaurant_id)
select
	concat(name, ' costs:'),
    price,
    vegan,
    restaurant_id
from offerings
where name like 'Grill%';

update offerings
set name = upper(name)
where name like '%Pizza%';

delete from restaurants
where name like '%fast%' or type like '%fast%';

select o.name, o.price
from offerings o
join restaurants r on r.id = o.restaurant_id
where r.name like 'Burger Haven';

select c.id, c.first_name, c.last_name
from customers c
left join orders o on o.customer_id = c.id
where o.customer_id is null
order by c.id;

select o.id, o.name
from offerings o
join orders_offerings oo on o.id = oo.offering_id
join orders ord on ord.id = oo.order_id
join customers c on ord.customer_id = c.id
where concat(c.first_name, ' ', c.last_name) like 'Sofia Sanchez' and vegan is false
order by o.id;

select distinct r.id, r.name
from restaurants r
join orders o on o.restaurant_id = r.id
join customers c on c.id = o.customer_id
join offerings offer on offer.restaurant_id = r.id
where c.regular is true and offer.vegan is true and o.priority like 'HIGH'
order by r.id;

select
	name offering_name,
    case
		when price <= 10 then 'cheap'
        when price <= 25 then 'affordable'
        else 'expensive'
    end price_category
from offerings
order by price desc, name;

delimiter $$
create function udf_get_offerings_average_price_per_restaurant (restaurant_name VARCHAR(40))
returns decimal(19,2)
deterministic
reads sql data
begin
	return(select round(avg(o.price), 2)
	from restaurants r
	join offerings o on r.id = o.restaurant_id
	where r.name like restaurant_name
	group by r.id);
end$$

delimiter ;

select round(avg(o.price), 2)
	from restaurants r
	join offerings o on r.id = o.restaurant_id
	where r.name like 'Burger Haven'
	group by r.id;

select udf_get_offerings_average_price_per_restaurant('Burger Haven');


delimiter $$
create procedure udp_update_prices(restaurant_type VARCHAR(40))
modifies sql data
begin
	update offerings o
    join restaurants r on o.restaurant_id = r.id
    set price = price + 5.00
	where r.non_stop is true and r.type like restaurant_type;
end$$

delimiter ;