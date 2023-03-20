CREATE DATABASE fashionstore;

USE fashionstore

CREATE TABLE users(
id int identity(1,1) primary key,
fullname nvarchar(50),
email nvarchar(50),
username varchar(30),
password varchar(30),
)

CREATE TABLE product(
pid int identity(1,1) primary key,
pname nvarchar(50),
price smallmoney,
preview varchar(50)
)


INSERT INTO product(pname, price, preview) VALUES('Yello sneaker', 59.99, 'images/shoes/g1.png');
INSERT INTO product(pname, price, preview) VALUES('Blue sport nike', 49.99, 'images/shoes/g2.png');
INSERT INTO product(pname, price, preview) VALUES('Puma highneck', 19.99, 'images/shoes/g3.png');
INSERT INTO product(pname, price, preview) VALUES('Nike red', 29.99, 'images/shoes/g4.png');
INSERT INTO product(pname, price, preview) VALUES('Leather shoes', 89.99, 'images/shoes/g5.png');
INSERT INTO product(pname, price, preview) VALUES('Cooler Leather shoes', 79.99, 'images/shoes/g11.png');
INSERT INTO product(pname, price, preview) VALUES('Nike rep11', 39.99, 'images/shoes/g9.png');
INSERT INTO product(pname, price, preview) VALUES('Simple women shoes', 9.99, 'images/shoes/g10.png');
select * from product

drop table users
INSERT INTO users(fullname, email, username, password) VALUES('Hieu Thai', 'thai@mail.com', 'thai123', '123')

select * from users