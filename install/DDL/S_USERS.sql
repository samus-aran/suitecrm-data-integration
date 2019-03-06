DROP TABLE IF EXISTS `S_USERS`;
CREATE TABLE `S_USERS` (
  `id` VARCHAR(36) DEFAULT NULL,
  `user_name` VARCHAR(60) DEFAULT NULL,
  `user_hash` VARCHAR(255) DEFAULT NULL,
  `system_generated_password` CHAR(1) DEFAULT NULL,
  `pwd_last_changed` DATETIME DEFAULT NULL,
  `authenticate_id` VARCHAR(100) DEFAULT NULL,
  `sugar_login` CHAR(1) DEFAULT NULL,
  `first_name` VARCHAR(30) DEFAULT NULL,
  `last_name` VARCHAR(30) DEFAULT NULL,
  `is_admin` CHAR(1) DEFAULT NULL,
  `external_auth_only` CHAR(1) DEFAULT NULL,
  `receive_notifications` CHAR(1) DEFAULT NULL,
  `description` TEXT,
  `date_entered` DATETIME DEFAULT NULL,
  `date_modified` DATETIME DEFAULT NULL,
  `modified_user_id` VARCHAR(36) DEFAULT NULL,
  `created_by` VARCHAR(36) DEFAULT NULL,
  `title` VARCHAR(50) DEFAULT NULL,
  `photo` VARCHAR(255) DEFAULT NULL,
  `department` VARCHAR(50) DEFAULT NULL,
  `phone_home` VARCHAR(50) DEFAULT NULL,
  `phone_mobile` VARCHAR(50) DEFAULT NULL,
  `phone_work` VARCHAR(50) DEFAULT NULL,
  `phone_other` VARCHAR(50) DEFAULT NULL,
  `phone_fax` VARCHAR(50) DEFAULT NULL,
  `status` VARCHAR(100) DEFAULT NULL,
  `address_street` VARCHAR(150) DEFAULT NULL,
  `address_city` VARCHAR(100) DEFAULT NULL,
  `address_state` VARCHAR(100) DEFAULT NULL,
  `address_country` VARCHAR(100) DEFAULT NULL,
  `address_postalcode` VARCHAR(20) DEFAULT NULL,
  `deleted` CHAR(1) DEFAULT NULL,
  `portal_only` CHAR(1) DEFAULT NULL,
  `show_on_employees` CHAR(1) DEFAULT NULL,
  `employee_status` VARCHAR(100) DEFAULT NULL,
  `messenger_id` VARCHAR(100) DEFAULT NULL,
  `messenger_type` VARCHAR(100) DEFAULT NULL,
  `reports_to_id` VARCHAR(36) DEFAULT NULL,
  `is_group` CHAR(1) DEFAULT NULL
);