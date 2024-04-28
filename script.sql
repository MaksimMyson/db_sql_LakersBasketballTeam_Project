USE [db_sql_LakersBasketballTeam_Project]
GO

--Додавання гравця та вибірка всіх гравців
CREATE OR ALTER PROCEDURE add_player_and_select_all
    @p_name VARCHAR(50),
    @p_age INT,
    @p_position VARCHAR(20),
    @p_height DECIMAL(4,2),
    @p_weight DECIMAL(5,2),
    @p_nationality VARCHAR(50)
AS
BEGIN
    INSERT INTO Players (Name, Age, Position, Height, Weight, Nationality)
    VALUES (@p_name, @p_age, @p_position, @p_height, @p_weight, @p_nationality);
    
    SELECT * FROM Players;
END;


-- Виклик процедури add_player_and_select_all
EXEC add_player_and_select_all 'John Doe', 25, 'PG', 6.2, 180, 'USA';

--Оновлення гравця та вибірка всіх гравців
CREATE OR ALTER PROCEDURE update_player_and_select_all
    @p_player_id INT,
    @p_name VARCHAR(50),
    @p_age INT,
    @p_position VARCHAR(20),
    @p_height DECIMAL(4,2),
    @p_weight DECIMAL(5,2),
    @p_nationality VARCHAR(50)
AS
BEGIN
    UPDATE Players
    SET Name = @p_name,
        Age = @p_age,
        Position = @p_position,
        Height = @p_height,
        Weight = @p_weight,
        Nationality = @p_nationality
    WHERE PlayerID = @p_player_id;
    
    SELECT * FROM Players;
END;

-- Виклик процедури update_player_and_select_all
EXEC update_player_and_select_all 1, 'John Doe Jr.', 26, 'SG', 6.3, 185, 'USA';

--Видалення гравця та вибірка всіх гравців
CREATE OR ALTER PROCEDURE delete_player_and_select_all
    @p_player_id INT
AS
BEGIN
    DELETE FROM Players WHERE PlayerID = @p_player_id;
    
    SELECT * FROM Players;
END;

-- Виклик процедури delete_player_and_select_all
EXEC delete_player_and_select_all 1;

--Додавання матчу та вибірка всіх матчів
CREATE OR ALTER PROCEDURE add_game_and_select_all
    @p_opponent VARCHAR(100),
    @p_date_played DATE,
    @p_score INT,
    @p_win_loss VARCHAR(3)
AS
BEGIN
    INSERT INTO Games (Opponent, DatePlayed, Score, WinLoss)
    VALUES (@p_opponent, @p_date_played, @p_score, @p_win_loss);
    
    SELECT * FROM Games;
END;

-- Виклик процедури add_game_and_select_all
EXEC add_game_and_select_all 'Opponent', '2024-04-28', 100, 'Win';

--Оновлення матчу та вибірка всіх матчів
CREATE OR ALTER PROCEDURE update_game_and_select_all
    @p_game_id INT,
    @p_opponent VARCHAR(100),
    @p_date_played DATE,
    @p_score INT,
    @p_win_loss VARCHAR(3)
AS
BEGIN
    UPDATE Games
    SET Opponent = @p_opponent,
        DatePlayed = @p_date_played,
        Score = @p_score,
        WinLoss = @p_win_loss
    WHERE GameID = @p_game_id;
    
    SELECT * FROM Games;
END;

-- Виклик процедури update_game_and_select_all
EXEC update_game_and_select_all 1, 'New Opponent', '2024-04-29', 110, 'Loss';

 --Видалення матчу та вибірка всіх матчів
 CREATE OR ALTER PROCEDURE delete_game_and_select_all
    @p_game_id INT
AS
BEGIN
    DELETE FROM Games WHERE GameID = @p_game_id;
    
    SELECT * FROM Games;
END;

-- Виклик процедури delete_game_and_select_all
EXEC delete_game_and_select_all 1;

--Додавання тренера та вибірка всіх тренерів
CREATE OR ALTER PROCEDURE add_coach_and_select_all
    @p_name VARCHAR(50),
    @p_age INT,
    @p_nationality VARCHAR(50)
AS
BEGIN
    INSERT INTO Coaches (Name, Age, Nationality)
    VALUES (@p_name, @p_age, @p_nationality);
    
    SELECT * FROM Coaches;
END;

-- Виклик процедури add_coach_and_select_all
EXEC add_coach_and_select_all 'Coach Name', 40, 'USA';

--Оновлення тренера та вибірка всіх тренерів
CREATE OR ALTER PROCEDURE update_coach_and_select_all
    @p_coach_id INT,
    @p_name VARCHAR(50),
    @p_age INT,
    @p_nationality VARCHAR(50)
AS
BEGIN
    UPDATE Coaches
    SET Name = @p_name,
        Age = @p_age,
        Nationality = @p_nationality
    WHERE CoachID = @p_coach_id;
    
    SELECT * FROM Coaches;
END;

-- Виклик процедури update_coach_and_select_all
EXEC update_coach_and_select_all 1, 'Updated Coach Name', 45, 'Canada';

--Видалення тренера та вибірка всіх тренерів 
CREATE OR ALTER PROCEDURE delete_coach_and_select_all
    @p_coach_id INT
AS
BEGIN
    DELETE FROM Coaches WHERE CoachID = @p_coach_id;
    
    SELECT * FROM Coaches;
END;

-- Виклик процедури delete_coach_and_select_all
EXEC delete_coach_and_select_all 1;

--Додавання травми та вибірка всіх травм
CREATE OR ALTER PROCEDURE add_injury_and_select_all
    @p_player_id INT,
    @p_injury_type VARCHAR(100),
    @p_date_injured DATE
AS
BEGIN
    INSERT INTO Injuries (PlayerID, InjuryType, DateInjured)
    VALUES (@p_player_id, @p_injury_type, @p_date_injured);
    
    SELECT * FROM Injuries;
END;

-- Виклик процедури add_injury_and_select_all
EXEC add_injury_and_select_all 1, 'Sprain', '2024-04-25';


--Оновлення травми та вибірка всіх травм
CREATE OR ALTER PROCEDURE update_injury_and_select_all
    @p_injury_id INT,
    @p_player_id INT,
    @p_injury_type VARCHAR(100),
    @p_date_injured DATE
AS
BEGIN
    UPDATE Injuries
    SET PlayerID = @p_player_id,
        InjuryType = @p_injury_type,
        DateInjured = @p_date_injured
    WHERE InjuryID = @p_injury_id;
    
    SELECT * FROM Injuries;
END;

-- Виклик процедури update_injury_and_select_all
EXEC update_injury_and_select_all 1, 1, 'Fracture', '2024-04-26';

--Видалення травми та вибірка всіх травм
CREATE OR ALTER PROCEDURE delete_injury_and_select_all
    @p_injury_id INT
AS
BEGIN
    DELETE FROM Injuries WHERE InjuryID = @p_injury_id;
    
    SELECT * FROM Injuries;
END;

-- Виклик процедури delete_injury_and_select_all
EXEC delete_injury_and_select_all 1;

--Додавання контракту та вибірка всіх контрактів
CREATE OR ALTER PROCEDURE add_contract_and_select_all
    @p_player_id INT,
    @p_contract_start DATE,
    @p_contract_end DATE,
    @p_salary DECIMAL(10,2)
AS
BEGIN
    INSERT INTO Contracts (PlayerID, ContractStart, ContractEnd, Salary)
    VALUES (@p_player_id, @p_contract_start, @p_contract_end, @p_salary);
    
    SELECT * FROM Contracts;
END;

-- Виклик процедури add_contract_and_select_all
EXEC add_contract_and_select_all 1, '2024-01-01', '2025-01-01', 100000.00;

--Оновлення контракту та вибірка всіх контрактів
CREATE OR ALTER PROCEDURE update_contract_and_select_all
    @p_contract_id INT,
    @p_player_id INT,
    @p_contract_start DATE,
    @p_contract_end DATE,
    @p_salary DECIMAL(10,2)
AS
BEGIN
    UPDATE Contracts
    SET PlayerID = @p_player_id,
        ContractStart = @p_contract_start,
        ContractEnd = @p_contract_end,
        Salary = @p_salary
    WHERE ContractID = @p_contract_id;
    
    SELECT * FROM Contracts;
END;

-- Виклик процедури update_contract_and_select_all
EXEC update_contract_and_select_all 1, 1, '2025-01-01', '2026-01-01', 120000.00;

--Видалення контракту та вибірка всіх контрактів
CREATE OR ALTER PROCEDURE delete_contract_and_select_all
    @p_contract_id INT
AS
BEGIN
    DELETE FROM Contracts WHERE ContractID = @p_contract_id;
    
    SELECT * FROM Contracts;
END;

-- Виклик процедури delete_contract_and_select_all
EXEC delete_contract_and_select_all 1;

