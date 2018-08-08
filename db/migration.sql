SET FOREIGN_KEY_CHECKS = 0;
START TRANSACTION ;

TRUNCATE TABLE AngelTypes ;
TRUNCATE TABLE EventConfig ;
TRUNCATE TABLE NeededAngelTypes ;
TRUNCATE TABLE Room ;
TRUNCATE TABLE ShiftTypes ;
TRUNCATE TABLE Shifts ;
TRUNCATE TABLE ShiftEntry ;

UPDATE Groups
SET Name = '2-Helfer'
WHERE Name = '2-Engel'
;

INSERT INTO EventConfig
VALUES (
	'FrOSCon 2018',
	UNIX_TIMESTAMP('2018-08-24'),
	UNIX_TIMESTAMP('2018-08-25'),
	UNIX_TIMESTAMP('2018-08-26'),
	UNIX_TIMESTAMP('2018-08-26'),
	'Welcome to FrOSCon'
);

INSERT INTO AngelTypes
	SELECT *
	FROM helfer_2017.AngelTypes
;

INSERT INTO Room (RID, Name, from_frab, description)
	SELECT RID, Name, FromPentabarf, Name FROM helfer_2017.Room
	WHERE FromPentabarf != 'Y'
;
INSERT INTO ShiftTypes
	SELECT * FROM helfer_2017.ShiftTypes
;

INSERT INTO Shifts
	SELECT S.* FROM helfer_2017.Shifts AS S
	INNER JOIN helfer_2017.Room AS R USING(RID)
	WHERE R.FromPentabarf != 'Y' AND S.title NOT LIKE '%recruiting%'
;
UPDATE Shifts SET edited_by_user_id = 1, start = start + 32054400, end = end + 32054400 ;

INSERT INTO NeededAngelTypes
	SELECT N.* FROM helfer_2017.NeededAngelTypes AS N
	LEFT JOIN Room AS R ON (room_id=RID)
	LEFT JOIN Shifts AS S ON (shift_id=SID)
	WHERE R.RID IS NOT NULL OR S.SID IS NOT NULL
;

COMMIT ;
SET FOREIGN_KEY_CHECKS = 1;
