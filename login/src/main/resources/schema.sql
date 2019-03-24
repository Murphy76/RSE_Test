ALTER TABLE IF EXISTS ROLE DROP CONSTRAINT IF EXISTS fk_user_role;
ALTER TABLE IF EXISTS NOTE DROP CONSTRAINT IF EXISTS fk_user_note;
ALTER TABLE IF EXISTS ROLE DROP CONSTRAINT IF EXISTS uni_username_role;
COMMIT;
DROP TABLE if EXISTS USER ;
DROP TABLE if EXISTS ROLE ;
DROP TABLE if EXISTS NOTE;
COMMIT;

CREATE  TABLE  IF NOT EXISTS USER (
USERNAME VARCHAR(45) NOT NULL PRIMARY KEY,
PASSWORD VARCHAR(100) NOT NULL,
ENABLED BOOLEAN);

CREATE TABLE  IF NOT EXISTS ROLE (
  user_id VARCHAR(45) NOT NULL,
  role varchar(45) NOT NULL,
  UNIQUE KEY uni_username_role (user_id,role),
  CONSTRAINT fk_user_role FOREIGN KEY (user_id ) REFERENCES user (USERNAME));

CREATE TABLE  IF NOT EXISTS NOTE (
  ID INT (10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id varchar(45) NOT NULL,
  descr VARCHAR (100) NOT NULL,
  note VARCHAR (4000) NOT NULL,
  CONSTRAINT fk_user_note FOREIGN KEY (user_id ) REFERENCES user (USERNAME));
COMMIT;