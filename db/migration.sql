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
	'FrOSCon 2017',
--	UNIX_TIMESTAMP('2017-08-18'),
--	UNIX_TIMESTAMP('2017-08-19'),
--	UNIX_TIMESTAMP('2017-08-20'),
--	UNIX_TIMESTAMP('2017-08-20'),
	NULL,
	NULL,
	NULL,
	NULL,
	'Welcome to FrOSCon'
);

INSERT INTO AngelTypes
	SELECT *,0,1,'','',''
	FROM helfer_2016.AngelTypes
;
INSERT INTO AngelTypes (name,restricted,description) VALUES
	('Sani', 1, 'Helfer für Sanitäter / Volunteer for rescue team'),
	('PoC', 1, 'Helfer für das PoC / Volunteer for PoC')
;

INSERT INTO Room
	SELECT * FROM helfer_2016.Room
	WHERE FromPentabarf != 'Y'
;
INSERT INTO ShiftTypes
	SELECT * FROM helfer_2016.ShiftTypes
;

INSERT INTO Shifts
	SELECT S.* FROM helfer_2016.Shifts AS S
	INNER JOIN helfer_2016.Room AS R USING(RID)
	WHERE R.FromPentabarf != 'Y' AND S.title NOT LIKE '%recruiting%'
;
UPDATE Shifts SET edited_by_user_id = 1, start = start + 31449600, end = end + 31449600 ;

INSERT INTO NeededAngelTypes
	SELECT N.* FROM helfer_2016.NeededAngelTypes AS N
	LEFT JOIN Room AS R ON (room_id=RID)
	LEFT JOIN Shifts AS S ON (shift_id=SID)
	WHERE R.RID IS NOT NULL OR S.SID IS NOT NULL
;

COMMIT ;
SET FOREIGN_KEY_CHECKS = 1;
