CREATE DATABASE [db_sql_LakersBasketballTeam_Project]
GO
USE [db_sql_LakersBasketballTeam_Project]
GO

--������� "Players" ��� ���������� ���������� ��� ������� �������
CREATE TABLE Players (
    PlayerID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Age INT CHECK (Age >= 18),
    Position VARCHAR(20),
    Height DECIMAL(4,2),
    Weight DECIMAL(5,2),
    Nationality VARCHAR(50),
    CONSTRAINT CHK_Position CHECK (Position IN ('PG', 'SG', 'SF', 'PF', 'C'))
);

--������� "Games" ��� ���������� ���������� ������
CREATE TABLE Games (
    GameID INT PRIMARY KEY,
    Opponent VARCHAR(100) NOT NULL,
    DatePlayed DATE,
    Score INT,
    WinLoss VARCHAR(3) CHECK (WinLoss IN ('Win', 'Loss'))
);

--������� "Coaches" ��� ���������� ��� �������
CREATE TABLE Coaches (
    CoachID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Age INT CHECK (Age >= 30),
    Nationality VARCHAR(50)
);

--������� "Injuries" ��� ���������� ����� �������
CREATE TABLE Injuries (
    InjuryID INT PRIMARY KEY,
    PlayerID INT,
    InjuryType VARCHAR(100),
    DateInjured DATE,
    CONSTRAINT FK_Injury_Player FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)
);

--������� "Contracts" ��� ���������� ���������� �������
CREATE TABLE Contracts (
    ContractID INT PRIMARY KEY,
    PlayerID INT,
    ContractStart DATE,
    ContractEnd DATE,
    Salary DECIMAL(10,2),
    CONSTRAINT FK_Contract_Player FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)
);

--������� "Awards" ��� ���������� ���������� ��� ������� ��������
CREATE TABLE Awards (
    AwardID INT PRIMARY KEY,
    PlayerID INT,
    AwardName VARCHAR(100),
    YearReceived INT,
    CONSTRAINT FK_Award_Player FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)
);

--������� "Stats" ��� ���������� ���������� ������� � ����� ������
CREATE TABLE Stats (
    StatID INT PRIMARY KEY,
    PlayerID INT,
    GameID INT,
    Points INT,
    Assists INT,
    Rebounds INT,
    CONSTRAINT FK_Stat_Player FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID),
    CONSTRAINT FK_Stat_Game FOREIGN KEY (GameID) REFERENCES Games(GameID)
);

--������� "DraftPicks" ��� ���������� ��� ������ �� �����
CREATE TABLE DraftPicks (
    DraftPickID INT PRIMARY KEY,
    PlayerID INT,
    YearDrafted INT,
    Round INT,
    OverallPick INT,
    CONSTRAINT FK_DraftPick_Player FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)
);

--������� "Media" ��� ���������� ���� �������� (����, ����) ��� �������
CREATE TABLE Media (
    MediaID INT PRIMARY KEY,
    MediaType VARCHAR(20),
    Description TEXT,
    UploadDate DATE
);

--������� "TeamInfo" ��� ���������� �������� ���������� ��� �������
CREATE TABLE TeamInfo (
    TeamID INT PRIMARY KEY,
    TeamName VARCHAR(100) NOT NULL,
    FoundedYear INT CHECK (FoundedYear >= 1900),
    Location VARCHAR(100),
    Arena VARCHAR(100)
); 


--�������� ��������� ����� ������� � ��� ����� 18 ����
CREATE OR REPLACE FUNCTION check_player_age()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.Age < 18 THEN
        RAISE EXCEPTION 'Players must be at least 18 years old.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_player_age
BEFORE INSERT ON Players
FOR EACH ROW EXECUTE FUNCTION check_player_age();

--��������� ��� ������ ��� ������, ���'������ � ������� ��� �������� ������ ������
CREATE OR REPLACE FUNCTION delete_player_injuries()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM Injuries WHERE PlayerID = OLD.PlayerID;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_delete_player_injuries
BEFORE DELETE ON Players
FOR EACH ROW EXECUTE FUNCTION delete_player_injuries();

--�������� ����, �� �������� � �������� �� ����� 0
CREATE OR REPLACE FUNCTION check_contract_salary()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.Salary < 0 THEN
        RAISE EXCEPTION 'Salary in contract cannot be negative.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_contract_salary
BEFORE INSERT OR UPDATE ON Contracts
FOR EACH ROW EXECUTE FUNCTION check_contract_salary();

--�������� �������� ������� � ����� ������� ����� ���������� �������
CREATE OR REPLACE FUNCTION check_team_players()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Players WHERE TeamID = OLD.TeamID) THEN
        RAISE EXCEPTION 'Cannot delete team with active players.';
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_team_players
BEFORE DELETE ON TeamInfo
FOR EACH ROW EXECUTE FUNCTION check_team_players();

--�������� �������� ������� � �� ����� ���������� ������ ��� ���
CREATE OR REPLACE FUNCTION check_game_players()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM Stats WHERE GameID = OLD.GameID) THEN
        RAISE EXCEPTION 'Cannot delete game with associated player stats.';
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_game_players
BEFORE DELETE ON Games
FOR EACH ROW EXECUTE FUNCTION check_game_players();

--�������� �������� ������ ����� ���������� ������ ��� ���� ���������� � ��
CREATE OR REPLACE FUNCTION check_player_stats()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Players WHERE PlayerID = NEW.PlayerID) THEN
        RAISE EXCEPTION 'Cannot add stats for non-existent player.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_player_stats
BEFORE INSERT ON Stats
FOR EACH ROW EXECUTE FUNCTION check_player_stats();

--��������� ��� ������ ��� ��������, ���'������ � ������� ��� �������� ������ ������
CREATE OR REPLACE FUNCTION delete_player_awards()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM Awards WHERE PlayerID = OLD.PlayerID;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_delete_player_awards
BEFORE DELETE ON Players
FOR EACH ROW EXECUTE FUNCTION delete_player_awards();

--��������� ��� ������ ��� ���������, ���'������ � ������� ��� �������� ������ ������
CREATE OR REPLACE FUNCTION delete_player_contracts()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM Contracts WHERE PlayerID = OLD.PlayerID;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_delete_player_contracts
BEFORE DELETE ON Players
FOR EACH ROW EXECUTE FUNCTION delete_player_contracts();

--��������� ��� ������ ��� ������ �� �����, ���'������ � ������� ��� �������� ������ ������
CREATE OR REPLACE FUNCTION delete_player_draft_picks()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM DraftPicks WHERE PlayerID = OLD.PlayerID;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_delete_player_draft_picks
BEFORE DELETE ON Players
FOR EACH ROW EXECUTE FUNCTION delete_player_draft_picks();

--��������� ��� ������ ��� ���������� ������ � ����� ������, ���'������ � ������� ��� �������� ������ ������
CREATE OR REPLACE FUNCTION delete_player_stats()
RETURNS TRIGGER AS $$
BEGIN
    DELETE FROM Stats WHERE PlayerID = OLD.PlayerID;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_delete_player_stats
BEFORE DELETE ON Players
FOR EACH ROW EXECUTE FUNCTION delete_player_stats();
