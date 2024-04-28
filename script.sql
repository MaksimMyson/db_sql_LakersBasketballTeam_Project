USE [db_sql_LakersBasketballTeam_Project]
GO

-- Додавання гравців
INSERT INTO Players (PlayerID, Name, Age, Position, Height, Weight, Nationality)
VALUES
    (1, 'LeBron James', 36, 'SF', 6.9, 250.0, 'American'),
    (2, 'Kevin Durant', 33, 'PF', 6.10, 240.0, 'American'),
    (3, 'Stephen Curry', 34, 'PG', 6.3, 185.0, 'American');

-- Додавання інформації про гри
INSERT INTO Games (GameID, Opponent, DatePlayed, Score, WinLoss)
VALUES
    (1, 'Los Angeles Lakers', '2024-04-01', 110, 'Win'),
    (2, 'Houston Rockets', '2024-04-05', 105, 'Win'),
    (3, 'Golden State Warriors', '2024-04-10', 98, 'Loss');

-- Додавання тренерів
INSERT INTO Coaches (CoachID, Name, Age, Nationality)
VALUES
    (1, 'Gregg Popovich', 72, 'American'),
    (2, 'Erik Spoelstra', 51, 'American'),
    (3, 'Steve Kerr', 56, 'American');

-- Додавання травм гравців
INSERT INTO Injuries (InjuryID, PlayerID, InjuryType, DateInjured)
VALUES
    (1, 1, 'Ankle Sprain', '2024-04-03'),
    (2, 3, 'Hamstring Strain', '2024-04-08');

-- Додавання контрактної інформації
INSERT INTO Contracts (ContractID, PlayerID, ContractStart, ContractEnd, Salary)
VALUES
    (1, 1, '2024-01-01', '2026-01-01', 40000000.00),
    (2, 2, '2024-02-15', '2027-02-15', 38000000.00),
    (3, 3, '2024-03-10', '2026-03-10', 42000000.00);

-- Додавання інформації про нагороди
INSERT INTO Awards (AwardID, PlayerID, AwardName, YearReceived)
VALUES
    (1, 1, 'NBA MVP', 2023),
    (2, 2, 'NBA Finals MVP', 2017),
    (3, 3, 'NBA All-Star', 2022);

-- Додавання статистики гравців у різних матчах
INSERT INTO Stats (StatID, PlayerID, GameID, Points, Assists, Rebounds)
VALUES
    (1, 1, 1, 28, 10, 12),
    (2, 2, 1, 32, 8, 11),
    (3, 3, 1, 35, 9, 8);
    
-- Додавання інформації про вибори на драфті
INSERT INTO DraftPicks (DraftPickID, PlayerID, YearDrafted, Round, OverallPick)
VALUES
    (1, 1, 2003, 1, 1),
    (2, 2, 2007, 1, 2),
    (3, 3, 2009, 1, 7);

-- Додавання медіа матеріалів
INSERT INTO Media (MediaID, MediaType, Description, UploadDate)
VALUES
    (1, 'Photo', 'Team photo', '2024-04-15'),
    (2, 'Video', 'Game highlights', '2024-04-20');

-- Додавання загальної інформації про команду
INSERT INTO TeamInfo (TeamID, TeamName, FoundedYear, Location, Arena)
VALUES
    (1, 'Los Angeles Lakers', 1947, 'Los Angeles, California', 'Staples Center'),
    (2, 'Brooklyn Nets', 1967, 'Brooklyn, New York', 'Barclays Center');

