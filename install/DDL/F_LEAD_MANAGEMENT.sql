DROP TABLE IF EXISTS `F_LEAD_MANAGEMENT`;
CREATE TABLE `F_LEAD_MANAGEMENT` (
  `LEAD_ID` VARCHAR(36) DEFAULT NULL,
  `LEAD_TK` INT(11) DEFAULT NULL,
  `OPPORTUNITY_TK` INT(11) DEFAULT NULL,
  `LEAD_CREATED_TK` INT(11) DEFAULT NULL,
  `LEAD_CONVERTED_TK` INT(11) DEFAULT NULL,
  `CAMPAIGN_TK` INT(11) DEFAULT NULL,
  `LEAD_MODIFIED_TK` INT(11) DEFAULT NULL,
  `ASSIGNED_USER_TK` INT(11) DEFAULT NULL,
  `LEAD_DURATION` INT(11) DEFAULT NULL,
  KEY `IDX_F_LEAD_MANAGEMENT_LKP` (`LEAD_ID`)
);