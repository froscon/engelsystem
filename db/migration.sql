SET FOREIGN_KEY_CHECKS = 0;
START TRANSACTION ;

TRUNCATE TABLE NeededAngelTypes ;
TRUNCATE TABLE AngelTypes ;
TRUNCATE TABLE event_config ;
TRUNCATE TABLE rooms ;
TRUNCATE TABLE ShiftTypes ;
TRUNCATE TABLE Shifts ;
TRUNCATE TABLE ShiftEntry ;

SET FOREIGN_KEY_CHECKS = 1;

UPDATE Groups
SET Name = '2-Helfer'
WHERE Name = '2-Engel'
;

INSERT INTO event_config (name, value)
VALUES
  ('name', """FrOSCon 2022"""),
	('welcome_msg', """Welcome to FrOSCon"""),
	('buildup_start', """2022-08-19"""),
	('event_start', """2022-08-20"""),
	('event_end', """2022-08-21"""),
	('teardown_end', """2022-08-21""");

INSERT INTO AngelTypes
	SELECT *
	FROM helfer_2019.AngelTypes
;

INSERT INTO rooms (id, name, map_url, description)
	SELECT RID, name, map_url, description
  FROM helfer_2019.Room
;

INSERT INTO ShiftTypes
	SELECT *
  FROM helfer_2019.ShiftTypes
;

INSERT INTO Shifts (SID, title, shifttype_id, start, end, RID, URL, created_at_timestamp, edited_at_timestamp)
  SELECT SID, title, shifttype_id, start, end, RID, URL, created_at_timestamp, edited_at_timestamp
  FROM helfer_2019.Shifts
;
UPDATE Shifts SET created_by_user_id = 1, edited_by_user_id = 1, start = start + 95558400, end = end + 95558400, created_at_timestamp=UNIX_TIMESTAMP(), edited_at_timestamp=UNIX_TIMESTAMP();

INSERT INTO NeededAngelTypes
 	SELECT *
  FROM helfer_2019.NeededAngelTypes
;

COMMIT ;
