DROP TABLE IF EXISTS `bc_bans`;
CREATE TABLE IF NOT EXISTS `bc_bans` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`license` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`discord` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`ip` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`fivem` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`hwd1` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`hwd2` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`hwd3` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`hwd4` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`hwd5` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`hwd6` LONGTEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`reason` TEXT NULL DEFAULT NULL COLLATE 'utf8mb4_general_ci',
	`expire` INT(11) NULL DEFAULT NULL,
	`bannedby` VARCHAR(255) NOT NULL DEFAULT 'BCBANS' COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`id`) USING BTREE,
	UNIQUE INDEX `uk_license` (`license`) USING BTREE,
	INDEX `license` (`license`) USING BTREE,
	INDEX `discord` (`discord`) USING BTREE,
	INDEX `ip` (`ip`) USING BTREE,
	INDEX `hwd1` (`hwd1`(768)) USING BTREE,
	INDEX `hwd2` (`hwd2`(768)) USING BTREE,
	INDEX `hwd3` (`hwd3`(768)) USING BTREE,
	INDEX `hwd4` (`hwd4`(768)) USING BTREE,
	INDEX `hwd5` (`hwd5`(768)) USING BTREE,
	INDEX `hwd6` (`hwd6`(768)) USING BTREE,
	INDEX `fivem` (`fivem`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=32
;