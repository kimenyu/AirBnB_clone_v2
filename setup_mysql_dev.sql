--creating a databse called hbnb_dev_db
CREATE DATABASE IF NOT EXISTS hbnb_dev_db;
--creating a new user 
CREATE USER IF NOT EXISTS 'hbnb_dev'@'localhost' IDENTIFIED BY 'hbnb_dev_pwd';
--hbnb_dev should have all privileges on the database hbnb_dev_db (and only this database)
GRANT ALL PRIVILEGES ON *.* TO 'hbnb_dev'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
--hbnb_dev should have SELECT privilege on the database performance_schema (and only this database)
GRANT SELECT ON performance_schema.* TO 'hbnb_dev'@'localhost';
FLUSH PRIVILEGES;
