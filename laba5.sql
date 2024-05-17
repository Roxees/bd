Просмотр существующих ролей в БД
SELECT rolname FROM pg_roles;
2. Создание отдельных ролей на чтение, вставку, обновление и удаление данных для схемы

CREATE ROLE read_only;
CREATE ROLE insert_only;
CREATE ROLE update_only;
CREATE ROLE delete_only;
3. Создание пользователя с возможностью подключения к БД

CREATE USER new_user WITH PASSWORD 'password123';
Присвоение прав на создание и изменение БД:


ALTER USER new_user CREATEDB;
4. Изменение пароля для созданного пользователя и определение срока действия пароля

ALTER USER new_user WITH PASSWORD 'new_password123';
ALTER USER new_user VALID UNTIL '2025-01-01'; -- Пример срока действия пароля
5. Создание пользователя Admin и присвоение ему роли с полным доступом к БД

CREATE USER admin_user WITH PASSWORD 'admin_password';
GRANT ALL PRIVILEGES ON DATABASE your_database TO admin_user;
6. Создание пользователя User и присвоение ему роли только для чтения записей из БД

CREATE USER regular_user WITH PASSWORD 'user_password';
GRANT SELECT ON ALL TABLES IN SCHEMA your_schema TO regular_user;
7. Запрет просмотра определенных таблиц и столбцов для пользователя User

REVOKE SELECT ON your_table FROM regular_user;
8. Создание пользователя Manager и разрешение ему просматривать и обновлять записи в БД

CREATE USER manager_user WITH PASSWORD 'manager_password';
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA your_schema TO manager_user;
9. Удаление пользователя Manager

DROP USER manager_user;
10. Создание группы ролей managers и добавление прав на чтение, вставку и обновление записей в БД

CREATE ROLE managers;
GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA your_schema TO managers;
11. Создание заново пользователя Manager и добавление его в группу ролей managers

CREATE USER manager_user WITH PASSWORD 'manager_password';
GRANT managers TO manager_user;
12. Создание пользователя с различными правами на разные таблицы без добавления его в группу ролей

CREATE USER special_user WITH PASSWORD 'special_password';
GRANT SELECT ON table1 TO special_user;
GRANT INSERT ON table2 TO special_user;
GRANT UPDATE ON table3 TO special_user;
GRANT DELETE ON table4 TO special_user;