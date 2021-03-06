USE JUEGOSOLIMPICOS;


SELECT * FROM HECHOSATHLETE;
SELECT * FROM ATHLETE;
SELECT * FROM MEDAL;


DELIMITER #
CREATE FUNCTION GET_MEDAL_AHTLETE(PARAM_ATHLETE INT)
RETURNS CHAR(50)
READS SQL DATA
DETERMINISTIC
BEGIN 
	DECLARE MEDAL_ATHLETE CHAR(50);
    SELECT M.MEDAL INTO MEDAL_ATHLETE
    FROM MEDAL M
    WHERE ID_MEDAL=PARAM_ATHLETE;
RETURN MEDAL_ATHLETE;
END #
DELIMITER ;


DROP FUNCTION GET_MEDAL_AHTLETE;


SELECT H.ID_ATHLETE, GET_MEDAL_AHTLETE(ID_MEDAL) AS NAMEMEDAL FROM HECHOSATHLETE H;
SELECT H.ID_ATHLETE, H.ID_MEDAL, GET_MEDAL_AHTLETE(ID_MEDAL) AS NAMEMEDAL FROM HECHOSATHLETE H;




DELIMITER #
CREATE FUNCTION GET_MEDAL_AHTLETE1(PARAM_ATHLETE INT)
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN 
	DECLARE MEDAL_ATHLETE INT;
    SELECT COUNT(ID_MEDAL) INTO MEDAL_ATHLETE
    FROM HECHOSATHLETE
    WHERE ID_MEDAL=PARAM_ATHLETE;
RETURN MEDAL_ATHLETE;
END #
DELIMITER ;

DROP FUNCTION GET_MEDAL_AHTLETE1;

SELECT GET_MEDAL_AHTLETE1(1) AS MEDAL_NA;
SELECT GET_MEDAL_AHTLETE1(2) AS MEDAL_GOLD;
SELECT GET_MEDAL_AHTLETE1(3) AS MEDAL_BRONZE;
SELECT GET_MEDAL_AHTLETE1(4) AS MEDAL_SILVER;


