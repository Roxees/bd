Представление с вложенным запросом
CREATE VIEW ПредставлениеСВложенным AS
SELECT * FROM Турниры WHERE ТурнирID IN (SELECT ТурнирID FROM Участники WHERE Рейтинг > 2400);

Представление с группировкой
CREATE VIEW ПредставлениеСГруппировкой AS
SELECT ТурнирID, COUNT(*) AS КоличествоУчастников
FROM Участники
GROUP BY ТурнирID;



Представление с соединением
CREATE VIEW ПредставлениеССоединением AS
SELECT Турниры.Название, COUNT(Партии.ПартияID) AS КоличествоПартий
FROM Турниры
JOIN Партии ON Турниры.ТурнирID = Партии.ТурнирID
GROUP BY Турниры.ТурнирID;


Изменяемое представление с условием WHERE
CREATE OR REPLACE VIEW ИзменяемоеПредставление AS
SELECT * FROM Участники WHERE Рейтинг > 2400
WITH LOCAL CHECK OPTION;
2. Создание и отладка запросов
Выборка данных из всех созданных представлений

SELECT * FROM ПредставлениеСВложенным;
SELECT * FROM ПредставлениеСГруппировкой;
SELECT * FROM ПредставлениеССоединением;
SELECT * FROM ИзменяемоеПредставление;

Вставка/обновление в изменяемом представлении данных
Вставка данных, которые попадают под условие WHERE
INSERT INTO ИзменяемоеПредставление (Имя, Рейтинг, ТурнирID) VALUES ('Новый Участник', 2500, 1);

Обновление данных, которые попадают под условие WHERE
UPDATE ИзменяемоеПредставление SET Рейтинг = 2600 WHERE Имя = 'Новый Участник';

Вставка данных, которые не попадают под условие WHERE (это должно вызвать ошибку)
INSERT INTO ИзменяемоеПредставление (Имя, Рейтинг, ТурнирID) VALUES ('Другой Участник', 2300, 2);
3. Изменение представления для запрета вставки/обновления значений, не попадающих под условие WHERE

CREATE OR REPLACE VIEW ИзменяемоеПредставление AS
SELECT * FROM Участники WHERE Рейтинг > 2400
WITH CHECK OPTION;
4. Проверка запроса на вставку/обновление в измененном представлении

-- Вставка данных, которые не попадают под условие WHERE (это должно вызвать ошибку)
INSERT INTO ИзменяемоеПредставление (Имя, Рейтинг, ТурнирID) VALUES ('Другой Участник', 2300, 2);
5. Создание и отладка хранимых процедур
Хранимая процедура, выполняющая несколько инструкций

CREATE OR REPLACE PROCEDURE MultiStepProcedure()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Вставка
    INSERT INTO Участники (Имя, Рейтинг, ТурнирID) VALUES ('Процедурный Участник', 2400, 1);

    -- Обновление
    UPDATE Участники SET Рейтинг = 2450 WHERE Имя = 'Процедурный Участник';
END;
$$;
Хранимая процедура с вводимым параметром

CREATE OR REPLACE PROCEDURE UpdateRatingByName(IN participant_name VARCHAR, IN new_rating INT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Участники
    SET Рейтинг = new_rating
    WHERE Имя = participant_name;
END;
$$;
6. Рассмотрение возможности запуска процедур по расписанию
Для запуска процедур по расписанию в PostgreSQL можно использовать расширение pg_cron. Например, для запуска процедуры MultiStepProcedure каждый день в полночь:


SELECT cron.schedule('0 0 * * *', 'CALL MultiStepProcedure();');
7. Создание и отладка функций

CREATE OR REPLACE FUNCTION GetTournamentParticipantCount(tournament_id INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    participant_count INT;
BEGIN
    SELECT COUNT(*) INTO participant_count
    FROM Участники
    WHERE ТурнирID = tournament_id;
    RETURN participant_count;
END;
$$;
8. Создание триггеров
CREATE OR REPLACE FUNCTION UpdateTournamentStatistics()
RETURNS TRIGGER AS $$
BEGIN
    -- Обновление статистики турнира
    UPDATE Турниры
    SET КоличествоУчастников = (SELECT COUNT(*) FROM Участники WHERE ТурнирID = NEW.ТурнирID)
    WHERE ТурнирID = NEW.ТурнирID;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER ParticipantChangeTrigger
AFTER INSERT OR UPDATE OR DELETE
ON Участники
FOR EACH ROW
EXECUTE FUNCTION UpdateTournamentStatistics();