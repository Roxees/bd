Запрос на подсчет количества строк в таблице, удовлетворяющих заданному условию (COUNT)
SELECT COUNT(*) AS КоличествоУчастников FROM Участники WHERE Рейтинг > 2400;
Запрос на подсчет среднего значения в каком-либо столбце таблицы (функция AVG)
SELECT AVG(Рейтинг) AS СреднийРейтинг FROM Участники;
Запрос на подсчет суммы значений какого-либо столбца в таблице (функция SUM)
SELECT SUM(Рейтинг) AS СуммаРейтингов FROM Участники;
Запрос на нахождение максимального значения в столбце таблицы (функция MAX)
SELECT MAX(Рейтинг) AS МаксимальныйРейтинг FROM Участники;
Запрос на нахождение минимального значения в столбце таблицы (функция MIN)
SELECT MIN(Рейтинг) AS МинимальныйРейтинг FROM Участники;
Запрос на нахождение минимального значения в столбце таблицы без использования функции MIN, применяя ORDER BY и LIMIT
SELECT Рейтинг FROM Участники ORDER BY Рейтинг ASC LIMIT 1;
Запрос на нахождение максимального значения в столбце таблицы без использования функции MAX, применяя ORDER BY DESC и LIMIT
SELECT Рейтинг FROM Участники ORDER BY Рейтинг DESC LIMIT 1;
Запрос с группировкой строк и подсчетом значения любой агрегатной функции по каждой группе (GROUP BY)
SELECT ТурнирID, COUNT(*) AS КоличествоУчастников FROM Участники GROUP BY ТурнирID;
Запрос с соединением не менее, чем 2-х таблиц, группировкой строк и подсчетом значения любой агрегатной функции по каждой группе (GROUP BY)
SELECT t.Название, COUNT(p.ПартияID) AS КоличествоПартий
FROM Турниры t
JOIN Партии p ON t.ТурнирID = p.ТурнирID
GROUP BY t.Название;
Запрос SELECT с использованием вложенного подзапроса SELECT
SELECT Имя, Рейтинг
FROM Участники
WHERE ТурнирID = (
SELECT ТурнирID
FROM Партии
GROUP BY ТурнирID
ORDER BY COUNT(*) DESC
LIMIT 1
);
Запрос INSERT с использованием вложенного подзапроса SELECT
  INSERT INTO Участники (Имя, Рейтинг, ТурнирID)
SELECT Имя, Рейтинг, 2
FROM Участники
WHERE ТурнирID = 1;
Запрос на объединение результатов запросов с использованием UNION
  SELECT Имя FROM Участники WHERE ТурнирID = 1
UNION
SELECT Имя FROM Участники WHERE ТурнирID = 2;
Запрос на соединение таблиц с использованием JOIN (все виды)
  -- Внутреннее соединение (INNER JOIN)
SELECT u.Имя, t.Название
FROM Участники u
INNER JOIN Турниры t ON u.ТурнирID = t.ТурнирID;

-- Левое соединение (LEFT JOIN)
SELECT u.Имя, t.Название
FROM Участники u
LEFT JOIN Турниры t ON u.ТурнирID = t.ТурнирID;

-- Правое соединение (RIGHT JOIN)
SELECT u.Имя, t.Название
FROM Участники u
RIGHT JOIN Турниры t ON u.ТурнирID = t.ТурнирID;

-- Полное соединение (FULL JOIN)
SELECT u.Имя, t.Название
FROM Участники u
FULL JOIN Турниры t ON u.ТурнирID = t.ТурнирID;
