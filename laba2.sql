SELECT * FROM Турниры;
SELECT * FROM Участники;
SELECT * FROM Партии;
SELECT Название, Место FROM Турниры;
SELECT Имя, Рейтинг FROM Участники;
SELECT ТурнирID, Результат FROM Партии;
SELECT * FROM Участники WHERE Рейтинг > 2400;
SELECT * FROM Турниры WHERE ДатаНачала > '2024-07-01';
SELECT * FROM Участники WHERE Рейтинг BETWEEN 2300 AND 2500;
SELECT * FROM Турниры WHERE ДатаНачала BETWEEN '2024-06-01' AND '2024-07-01';
SELECT * FROM Участники WHERE Имя LIKE 'А%';
SELECT * FROM Турниры WHERE Место LIKE '%бург';
SELECT * FROM Участники WHERE ТурнирID IN (1, 3);
SELECT * FROM Партии WHERE Результат IN ('1-0', '0.5-0.5');
SELECT * FROM Участники ORDER BY Рейтинг DESC;
SELECT * FROM Турниры ORDER BY ДатаНачала;
SELECT * FROM Участники ORDER BY Рейтинг DESC LIMIT 3;
SELECT * FROM Турниры ORDER BY ДатаНачала LIMIT 2;
SELECT * FROM Участники, Партии WHERE Участники.ТурнирID = Партии.ТурнирID;
Запрос, получающий соединение связанных таблиц по ключу
SELECT Участники.Имя, Партии.Результат
FROM Участники
JOIN Партии ON Участники.УчастникID = Партии.УчастникБелыми OR Участники.УчастникID = Партии.УчастникЧёрными;
Запрос, получающий соединение таблицы со своей копией
SELECT A.Имя AS Белые, B.Имя AS Чёрные, Партии.Результат
FROM Партии
JOIN Участники A ON Партии.УчастникБелыми = A.ID
JOIN Участники B ON Партии.УчастникЧёрными = B.ID;
