-- Active: 1747490419603@@127.0.0.1@5432@mynewdb1
CREATE TABLE sobi (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50)
);
INSERT INTO sobi(name, email) VALUES
('masud', 'ma@gmail.com'),
('rana', 'ra@gmail.com');

ALTER TABLE sobi
drop COLUMN adress VARCHAR(100);



SELECT*from sobi;