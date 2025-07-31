SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

CREATE DATABASE Farmer;
USE Farmer;

-- Create the user table with a primary key
CREATE TABLE user (
  id int NOT NULL AUTO_INCREMENT,
  username varchar(50) NOT NULL,
  email varchar(50) NOT NULL,
  password varchar(500) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO user (username, email, password) VALUES
('Test', 'test@gmail.com', 'test1234'),
('Bala', 'bala1@gmail.com', 'bala1234'),
('Chitra', 'chitra1@gmail.com', 'chitra1234'),
('Divya', 'divya1@gmail.com', 'divya1234'),
('Eshwar', 'eshwar1@gmail.com', 'eshwar1234'),
('Gita', 'gita1@gmail.com', 'gita1234'),
('Hari', 'hari1@gmail.com', 'hari1234'),
('Indra', 'indra1@gmail.com', 'indra1234'),
('Jaya', 'jaya1@gmail.com', 'jaya1234'),
('Kiran', 'kiran1@gmail.com', 'kiran1234'),
('Lakshmi', 'lakshmi1@gmail.com', 'lakshmi1234'),
('Manoj', 'manoj1@gmail.com', 'manoj1234'),
('Nina', 'nina1@gmail.com', 'nina1234'),
('Omkar', 'omkar1@gmail.com', 'omkar1234'),
('Priya', 'priya1@gmail.com', 'priya1234'),
('Rahul', 'rahul1@gmail.com', 'rahul1234');

-- Create the product table with a primary key and foreign key referencing the user table
CREATE TABLE product (
  pid int(11) NOT NULL AUTO_INCREMENT,
  user_id int(11) NOT NULL,
  productname varchar(100) NOT NULL,
  productdesc text NOT NULL,
  price int(11) NOT NULL,
  PRIMARY KEY (pid),
  FOREIGN KEY (user_id) REFERENCES user (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO product (user_id, productname, productdesc, price) VALUES
(1, 'GIRIJA CAULIFLOWER', 'Tips for Growing Cauliflower. Well drained medium loam and or sandy loam soils are suitable.', 520),
(2, 'WHEAT', 'Wheat is a grass widely cultivated for its seed, a cereal grain which is a worldwide staple food.', 320),
(3, 'RICE', 'Rice is the seed of the grass species Oryza sativa or Oryza glaberrima.', 450),
(4, 'BARLEY', 'Barley is a member of the grass family, a major cereal grain grown in temperate climates globally.', 210),
(5, 'OATS', 'Oats are a species of cereal grain grown for its seed, which is known by the same name.', 180),
(6, 'SOYBEAN', 'Soybean is a species of legume native to East Asia, widely grown for its edible bean.', 540),
(7, 'POTATO', 'The potato is a root vegetable native to the Americas, a starchy tuber of the plant Solanum tuberosum.', 400),
(8, 'SUGARCANE', 'Sugarcane is a tropical grass native to Southeast Asia, cultivated for its juice from which sugar is processed.', 730),
(9, 'TOBACCO', 'Tobacco is a product prepared from the leaves of the tobacco plant by curing them.', 150),
(10, 'PEANUT', 'Peanut is a legume crop grown mainly for its edible seeds.', 380),
(11, 'COFFEE', 'Coffee is a brewed drink prepared from roasted coffee beans, the seeds of berries from certain Coffea species.', 250),
(12, 'TEA', 'Tea is an aromatic beverage commonly prepared by pouring hot or boiling water over cured or fresh tea leaves.', 340),
(13, 'COCOA', 'Cocoa is a bean from which cocoa solids and cocoa butter are extracted, used to make chocolate.', 290),
(14, 'OLIVE', 'Olive is a small tree in the family Oleaceae, cultivated in many parts of the world for its fruit and oil.', 210),
(15, 'GRAPE', 'Grapes are a fruit, botanically a berry, of the deciduous woody vines of the flowering plant genus Vitis.', 430),
(16, 'COTTON', 'Cotton is a soft, fluffy staple fiber that grows in a boll, around the seeds of the cotton plant.', 600);

-- Create the farming table with a primary key
CREATE TABLE farming (
  fid int NOT NULL AUTO_INCREMENT,
  farmingtype varchar(200) NOT NULL,
  PRIMARY KEY (fid)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO farming (farmingtype) VALUES
('CAULI Flower'),
('Wheat'),
('Rice'),
('Barley'),
('Oats'),
('SoyaBean'),
('Potato'),
('SugerCane'),
('Tobacco'),
('Peanut'),
('Coffee'),
('Tea'),
('Cocoa'),
('Olive'),
('Grape'),
('Cotton');

-- Create the register table with a primary key and foreign key referencing the farming table
CREATE TABLE register (
  rid int NOT NULL AUTO_INCREMENT,
  farmername varchar(50) NOT NULL,
  adharnumber varchar(20) NOT NULL,
  age int NOT NULL,
  gender varchar(50) NOT NULL,
  phonenumber varchar(12) NOT NULL,
  address varchar(50) NOT NULL,
  fid int NOT NULL,
  PRIMARY KEY (rid),
  FOREIGN KEY (fid) REFERENCES farming (fid) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create the trigger log table
CREATE TABLE trig (
  id int NOT NULL AUTO_INCREMENT,
  rid int NOT NULL,
  action varchar(50) NOT NULL,
  timestamp datetime NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO trig (rid, action, timestamp) VALUES
(2, 'FARMER UPDATED', '2024-05-29 16:04:44'),
(2, 'FARMER DELETED', '2024-05-19 14:04:58'),
(8, 'Farmer Inserted', '2024-05-13 13:16:52'),
(8, 'FARMER UPDATED', '2024-05-07 12:17:17'),
(8, 'FARMER DELETED', '2024-05-03 10:18:54');

-- Triggers for the register table
DELIMITER $$
CREATE TRIGGER deletion BEFORE DELETE ON register FOR EACH ROW 
BEGIN
    INSERT INTO trig (rid, action, timestamp) VALUES (OLD.rid, 'FARMER DELETED', NOW());
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER insertion AFTER INSERT ON register FOR EACH ROW 
BEGIN
    INSERT INTO trig (rid, action, timestamp) VALUES (NEW.rid, 'FARMER INSERTED', NOW());
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER updation AFTER UPDATE ON register FOR EACH ROW 
BEGIN
    INSERT INTO trig (rid, action, timestamp) VALUES (NEW.rid, 'FARMER UPDATED', NOW());
END$$
DELIMITER ;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;