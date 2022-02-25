use mysql;
show tables;
select * from user;

CREATE USER 'usuario_lectura'@'localhost' identified by '1234';
CREATE USER 'usuario_lim'@'localhost' identified by '9876';

#DROP USER 'usuario_lectura'@'localhost';
#DROP USER 'usuario_lim'@'localhost'
ALTER USER 'usuario_lectura'@'localhost' identified by '9876';

SHOW GRANTS FOR 'usuario_lectura'@'localhost';
SHOW GRANTS FOR 'usuario_lim'@'localhost';


GRANT SELECT ON juegosolimpicos.* TO 'usuario_lectura'@'localhost'; 

GRANT SELECT, INSERT, UPDATE ON juegosolimpicos.* TO 'usuario_lim'@'localhost';

