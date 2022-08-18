use treasurehunters;
-- TASK 2---
-- Query 1
SELECT treasureID, 'description', points, 'type' FROM treasurehunters.treasure
WHERE 'description' LIKE '%brick%' OR 'description' LIKE '%map%';

-- Query 2
SELECT 'type', COUNT('type') AS totalTreasureTypeCount FROM treasurehunters.treasure
GROUP by type
ORDER BY totalTreasureTypeCount;

-- Query 3
SELECT badge.badgeName, badge.badgeID, MAX(purchase.cost) AS cost FROM 
treasurehunters.badge
JOIN treasurehunters.purchase ON badge.badgeID = purchase.badgeID
GROUP by badge.badgeID
ORDER BY MAX(purchase.cost) DESC
LIMIT 1;

-- Query 4
SELECT badge.badgeName, player.firstName AS playerFirstName, player.lastName AS playerLastName, player.email AS playerEmail FROM treasurehunters.purchase
JOIN treasurehunters.badge ON badge.badgeID = purchase.badgeID
JOIN treasurehunters.player ON player.username = purchase.username
ORDER BY badge.badgeName, player.firstName, player.lastName;

-- Query 5
SELECT CONCAT(player.firstName, '', player.lastName) as playerName,
player.username AS playerUsername, COUNT(player.username) as
advancedQuestCompleted FROM treasurehunters.quest
JOIN treasurehunters.playerprogress on Quest.questID = playerprogress.questID
JOIN treasurehunters.player ON player.username = playerprogress.username
WHERE quest.advanceQuestID IS NOT NULL AND playerprogress.progress = 'complete'
GROUP BY player.username
HAVING COUNT(player.username) > 0;

-- Query 6: UNFINISHED
SELECT store.storeID,
		store.storeName,
        IFNULL(storePurchased.totalCount, 0) AS uniquePlayerPurchaseCount,
        store.totalPlayerCount - IFNULL(storepurchased.totalCount,0) AS
        uniquePlayerNotPurchaseCount, IFNULL (SUM (purchase.cost), 0) AS
        totalMoneySpentAtTheStore, IFNULL (mostExpensiveBadge.badgeName, 'None') AS mostExpensiveBadge,
        IFNULL(cheapestExpensiveBadge.badgeName, 'None') cheapeastExpensiveBadge, IFNULL (AVG(purchase.cost), 0) AS
        averageItemPrice FROM ( SELECT store.storeID, storeName, totalPlayerCount FROM treasurehunters.store,(
        SELECT COUNT(*) AS totalPlayerCount FROM treasurehunters.player) AS totalPlayerCount) AS store LEFT JOIN treasurehunters.purchase ON
        store.storeID = purchase.storeID LEFT JOIN (SELECT storeID, COUNT(storeID) AS totalCount FROM (
        SELECT purchase.storeID FROM treasurehunters.player)

-- TASK 3
-- Insert
INSERT INTO treasurehunters.badge (badgeName, badgeDescription) VALUES ('Summer Rain', 'Beach, sun and holidays');

-- Delete
DELETE from treasurehunters.playerprogress WHERE progress = 'complete';

-- Update
UPDATE treasurehunters.player 
	SET streetNumber = '72',
		streetName = 'Evergreen Terrace',
		suburb = 'Springfield'
	WHERE 
		lastName = 'Halpin' AND streetNumber = '1800' AND streetName = 'Zelda Street' AND suburb = 'Linkburb';

-- Create Index 
ALTER TABLE treasurehunters.quest
MODIFY story varchar(1024);

CREATE INDEX Story_Inx on treasurehunters.quest (story); 

-- Create View
CREATE VIEW P_Players_Inactive AS 
	SELECT firstName, lastName, creationDateTime, playerprogress.progress FROM treasurehunters.player
    LEFT JOIN treasurehunters.playerprogress ON player.username = playerprogress.username
    WHERE playerprogress.progress = 'inactive'
    GROUP BY player.username;

-- TASK 4
CREATE USER 'catie'@'localhost' IDENTIFIED BY 'Password1';
GRANT ALL ON *.* TO 'catie'@'localhost';
REVOKE INSERT ON treasurehunters.player FROM 'catie'@'%';
REVOKE DELETE ON treasurehunters.player FROM 'catie'@'%';

CREATE USER 'manav'@'localhost' IDENTIFIED BY 'Password2';
GRANT INSERT ON treasurehunters.quest TO 'manav'@'localhost';
GRANT DELETE ON treasurehunters.quest TO 'manav'@'localhost';