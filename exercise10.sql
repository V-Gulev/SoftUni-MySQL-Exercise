delimiter $$
create procedure usp_get_employees_salary_above_35000()
begin
	select first_name, last_name
	from employees
	where salary > 35000
	order by first_name, last_name, employee_id;
end$$
delimiter ;
call usp_get_employees_salary_above_35000();

create procedure usp_get_employees_salary_above(in target_salary decimal(12,4))
	select first_name, last_name
	from employees
	where salary >= target_salary
	order by first_name, last_name, employee_id;

call usp_get_employees_salary_above(100000);

create procedure usp_get_towns_starting_with(in search_string text)
	select name town_name
	from towns
	where name like concat(search_string, '%')
    order by town_name;

call usp_get_towns_starting_with('s');

create procedure usp_get_employees_from_town(in town_name text)
	select e.first_name, e.last_name
    from employees e
    join addresses a on e.address_id = a.address_id
    join towns t on t.town_id = a.town_id
    where t.name = town_name
    order by e.first_name, e.last_name, e.employee_id;

call usp_get_employees_from_town('Sofia');

delimiter $$
create function ufn_get_salary_level(salary decimal(12, 4))
returns varchar(8)
deterministic
begin
	return case
				when salary < 30000 then 'Low'
                when salary <= 50000 then 'Average'
                else 'High'
			end;
end$$

delimiter ;

select ufn_get_salary_level(40000);

create procedure usp_get_employees_by_salary_level(salary_level varchar(8))
select first_name, last_name
from employees
where ufn_get_salary_level(salary) = salary_level
order by first_name desc, last_name desc;

call usp_get_employees_by_salary_level('High');

delimiter $$
create function ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
returns int
deterministic
begin
	declare i int default 1;
    declare c char(1);

    while i <= length(word) do
		set c = substring(word, i, 1);
		if locate(c, set_of_letter) = 0
			then return 0;
		end if;
        set i = i + 1;
	end while;
    return 1;
end$$

delimiter ;

create function ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
returns int
    return word RegExp(concat('^[', set_of_letters, ']+$'));

select *
from account_holders;
select *
from accounts;

create procedure usp_get_holders_full_name()
select concat(first_name, ' ' , last_name) as full_name
from account_holders
order by full_name, id;

create function ufn_calculate_future_value(initial_amount decimal(12,4), interest_rate double(12,4), years int)
returns decimal(12,4)
deterministic
return initial_amount * (pow((1 + interest_rate), years));

select ufn_calculate_future_value(1000, 0.5 , 5);

create procedure usp_calculate_future_value_for_account(in account_id int, in interest_rate double(12,4))
select a.id as account_id, ah.first_name, ah.last_name, a.balance as current_balance, ufn_calculate_future_value(a.balance, interest_rate, 5) as balance_in_5_years
from account_holders ah
join accounts a on a.account_holder_id = ah.id
where a.id = account_id;

delimiter $$
create procedure usp_transfer_money(from_account_id int, to_account_id int, money_amount decimal(19,4))
begin
	start transaction;
    if (select count(*) from accounts where id = from_account_id) != 1
    or (select count(*) from accounts where id = to_account_id) != 1
    or from_account_id = to_account_id
    or (select balance from accounts where id = from_account_id) - money_amount < 0
    or money_amount <= 0
		then rollback;
	else
		update accounts
        set balance = balance - money_amount
        where id = from_account_id;

        update accounts
        set balance = balance + money_amount
        where id = to_account_id;

        commit;
	end if;
end$$

delimiter ;
select balance from accounts
where id = 1;


create table logs (
	log_id int primary key auto_increment,
    old_sum decimal(19,4),
    new_sum decimal(19, 4)
);

delimiter $$
create trigger trg_account_changes
after update on accounts
for each row
begin
	if OLD.balance != NEW.balance then
		insert into logs
		values (NEW.id, OLD.balance, NEW.balance);
    end if;
end$$
delimiter ;

update accounts
set balance = 0
where id = 1;

select *
from accounts;

select *
from logs;