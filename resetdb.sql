UPDATE `Bidders` SET premium_left = 150000;
UPDATE `Players` SET `team_id`=0,`price`=0;
DELETE FROM `Bidding` WHERE 1;