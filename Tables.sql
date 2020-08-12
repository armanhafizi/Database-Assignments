
DROP SCHEMA IF EXISTS ticketSeller ;
CREATE SCHEMA IF NOT EXISTS ticketSeller DEFAULT CHARACTER SET utf8 ;
USE ticketSeller ;

-- -----------------------------------------------------
-- Table ticketSeller.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS ticketSeller.`User` ;

CREATE TABLE IF NOT EXISTS ticketSeller.`User` (
  `Email` VARCHAR(100)  NOT NULL CHECK (Email regexp '[a-zA-Z0-9][a-zA-Z0-9._-]*[a-zA-Z0-9._-]@[a-zA-Z0-9][a-zA-Z0-9._-]*[a-zA-Z0-9]\\.[a-zA-Z]{2,4}$'),
  FirstName VARCHAR(45) NOT NULL,
  LastName VARCHAR(45) NOT NULL,
  PhoneNum VARCHAR(10) NOT NULL CHECK (PhoneNum regexp '^[0-9]{10}'),
  PRIMARY KEY (`Email`))
;


-- -----------------------------------------------------
-- Table ticketSeller.`Stadium`
-- -----------------------------------------------------
DROP TABLE IF EXISTS ticketSeller.`Stadium` ;
CREATE TABLE IF NOT EXISTS ticketSeller.`Stadium` (
  `Name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Name`))
;


-- -----------------------------------------------------
-- Table ticketSeller.`Arena`
-- -----------------------------------------------------
DROP TABLE IF EXISTS ticketSeller.`Arena` ;

CREATE TABLE IF NOT EXISTS ticketSeller.`Arena` (
  `Name` VARCHAR(100) NOT NULL,
  `Stadium_Name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Name`, `Stadium_Name`),
  INDEX `fk_Arena_Stadium2_idx` (`Stadium_Name` ASC),
  CONSTRAINT `fk_Arena_Stadium2`
    FOREIGN KEY (`Stadium_Name`)
    REFERENCES ticketSeller.`Stadium` (`Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table ticketSeller.`Event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS ticketSeller.`Event` ;

CREATE TABLE IF NOT EXISTS ticketSeller.`Event` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `Date` DATETIME NOT NULL,
  `Arena_Name` VARCHAR(100) NOT NULL,
  `Arena_Stadium_Name` VARCHAR(100) NOT NULL,
  INDEX `fk_Event_Arena1_idx` (`Arena_Name` ASC, `Arena_Stadium_Name` ASC),
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_Event_Arena1`
    FOREIGN KEY (`Arena_Name` , `Arena_Stadium_Name`)
    REFERENCES ticketSeller.`Arena` (`Name` , `Stadium_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table ticketSeller.`Seat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS ticketSeller.`Seat` ;

CREATE TABLE IF NOT EXISTS ticketSeller.`Seat` (
  `Num` INT NOT NULL,
  `Arena_Name` VARCHAR(100) NOT NULL,
  `Arena_Stadium_Name` VARCHAR(100) NOT NULL,
  `kind` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Num`, `Arena_Name`, `Arena_Stadium_Name`),
  INDEX `fk_Seat_Arena2_idx` (`Arena_Name` ASC, `Arena_Stadium_Name` ASC),
  CONSTRAINT `fk_Seat_Arena2`
    FOREIGN KEY (`Arena_Name` , `Arena_Stadium_Name`)
    REFERENCES ticketSeller.`Arena` (`Name` , `Stadium_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;


-- -----------------------------------------------------
-- Table ticketSeller.`Ticket`
-- -----------------------------------------------------
DROP TABLE IF EXISTS ticketSeller.`Ticket` ;

CREATE TABLE IF NOT EXISTS ticketSeller.`Ticket` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Price` INT NOT NULL,
  PaidMoney INT NOT NULL,
  `User_Email` VARCHAR(100) NOT NULL,
  `Event_ID` INT NOT NULL,
  `Seat_Num` INT NOT NULL,
  `Seat_Arena_Name` VARCHAR(100) NOT NULL,
  `Seat_Arena_Stadium_Name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Ticket_User1_idx` (`User_Email` ASC),
  INDEX `fk_Ticket_Event1_idx` (`Event_ID` ASC),
  INDEX `fk_Ticket_Seat1_idx` (`Seat_Num` ASC, `Seat_Arena_Name` ASC, `Seat_Arena_Stadium_Name` ASC),
  CONSTRAINT `fk_Ticket_User1`
    FOREIGN KEY (`User_Email`)
    REFERENCES ticketSeller.`User` (`Email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ticket_Event1`
    FOREIGN KEY (`Event_ID`)
    REFERENCES ticketSeller.`Event` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ticket_Seat1`
    FOREIGN KEY (`Seat_Num` , `Seat_Arena_Name` , `Seat_Arena_Stadium_Name`)
    REFERENCES ticketSeller.`Seat` (`Num` , `Arena_Name` , `Arena_Stadium_Name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
;



-- -----------------------------------------------------
-- Table ticketSeller.`LOG`
-- -----------------------------------------------------



create table LOG (
  LOGNUM int primary key auto_increment,
  kind varchar(100) not null ,
  TicketID int not null,
  customerID varchar(100) not null,
  eventID int not null,
  Arena varchar(100) not null
);