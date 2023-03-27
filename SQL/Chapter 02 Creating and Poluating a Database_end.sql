DROP DATABASE IF EXISTS person;

create database person;

-- switch to person database

use person;

-- create a person table

CREATE TABLE person
 (person_id SMALLINT UNSIGNED,
  fname VARCHAR(20),
  lname VARCHAR(20),
  eye_color CHAR(2),
  birth_date DATE,
  street VARCHAR(30),
  city VARCHAR(20),
  state VARCHAR(20),
  country VARCHAR(20),
  postal_code VARCHAR(20),
  CONSTRAINT pk_person PRIMARY KEY (person_id)
 );

-- add a check constriant to eye_color

drop table if exists person;

CREATE TABLE person
 (person_id SMALLINT UNSIGNED,
  fname VARCHAR(20),
  lname VARCHAR(20),
  eye_color CHAR(2),
  birth_date DATE,
  street VARCHAR(30),
  city VARCHAR(20),
  state VARCHAR(20),
  country VARCHAR(20),
  postal_code VARCHAR(20),
  CONSTRAINT pk_person PRIMARY KEY (person_id),
  CHECK (eye_color IN ('BR', 'BL', 'GR'))
 );

-- look at the columns of the person table

desc person;

CREATE TABLE favorite_food
    (person_id SMALLINT UNSIGNED,
     food VARCHAR(20),
     CONSTRAINT pk_favorite_food PRIMARY KEY (person_id, food),
     CONSTRAINT fk_fav_food_person_id FOREIGN KEY (person_id)
     REFERENCES person (person_id)
    );
    
desc favorite_food;

-- let MySQL automatically generates a unique number of person_id in person table

ALTER TABLE person 
MODIFY person_id SMALLINT UNSIGNED AUTO_INCREMENT;
    
-- the above code will generate an error message since person_id is a foreign key in favorite food table
-- we need to disable foreign key check first

set foreign_key_checks=0;
ALTER TABLE person
	MODIFY person_id smallint unsigned auto_increment;
set foreign_key_checks=1;

describe person;

-- insert record into person table. insert null for auto_increment column

INSERT INTO person
 (person_id, fname, lname, eye_color, birth_date)
 value(null, 'William', 'Turner', 'BR', '1972-05-27');

-- look at added row
select *
from person
where person_id=1;

-- Willaim has three favorite food: pizza, cookies and nachos
insert into favorite_food (person_id, food)
            values(1, 'pizza');
            
-- check new added record

select *
from favorite_food;

-- insert the other twoo favorite food for William
insert into favorite_food (person_id, food)
            values(1, 'cookies');
insert into favorite_food (person_id, food)
           values(1, 'nachos');

-- retrieve favoriate food for William

select food
from favorite_food
where person_id=1
order by food;

-- add another person into person table
INSERT INTO person
	(person_id, fname, lname, eye_color, birth_date, street, city, state, country, postal_code)
    values(null, 'Susan', 'Smith', 'BL', '1975-11-02', '23 Maple St.', 'Arlington', 'VA', 'USA', '20220');

select *
from person;

-- Updating data
update person
set street='1255 Tremont St.',
city='Boston',
state='MA',
country='USA',
postal_code='02138'
where person_id=1;

select *
from person;

-- Deleting data
DELETE from person
where person_id=2;

-- When good statement go bad
-- you cannot insert a new record with an existing primary key
-- primary key violation

insert into person (person_id, lname, fname)
	values (1, 'Joe', 'Smith');
    
-- you cannot insert a no-existing foreign key in favorite food table
-- foreigh key violation
insert into favorite_food (person_id, food)
values(4, 'noodle');

-- check constraint violation
UPDATE person 
SET 
    eye_color = 'ZZ'
WHERE
    person_id = 1;

-- invalid Date Conversion
update person
set birth_date='09/07/1980'
where person_id=1;

-- use str_to_date to do Date Conversion
/* formatter for converting date string to date:
%a The short weekday name, such as Sun, Mon, ...
%b The short month name, such as Jan, Feb, ...
%c The numeric month (0..12)
%d The numeric day of the month (00..31)
%f The number of microseconds (000000..999999)
%H The hour of the day, in 24-hour format (00..23)
%h The hour of the day, in 12-hour format (01..12)
%i The minutes within the hour (00..59)
%j The day of year (001..366)
%M The full month name (January..December)
%m The numeric month
%p AM or PM
%s The number of seconds (00..59)
%W The full weekday name (Sunday..Saturday)
%w The numeric day of the week (0=Sunday..6=Saturday)
%Y The four-digit year
*/

update person
set birth_date=str_to_date('09/07/1980', '%m/%d/%Y')
where person_id=1;

select *
from person;















