SET PASSWORD FOR root@localhost=PASSWORD('Root1234');
grant all privileges on *.* to 'root'@'10.0.2.2';
UPDATE mysql.user SET Password=PASSWORD('') WHERE User='root';
FLUSH PRIVILEGES;
