/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: accessory
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `accessory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = MyISAM AUTO_INCREMENT = 7 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: address
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `street` varchar(255) NOT NULL,
  `city_id` int(11) NOT NULL DEFAULT '1',
  `state_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL DEFAULT '1',
  `zip_code` varchar(10) NOT NULL,
  `longitude` varchar(255) NOT NULL,
  `latitude` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `city_id` (`city_id`),
  KEY `state_id` (`state_id`),
  KEY `country_id` (`country_id`)
) ENGINE = MyISAM AUTO_INCREMENT = 7 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: bank
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estate_id` int(11) NOT NULL,
  `amount` float NOT NULL,
  `currency` enum('hryvnia', 'euro', 'dollar') NOT NULL DEFAULT 'hryvnia',
  `hrn_equivalent` float NOT NULL,
  `direction` enum('incoming', 'outcoming') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: bot
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `bot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `token` varchar(200) NOT NULL,
  `pattern` varchar(50) NOT NULL,
  `options` text NOT NULL,
  `nlp` text NOT NULL,
  `useraccess` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: bot_chat
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `bot_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `title` varchar(100) NOT NULL,
  `type` varchar(50) NOT NULL,
  `all_members_are_administrators` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT 'on/off',
  PRIMARY KEY (`id`),
  UNIQUE KEY `chat_id` (`code`)
) ENGINE = InnoDB AUTO_INCREMENT = 10 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: bot_commands
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `bot_commands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `command` text COLLATE utf8_unicode_ci NOT NULL,
  `action_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8 COLLATE = utf8_unicode_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: capital
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `capital` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sum` float NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `currency` enum('EUR', 'HRN', 'USD') CHARACTER SET latin1 NOT NULL DEFAULT 'EUR',
  `exchange_rate` float NOT NULL COMMENT '(EUR equivalent)',
  `comment` varchar(255) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = MyISAM AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: city
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = MyISAM AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: client
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(15) NOT NULL,
  `last_name` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = MyISAM AUTO_INCREMENT = 18 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: contract
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `contract` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `estate_id` int(11) NOT NULL,
  `status` enum('active', 'closed', 'freezed') NOT NULL,
  `period_type` enum('daily', 'weekly', 'monthly') NOT NULL DEFAULT 'monthly',
  `price` float NOT NULL,
  `date_start` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_end` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = MyISAM AUTO_INCREMENT = 20 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: country
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = MyISAM AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: estate
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `estate` (
  `comment` text NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `address_id` int(11) NOT NULL,
  `house_number` varchar(10) NOT NULL,
  `apartment_number` int(10) NOT NULL,
  `square` int(4) NOT NULL,
  `photos` varchar(255) NOT NULL COMMENT 'folder_id',
  PRIMARY KEY (`id`),
  KEY `address_id` (`address_id`)
) ENGINE = MyISAM AUTO_INCREMENT = 8 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: expense
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `expense` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estate_id` int(11) NOT NULL,
  `ref_estate_accessory_id` int(11) NOT NULL,
  `type` enum('accessory', 'accommodation', 'service') NOT NULL,
  `amount` double NOT NULL,
  `description` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `estate_id` (`estate_id`),
  KEY `ref_est_acc` (`ref_estate_accessory_id`)
) ENGINE = MyISAM AUTO_INCREMENT = 38 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: payment
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contract_id` int(11) NOT NULL,
  `amount` float NOT NULL,
  `period` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pending', 'payed', 'withdrawn') NOT NULL DEFAULT 'pending',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `contract_id` (`contract_id`)
) ENGINE = MyISAM AUTO_INCREMENT = 183 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: ref_estate_accessory
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `ref_estate_accessory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estate_id` int(11) NOT NULL,
  `accessory_id` int(11) NOT NULL,
  `status` enum('new', 'almost_new', 'normal', 'old') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = MyISAM AUTO_INCREMENT = 9 DEFAULT CHARSET = latin1;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: role
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = MyISAM AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: state
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `state` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = MyISAM AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: task
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `data` text NOT NULL,
  `status` enum('active', 'closed') NOT NULL DEFAULT 'active',
  `date_start` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `interval` char(50) DEFAULT NULL COMMENT 'Y-M-D h:m:s',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: user
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`)
) ENGINE = MyISAM AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: utilitymeter
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `utilitymeter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(100) NOT NULL,
  `utilityservice_id` int(11) NOT NULL,
  `estate_id` int(11) NOT NULL,
  `price` float NOT NULL,
  `meter_before` int(11) NOT NULL,
  `meter_current` int(11) NOT NULL,
  `description` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE = InnoDB AUTO_INCREMENT = 8 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: utilityservice
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `utilityservice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `unit` char(20) NOT NULL COMMENT 'unit of measure',
  `description` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tariff_url` text NOT NULL,
  `tariff_selector` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 19 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: utilityservice_invoice
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `utilityservice_invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `utilityservice_id` int(11) NOT NULL,
  `meter_before` int(11) NOT NULL,
  `meter_current` int(11) NOT NULL,
  `amount` double NOT NULL COMMENT 'sum = (current - before) * price',
  `price` double NOT NULL,
  `status` enum('pending', 'payed') NOT NULL,
  `period` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `attachment_file` varchar(100) NOT NULL COMMENT 'file(pdf) in folder',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: accessory
# ------------------------------------------------------------

INSERT INTO
  `accessory` (`id`, `name`)
VALUES
  (1, 'Унитаз');
INSERT INTO
  `accessory` (`id`, `name`)
VALUES
  (2, 'Бойлер');
INSERT INTO
  `accessory` (`id`, `name`)
VALUES
  (3, 'Балконный блок');
INSERT INTO
  `accessory` (`id`, `name`)
VALUES
  (4, 'Диван');
INSERT INTO
  `accessory` (`id`, `name`)
VALUES
  (5, 'Смеситель (сантехника)');
INSERT INTO
  `accessory` (`id`, `name`)
VALUES
  (6, 'Счетчик электроэнергии');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: address
# ------------------------------------------------------------

INSERT INTO
  `address` (
    `id`,
    `street`,
    `city_id`,
    `state_id`,
    `country_id`,
    `zip_code`,
    `longitude`,
    `latitude`
  )
VALUES
  (1, 'Пацаева', 1, 1, 1, '', '0', '0');
INSERT INTO
  `address` (
    `id`,
    `street`,
    `city_id`,
    `state_id`,
    `country_id`,
    `zip_code`,
    `longitude`,
    `latitude`
  )
VALUES
  (2, 'Жадова', 1, 1, 1, '', '0', '0');
INSERT INTO
  `address` (
    `id`,
    `street`,
    `city_id`,
    `state_id`,
    `country_id`,
    `zip_code`,
    `longitude`,
    `latitude`
  )
VALUES
  (3, 'Попова', 1, 1, 1, '', '0', '0');
INSERT INTO
  `address` (
    `id`,
    `street`,
    `city_id`,
    `state_id`,
    `country_id`,
    `zip_code`,
    `longitude`,
    `latitude`
  )
VALUES
  (
    4,
    'Сугоклеевская',
    2,
    1,
    1,
    '',
    '48.464936',
    '32.203764'
  );
INSERT INTO
  `address` (
    `id`,
    `street`,
    `city_id`,
    `state_id`,
    `country_id`,
    `zip_code`,
    `longitude`,
    `latitude`
  )
VALUES
  (5, 'Дачная', 1, 1, 1, '', '48.454410', '32.203997');
INSERT INTO
  `address` (
    `id`,
    `street`,
    `city_id`,
    `state_id`,
    `country_id`,
    `zip_code`,
    `longitude`,
    `latitude`
  )
VALUES
  (
    6,
    'В.Никитина',
    1,
    0,
    1,
    '25000',
    '48.530489',
    '32.274170'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: bank
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: bot
# ------------------------------------------------------------

INSERT INTO
  `bot` (
    `id`,
    `name`,
    `token`,
    `pattern`,
    `options`,
    `nlp`,
    `useraccess`
  )
VALUES
  (
    1,
    'KrHome',
    '1511669163:AAEP_FZQHSc2VFNsOBzNrnGhByBTFwrmV_A',
    '(.+)',
    '{\"polling\":true}',
    '',
    'klamenzui'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: bot_chat
# ------------------------------------------------------------

INSERT INTO
  `bot_chat` (
    `id`,
    `code`,
    `title`,
    `type`,
    `all_members_are_administrators`,
    `status`
  )
VALUES
  (4, '-818696924', '#5: Дача', 'group', 1, 1);
INSERT INTO
  `bot_chat` (
    `id`,
    `code`,
    `title`,
    `type`,
    `all_members_are_administrators`,
    `status`
  )
VALUES
  (5, '-549807249', '#6: Никитина 15-28', 'group', 1, 0);
INSERT INTO
  `bot_chat` (
    `id`,
    `code`,
    `title`,
    `type`,
    `all_members_are_administrators`,
    `status`
  )
VALUES
  (6, '-516388453', '#1: Пацаева 10-87', 'group', 1, 0);
INSERT INTO
  `bot_chat` (
    `id`,
    `code`,
    `title`,
    `type`,
    `all_members_are_administrators`,
    `status`
  )
VALUES
  (7, '-274988667', '#2: Жадова 19-3', 'group', 1, 0);
INSERT INTO
  `bot_chat` (
    `id`,
    `code`,
    `title`,
    `type`,
    `all_members_are_administrators`,
    `status`
  )
VALUES
  (8, '-586687556', '#7: Никитина 15-91', 'group', 1, 0);
INSERT INTO
  `bot_chat` (
    `id`,
    `code`,
    `title`,
    `type`,
    `all_members_are_administrators`,
    `status`
  )
VALUES
  (9, '-483285968', '#3: Попова 20-84', 'group', 1, 0);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: bot_commands
# ------------------------------------------------------------

INSERT INTO
  `bot_commands` (`id`, `command`, `action_id`)
VALUES
  (1, 'оплата % %', 0);
INSERT INTO
  `bot_commands` (`id`, `command`, `action_id`)
VALUES
  (2, 'покупка % %', 1);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: capital
# ------------------------------------------------------------

INSERT INTO
  `capital` (
    `id`,
    `sum`,
    `date`,
    `currency`,
    `exchange_rate`,
    `comment`
  )
VALUES
  (1, 5000, '2019-09-22 20:17:55', 'EUR', 0, 'in ua');
INSERT INTO
  `capital` (
    `id`,
    `sum`,
    `date`,
    `currency`,
    `exchange_rate`,
    `comment`
  )
VALUES
  (2, 100, '2019-09-22 20:25:11', 'EUR', 0, 'in de');
INSERT INTO
  `capital` (
    `id`,
    `sum`,
    `date`,
    `currency`,
    `exchange_rate`,
    `comment`
  )
VALUES
  (3, 5000, '2019-09-22 20:25:11', 'EUR', 0, 'in de');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: city
# ------------------------------------------------------------

INSERT INTO
  `city` (`id`, `name`)
VALUES
  (1, 'Кропивницкий');
INSERT INTO
  `city` (`id`, `name`)
VALUES
  (2, 'Черняховка');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: client
# ------------------------------------------------------------

INSERT INTO
  `client` (`id`, `first_name`, `last_name`)
VALUES
  (1, 'Виктория', '-');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`)
VALUES
  (2, 'Егор', '-');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`)
VALUES
  (3, 'Виталий', 'Макеев');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`)
VALUES
  (4, 'Лидия', '-');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`)
VALUES
  (5, 'Оксана', '-');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`)
VALUES
  (6, 'Инна', 'Деменко');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`)
VALUES
  (7, 'Алексей', 'Еременко');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`)
VALUES
  (8, 'Александр', 'Грушевский');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`)
VALUES
  (9, 'Виталий', 'Притуленко');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`)
VALUES
  (10, 'Лариса', '');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`)
VALUES
  (11, 'Татьяна', 'Дименко');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`)
VALUES
  (12, 'Michael', '');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`)
VALUES
  (13, 'Мартыненко', 'Оксана');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`)
VALUES
  (14, 'Тертичный', 'Олег');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: contract
# ------------------------------------------------------------

INSERT INTO
  `contract` (
    `id`,
    `client_id`,
    `estate_id`,
    `status`,
    `period_type`,
    `price`,
    `date_start`,
    `date_end`
  )
VALUES
  (
    1,
    1,
    1,
    'closed',
    'monthly',
    1800,
    '2018-06-01 02:00:00',
    '0000-00-00 00:00:00'
  );
INSERT INTO
  `contract` (
    `id`,
    `client_id`,
    `estate_id`,
    `status`,
    `period_type`,
    `price`,
    `date_start`,
    `date_end`
  )
VALUES
  (
    2,
    2,
    2,
    'closed',
    'monthly',
    2200,
    '2018-09-01 02:00:00',
    '2019-01-31 00:00:00'
  );
INSERT INTO
  `contract` (
    `id`,
    `client_id`,
    `estate_id`,
    `status`,
    `period_type`,
    `price`,
    `date_start`,
    `date_end`
  )
VALUES
  (
    3,
    3,
    2,
    'closed',
    'monthly',
    2500,
    '2019-02-11 20:20:40',
    '0000-00-00 00:00:00'
  );
INSERT INTO
  `contract` (
    `id`,
    `client_id`,
    `estate_id`,
    `status`,
    `period_type`,
    `price`,
    `date_start`,
    `date_end`
  )
VALUES
  (
    4,
    4,
    1,
    'closed',
    'monthly',
    2000,
    '2018-12-15 06:00:00',
    '0000-00-00 00:00:00'
  );
INSERT INTO
  `contract` (
    `id`,
    `client_id`,
    `estate_id`,
    `status`,
    `period_type`,
    `price`,
    `date_start`,
    `date_end`
  )
VALUES
  (
    5,
    6,
    2,
    'closed',
    'monthly',
    3000,
    '2019-04-13 06:00:00',
    '2019-07-11 00:00:00'
  );
INSERT INTO
  `contract` (
    `id`,
    `client_id`,
    `estate_id`,
    `status`,
    `period_type`,
    `price`,
    `date_start`,
    `date_end`
  )
VALUES
  (
    6,
    7,
    2,
    'active',
    'monthly',
    3000,
    '2019-07-15 21:48:44',
    '0000-00-00 00:00:00'
  );
INSERT INTO
  `contract` (
    `id`,
    `client_id`,
    `estate_id`,
    `status`,
    `period_type`,
    `price`,
    `date_start`,
    `date_end`
  )
VALUES
  (
    7,
    8,
    1,
    'active',
    'monthly',
    2000,
    '2019-10-31 05:00:00',
    '0000-00-00 00:00:00'
  );
INSERT INTO
  `contract` (
    `id`,
    `client_id`,
    `estate_id`,
    `status`,
    `period_type`,
    `price`,
    `date_start`,
    `date_end`
  )
VALUES
  (
    8,
    9,
    6,
    'closed',
    'monthly',
    3000,
    '2019-11-25 06:00:00',
    '0000-00-00 00:00:00'
  );
INSERT INTO
  `contract` (
    `id`,
    `client_id`,
    `estate_id`,
    `status`,
    `period_type`,
    `price`,
    `date_start`,
    `date_end`
  )
VALUES
  (
    9,
    10,
    6,
    'closed',
    'monthly',
    3000,
    '2020-04-01 17:58:45',
    '2020-09-30 00:00:00'
  );
INSERT INTO
  `contract` (
    `id`,
    `client_id`,
    `estate_id`,
    `status`,
    `period_type`,
    `price`,
    `date_start`,
    `date_end`
  )
VALUES
  (
    10,
    11,
    6,
    'closed',
    'monthly',
    2900,
    '2020-10-01 17:58:45',
    '0000-00-00 00:00:00'
  );
INSERT INTO
  `contract` (
    `id`,
    `client_id`,
    `estate_id`,
    `status`,
    `period_type`,
    `price`,
    `date_start`,
    `date_end`
  )
VALUES
  (
    11,
    12,
    3,
    'active',
    'monthly',
    2000,
    '2020-09-15 06:00:00',
    '0000-00-00 00:00:00'
  );
INSERT INTO
  `contract` (
    `id`,
    `client_id`,
    `estate_id`,
    `status`,
    `period_type`,
    `price`,
    `date_start`,
    `date_end`
  )
VALUES
  (
    12,
    13,
    6,
    'active',
    'monthly',
    3000,
    '2021-04-12 06:00:00',
    '0000-00-00 00:00:00'
  );
INSERT INTO
  `contract` (
    `id`,
    `client_id`,
    `estate_id`,
    `status`,
    `period_type`,
    `price`,
    `date_start`,
    `date_end`
  )
VALUES
  (
    13,
    13,
    7,
    'closed',
    'monthly',
    3000,
    '2021-03-25 05:00:00',
    '2021-04-12 00:00:00'
  );
INSERT INTO
  `contract` (
    `id`,
    `client_id`,
    `estate_id`,
    `status`,
    `period_type`,
    `price`,
    `date_start`,
    `date_end`
  )
VALUES
  (
    14,
    14,
    7,
    'active',
    'monthly',
    3000,
    '2021-04-19 06:00:00',
    '0000-00-00 00:00:00'
  );
INSERT INTO
  `contract` (
    `id`,
    `client_id`,
    `estate_id`,
    `status`,
    `period_type`,
    `price`,
    `date_start`,
    `date_end`
  )
VALUES
  (
    19,
    0,
    5,
    'active',
    'monthly',
    3000,
    '2023-01-18 00:00:00',
    '0000-00-00 00:00:00'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: country
# ------------------------------------------------------------

INSERT INTO
  `country` (`id`, `name`)
VALUES
  (1, 'Украина');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: estate
# ------------------------------------------------------------

INSERT INTO
  `estate` (
    `comment`,
    `id`,
    `address_id`,
    `house_number`,
    `apartment_number`,
    `square`,
    `photos`
  )
VALUES
  ('Пацаева', 1, 1, '10', 87, 24, '001');
INSERT INTO
  `estate` (
    `comment`,
    `id`,
    `address_id`,
    `house_number`,
    `apartment_number`,
    `square`,
    `photos`
  )
VALUES
  ('Жадова', 2, 2, '19', 3, 24, '002');
INSERT INTO
  `estate` (
    `comment`,
    `id`,
    `address_id`,
    `house_number`,
    `apartment_number`,
    `square`,
    `photos`
  )
VALUES
  ('Попова', 3, 3, '20', 84, 60, '003');
INSERT INTO
  `estate` (
    `comment`,
    `id`,
    `address_id`,
    `house_number`,
    `apartment_number`,
    `square`,
    `photos`
  )
VALUES
  ('Земля', 4, 4, '67', 0, 1200, '004');
INSERT INTO
  `estate` (
    `comment`,
    `id`,
    `address_id`,
    `house_number`,
    `apartment_number`,
    `square`,
    `photos`
  )
VALUES
  ('Дача', 5, 5, '', 0, 600, '005');
INSERT INTO
  `estate` (
    `comment`,
    `id`,
    `address_id`,
    `house_number`,
    `apartment_number`,
    `square`,
    `photos`
  )
VALUES
  ('Vasylia Nikitina', 6, 6, '15', 28, 21, '006');
INSERT INTO
  `estate` (
    `comment`,
    `id`,
    `address_id`,
    `house_number`,
    `apartment_number`,
    `square`,
    `photos`
  )
VALUES
  ('', 7, 6, '15', 91, 21, '007');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: expense
# ------------------------------------------------------------

INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    1,
    1,
    0,
    '',
    245372.5,
    'Покупка квартиры ( 8045 eur )',
    '2018-05-23 00:00:00'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    2,
    2,
    0,
    '',
    290875,
    'Покупка квартиры ( 8950 eur )',
    '2018-09-04 00:00:00'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (3, 1, 0, '', 2900, 'Нотариус', '2019-02-11 21:41:16');
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    4,
    1,
    0,
    '',
    877,
    'Переоформление',
    '2019-02-11 21:41:16'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    5,
    1,
    0,
    '',
    12925,
    'Риелтор ( 500 $ )',
    '2019-02-11 21:59:48'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    6,
    1,
    2,
    'accessory',
    2500,
    'Бойлер',
    '2019-02-11 22:04:12'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    7,
    1,
    0,
    'service',
    500,
    'Установка бойлера',
    '2019-02-11 22:07:10'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    8,
    1,
    3,
    'accessory',
    5000,
    'Балконный блок',
    '2019-02-11 22:09:27'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    9,
    2,
    6,
    'accessory',
    1350,
    'Покупка унитаза',
    '2018-09-12 04:00:00'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    10,
    2,
    0,
    'service',
    450,
    'Установка унитаза',
    '2018-09-14 17:00:00'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    11,
    2,
    0,
    'service',
    400,
    'Покупка труб к унитазу',
    '2018-09-14 17:37:02'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    12,
    2,
    0,
    'service',
    300,
    'Кран, Свет',
    '2019-10-26 20:45:48'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    13,
    1,
    0,
    'service',
    2000,
    'Диван',
    '2019-10-26 21:06:19'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    14,
    2,
    0,
    'accessory',
    6000,
    'Диван, Стенка',
    '2019-10-26 21:16:29'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    15,
    6,
    0,
    '',
    281742.6,
    'Покупка квартиры ( 10436.57 eur )',
    '2019-11-13 18:09:15'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    16,
    6,
    0,
    'accessory',
    2500,
    'Шкаф',
    '2019-11-13 18:28:39'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    17,
    6,
    0,
    'accessory',
    3500,
    'Холодильник',
    '2019-11-13 18:28:39'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    18,
    6,
    0,
    'accessory',
    3000,
    'Стиральная машина',
    '2019-11-13 18:28:39'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    19,
    6,
    0,
    '',
    12502,
    'Риелтор ( 470 € ) курс 26.6',
    '2019-11-13 18:32:55'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (20, 6, 0, '', 1364, 'Касса', '2019-11-14 20:52:38');
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    21,
    6,
    0,
    '',
    4000,
    'Иннеса за документы',
    '2019-11-14 20:52:38'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (22, 6, 0, '', 470, 'Касса', '2019-11-14 20:52:38');
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    23,
    1,
    0,
    'accessory',
    350,
    'Электрика, счетчик',
    '2019-11-19 20:35:50'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    24,
    1,
    0,
    'accessory',
    200,
    'Замок на дверях',
    '2019-11-19 20:39:45'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    25,
    1,
    0,
    'accessory',
    250,
    'Замена стекла дверей',
    '2019-11-19 20:39:45'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    26,
    1,
    0,
    'accessory',
    40,
    'Подставка для шампуней',
    '2019-11-19 20:39:45'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    27,
    1,
    0,
    'service',
    100,
    'Бензин и прочее',
    '2019-11-19 20:39:45'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    28,
    2,
    0,
    'service',
    50,
    'Электричество',
    '2019-11-19 21:01:54'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    29,
    6,
    0,
    'accessory',
    400,
    'Кран',
    '2019-12-06 21:11:58'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    30,
    6,
    0,
    'service',
    500,
    'Бензин',
    '2019-12-06 21:11:58'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    31,
    2,
    0,
    'service',
    700,
    'Покупка Кран',
    '2020-01-25 05:00:00'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    32,
    5,
    0,
    'service',
    2000,
    'оплата дачи за 2020 год',
    '2020-12-19 19:17:11'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    33,
    7,
    0,
    'service',
    1096,
    'коммунальные',
    '2021-04-26 16:25:51'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    34,
    7,
    0,
    'service',
    300,
    'Бензин',
    '2021-04-26 16:25:51'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    35,
    6,
    4,
    'accessory',
    1900,
    '1500+200+200 бензин мы старую машинку забирали и два раза туда обратно а это далеко',
    '2021-09-05 04:00:00'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    36,
    2,
    0,
    'accessory',
    2700,
    'на двухтарифный счетчик',
    '2021-10-10 17:40:06'
  );
INSERT INTO
  `expense` (
    `id`,
    `estate_id`,
    `ref_estate_accessory_id`,
    `type`,
    `amount`,
    `description`,
    `date`
  )
VALUES
  (
    37,
    6,
    0,
    'accessory',
    600,
    'Кран и трубки',
    '2021-08-06 04:00:00'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: payment
# ------------------------------------------------------------

INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    1,
    1,
    1800,
    '2018-06-01 00:00:00',
    'pending',
    '2018-06-01 00:00:00',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    2,
    1,
    1800,
    '2018-07-01 00:00:00',
    'pending',
    '2018-07-01 00:00:00',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    3,
    1,
    1800,
    '2018-08-01 00:00:00',
    'pending',
    '2018-08-01 00:00:00',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    4,
    1,
    1800,
    '2018-09-01 00:00:00',
    'pending',
    '2018-09-01 00:00:00',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    5,
    2,
    0,
    '2018-09-20 00:00:00',
    'pending',
    '2018-10-01 00:00:00',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    6,
    2,
    2200,
    '2018-10-01 00:00:00',
    'pending',
    '2019-02-11 18:18:39',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    7,
    2,
    2200,
    '2018-11-01 00:00:00',
    'pending',
    '2019-02-11 18:19:06',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    8,
    2,
    2200,
    '2018-12-01 00:00:00',
    'pending',
    '2019-02-11 18:21:36',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    9,
    2,
    500,
    '2019-01-01 00:00:00',
    'pending',
    '2019-02-11 18:21:36',
    'Долг'
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    10,
    3,
    2500,
    '2019-02-01 00:00:00',
    'pending',
    '2019-02-11 18:21:36',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    11,
    1,
    1800,
    '2018-10-01 00:00:00',
    'pending',
    '2019-02-11 20:39:07',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    12,
    1,
    1800,
    '2018-11-01 00:00:00',
    'pending',
    '2019-02-11 20:40:44',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    13,
    4,
    2000,
    '2018-12-01 00:00:00',
    'pending',
    '2019-02-11 20:40:44',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    14,
    3,
    2500,
    '2019-03-01 00:00:00',
    'pending',
    '2019-04-12 08:13:24',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    15,
    4,
    2000,
    '2019-01-01 00:00:00',
    'pending',
    '2019-04-12 08:22:53',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    16,
    4,
    2000,
    '2019-02-01 00:00:00',
    'pending',
    '2019-04-12 08:22:53',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    17,
    5,
    3000,
    '2019-04-13 00:00:00',
    'pending',
    '2019-07-10 20:59:37',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    18,
    5,
    3000,
    '2019-05-01 00:00:00',
    'pending',
    '2019-07-10 21:01:55',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    19,
    5,
    3000,
    '2019-06-01 00:00:00',
    'pending',
    '2019-07-10 21:01:55',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    20,
    4,
    2000,
    '2019-03-01 00:00:00',
    'pending',
    '2019-07-10 21:27:39',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    21,
    4,
    1500,
    '2019-04-01 00:00:00',
    'pending',
    '2019-07-10 21:28:14',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    22,
    4,
    2000,
    '2019-05-01 00:00:00',
    'pending',
    '2019-07-10 21:31:10',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    23,
    4,
    2000,
    '2019-06-01 00:00:00',
    'pending',
    '2019-07-10 21:31:10',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    24,
    6,
    2800,
    '2019-07-01 00:00:00',
    'pending',
    '2019-09-12 19:45:01',
    '.200 интернет'
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    27,
    4,
    2000,
    '2019-07-01 00:00:00',
    'pending',
    '2019-09-12 20:07:35',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    33,
    6,
    3000,
    '2019-09-15 00:00:00',
    'pending',
    '2019-09-22 17:39:38',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    34,
    6,
    3000,
    '2019-10-23 00:00:00',
    'pending',
    '2019-10-26 20:42:02',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    35,
    6,
    3000,
    '2019-11-18 00:00:00',
    'pending',
    '2019-11-19 20:01:45',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    36,
    6,
    3000,
    '2019-08-19 00:00:00',
    'pending',
    '2019-11-19 20:23:24',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    38,
    7,
    2000,
    '2019-11-01 00:00:00',
    'pending',
    '2019-12-06 20:51:21',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    39,
    8,
    3000,
    '2019-11-25 00:00:00',
    'pending',
    '2019-12-06 21:12:48',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    40,
    6,
    3000,
    '2019-12-22 00:00:00',
    'pending',
    '2019-12-23 12:26:03',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    45,
    7,
    2000,
    '2019-12-27 00:00:00',
    'pending',
    '2020-01-05 20:45:21',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    46,
    8,
    3000,
    '2019-12-20 00:00:00',
    'pending',
    '2020-01-11 18:31:20',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    47,
    7,
    2000,
    '2020-01-05 00:00:00',
    'pending',
    '2020-01-11 19:07:28',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    48,
    7,
    2000,
    '2020-02-03 00:00:00',
    'pending',
    '2020-02-03 19:31:12',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    49,
    8,
    3000,
    '2020-01-25 00:00:00',
    'pending',
    '2020-02-03 19:33:26',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    51,
    6,
    3000,
    '2020-01-15 00:00:00',
    'pending',
    '2020-02-10 18:42:06',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    52,
    7,
    2000,
    '2020-03-03 00:00:00',
    'pending',
    '2020-03-12 20:18:22',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    53,
    6,
    3000,
    '2020-02-20 00:00:00',
    'pending',
    '2020-03-12 20:19:07',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    54,
    8,
    3000,
    '2020-02-25 00:00:00',
    'pending',
    '2020-03-12 20:19:32',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    55,
    9,
    3000,
    '2020-04-01 00:00:00',
    'pending',
    '2020-12-06 17:06:27',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    56,
    9,
    3000,
    '2020-05-01 00:00:00',
    'pending',
    '2020-12-06 17:12:16',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    57,
    9,
    3000,
    '2020-06-01 00:00:00',
    'pending',
    '2020-12-06 17:13:42',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    58,
    9,
    3000,
    '2020-07-01 00:00:00',
    'pending',
    '2020-12-06 17:13:56',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    59,
    9,
    3000,
    '2020-08-01 00:00:00',
    'pending',
    '2020-12-06 17:14:11',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    60,
    9,
    3000,
    '2020-09-01 00:00:00',
    'pending',
    '2020-12-06 17:14:57',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    61,
    10,
    2900,
    '2020-10-01 00:00:00',
    'pending',
    '2020-12-06 17:15:32',
    '(Вл - 300)'
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    62,
    10,
    2900,
    '2020-11-01 00:00:00',
    'pending',
    '2020-12-06 17:15:55',
    '(Владик - 300)'
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    63,
    7,
    2000,
    '2020-04-01 00:00:00',
    'pending',
    '2020-12-06 17:20:55',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    64,
    7,
    2000,
    '2020-05-01 00:00:00',
    'pending',
    '2020-12-06 17:21:12',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    65,
    7,
    2000,
    '2020-06-01 00:00:00',
    'pending',
    '2020-12-06 17:21:29',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    66,
    7,
    2000,
    '2020-07-01 00:00:00',
    'pending',
    '2020-12-06 17:21:37',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    67,
    7,
    2000,
    '2020-08-01 00:00:00',
    'pending',
    '2020-12-06 17:21:54',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    68,
    7,
    2000,
    '2020-09-01 00:00:00',
    'pending',
    '2020-12-06 17:22:04',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    69,
    7,
    2000,
    '2020-10-01 00:00:00',
    'pending',
    '2020-12-06 17:22:16',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    70,
    7,
    2000,
    '2020-11-01 00:00:00',
    'pending',
    '2020-12-06 17:22:26',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    71,
    6,
    3000,
    '2020-03-01 00:00:00',
    'pending',
    '2020-12-06 17:23:56',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    72,
    6,
    3000,
    '2020-04-01 00:00:00',
    'pending',
    '2020-12-06 17:24:08',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    73,
    6,
    3000,
    '2020-05-01 00:00:00',
    'pending',
    '2020-12-06 17:24:20',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    74,
    6,
    3000,
    '2020-06-01 00:00:00',
    'pending',
    '2020-12-06 17:24:28',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    75,
    6,
    3000,
    '2020-07-01 00:00:00',
    'pending',
    '2020-12-06 17:24:40',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    76,
    6,
    3000,
    '2020-08-01 00:00:00',
    'pending',
    '2020-12-06 17:24:56',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    77,
    6,
    3000,
    '2020-09-01 00:00:00',
    'pending',
    '2020-12-06 17:25:09',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    79,
    6,
    3000,
    '2020-10-01 00:00:00',
    'pending',
    '2020-12-19 18:56:47',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    81,
    6,
    3000,
    '2020-12-01 00:00:00',
    'pending',
    '2020-12-19 18:58:47',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    82,
    6,
    3000,
    '2020-11-01 00:00:00',
    'pending',
    '2020-12-19 18:59:36',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    83,
    11,
    2000,
    '2020-09-01 00:00:00',
    'pending',
    '2020-12-19 19:11:05',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    84,
    11,
    2000,
    '2020-10-01 00:00:00',
    'pending',
    '2020-12-19 19:11:14',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    85,
    11,
    2000,
    '2020-11-01 00:00:00',
    'pending',
    '2020-12-19 19:12:21',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    87,
    11,
    1000,
    '2020-12-01 00:00:00',
    'pending',
    '2020-12-19 19:13:00',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    88,
    10,
    2900,
    '2020-12-01 00:00:00',
    'pending',
    '2021-04-14 17:10:52',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    89,
    10,
    2900,
    '2021-01-01 00:00:00',
    'pending',
    '2021-04-14 17:11:39',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    90,
    10,
    3000,
    '2021-02-01 00:00:00',
    'pending',
    '2021-04-14 17:12:03',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    91,
    10,
    3000,
    '2021-03-01 00:00:00',
    'pending',
    '2021-04-14 17:14:36',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    92,
    6,
    3000,
    '2021-01-01 00:00:00',
    'pending',
    '2021-04-14 17:15:35',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    93,
    6,
    3000,
    '2021-02-01 00:00:00',
    'pending',
    '2021-04-14 17:15:42',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    94,
    6,
    3000,
    '2021-03-01 00:00:00',
    'pending',
    '2021-04-14 17:15:51',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    95,
    7,
    2000,
    '2020-12-01 00:00:00',
    'pending',
    '2021-04-14 17:16:27',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    96,
    7,
    2000,
    '2021-01-01 00:00:00',
    'pending',
    '2021-04-14 17:16:36',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    97,
    7,
    2000,
    '2021-02-01 00:00:00',
    'pending',
    '2021-04-14 17:16:50',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    98,
    7,
    2000,
    '2021-03-01 00:00:00',
    'pending',
    '2021-04-14 17:16:58',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    99,
    12,
    3000,
    '2021-04-12 00:00:00',
    'pending',
    '2021-04-26 16:14:39',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    100,
    13,
    2800,
    '2021-03-25 00:00:00',
    'pending',
    '2021-04-26 16:18:53',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    101,
    14,
    3000,
    '2021-04-19 00:00:00',
    'pending',
    '2021-04-26 16:20:55',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    102,
    12,
    2600,
    '2021-05-03 00:00:00',
    'pending',
    '2021-07-25 18:24:50',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    104,
    12,
    3000,
    '2021-06-01 00:00:00',
    'pending',
    '2021-07-25 18:26:00',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    106,
    7,
    2100,
    '2021-06-01 00:00:00',
    'pending',
    '2021-07-25 18:31:38',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    107,
    7,
    2000,
    '2021-05-01 00:00:00',
    'pending',
    '2021-07-25 18:33:04',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    108,
    7,
    2000,
    '2021-04-01 00:00:00',
    'pending',
    '2021-07-25 18:33:15',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    109,
    7,
    2500,
    '2021-07-01 00:00:00',
    'pending',
    '2021-07-25 18:33:50',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    110,
    6,
    3000,
    '2021-04-01 00:00:00',
    'pending',
    '2021-07-25 18:35:07',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    111,
    6,
    3000,
    '2021-05-01 00:00:00',
    'pending',
    '2021-07-25 18:35:15',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    112,
    6,
    3000,
    '2021-06-01 00:00:00',
    'pending',
    '2021-07-25 18:35:22',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    115,
    6,
    3000,
    '2021-07-01 00:00:00',
    'pending',
    '2021-12-28 18:30:27',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    116,
    6,
    3000,
    '2021-08-01 00:00:00',
    'pending',
    '2021-12-28 18:30:52',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    117,
    6,
    3000,
    '2021-09-01 00:00:00',
    'pending',
    '2021-12-28 18:31:00',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    121,
    7,
    2000,
    '2021-08-01 00:00:00',
    'pending',
    '2021-12-28 19:02:53',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    122,
    7,
    2000,
    '2021-09-01 00:00:00',
    'pending',
    '2021-12-28 19:03:03',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    123,
    7,
    2000,
    '2021-10-01 00:00:00',
    'pending',
    '2021-12-28 19:03:13',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    124,
    7,
    2000,
    '2021-11-01 00:00:00',
    'pending',
    '2021-12-28 19:03:31',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    125,
    7,
    2000,
    '2021-12-01 00:00:00',
    'pending',
    '2021-12-28 19:03:46',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    126,
    12,
    3000,
    '2021-07-01 00:00:00',
    'pending',
    '2021-12-28 19:04:44',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    127,
    12,
    3000,
    '2021-08-01 00:00:00',
    'pending',
    '2021-12-28 19:05:15',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    128,
    12,
    3000,
    '2021-09-01 00:00:00',
    'pending',
    '2021-12-28 19:05:23',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    129,
    12,
    3000,
    '2021-10-01 00:00:00',
    'pending',
    '2021-12-28 19:05:29',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    130,
    12,
    3000,
    '2021-11-01 00:00:00',
    'pending',
    '2021-12-28 19:05:46',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    131,
    6,
    3000,
    '2021-10-01 00:00:00',
    'pending',
    '2022-09-21 18:08:11',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    132,
    6,
    3000,
    '2021-11-01 00:00:00',
    'pending',
    '2022-09-21 18:08:26',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    133,
    6,
    3000,
    '2021-12-01 00:00:00',
    'pending',
    '2022-09-21 18:08:33',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    134,
    6,
    3000,
    '2022-01-01 00:00:00',
    'pending',
    '2022-09-21 18:08:50',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    135,
    6,
    3000,
    '2022-02-01 00:00:00',
    'pending',
    '2022-09-21 18:08:59',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    136,
    6,
    3000,
    '2022-03-01 00:00:00',
    'pending',
    '2022-09-21 18:09:06',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    137,
    6,
    3000,
    '2022-04-01 00:00:00',
    'pending',
    '2022-09-21 18:09:13',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    138,
    6,
    3000,
    '2022-05-01 00:00:00',
    'pending',
    '2022-09-21 18:09:23',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    139,
    6,
    3000,
    '2022-06-01 00:00:00',
    'pending',
    '2022-09-21 18:09:48',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    140,
    6,
    3000,
    '2022-07-01 00:00:00',
    'pending',
    '2022-09-21 18:10:03',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    141,
    6,
    3000,
    '2022-08-01 00:00:00',
    'pending',
    '2022-09-21 18:10:13',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    142,
    12,
    3000,
    '2021-12-01 00:00:00',
    'pending',
    '2022-09-21 18:47:58',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    143,
    12,
    3000,
    '2022-01-01 00:00:00',
    'pending',
    '2022-09-21 18:48:34',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    144,
    12,
    3000,
    '2022-02-01 00:00:00',
    'pending',
    '2022-09-21 18:48:42',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    145,
    12,
    3000,
    '2022-03-01 00:00:00',
    'pending',
    '2022-09-21 18:48:47',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    146,
    12,
    4000,
    '2022-04-01 00:00:00',
    'pending',
    '2022-09-21 18:49:09',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    147,
    12,
    4000,
    '2022-05-01 00:00:00',
    'pending',
    '2022-09-21 18:49:18',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    148,
    12,
    4000,
    '2022-06-01 00:00:00',
    'pending',
    '2022-09-21 18:49:26',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    149,
    12,
    4000,
    '2022-07-01 00:00:00',
    'pending',
    '2022-09-21 18:49:31',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    150,
    12,
    4000,
    '2022-08-01 00:00:00',
    'pending',
    '2022-09-21 18:49:37',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    151,
    7,
    2000,
    '2022-01-01 00:00:00',
    'pending',
    '2022-09-21 19:22:06',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    152,
    7,
    2000,
    '2022-02-01 00:00:00',
    'pending',
    '2022-09-21 19:22:18',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    153,
    7,
    2000,
    '2022-04-01 00:00:00',
    'pending',
    '2022-09-21 19:22:44',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    154,
    7,
    2500,
    '2022-05-01 00:00:00',
    'pending',
    '2022-09-21 19:22:53',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    155,
    7,
    2500,
    '2022-06-01 00:00:00',
    'pending',
    '2022-09-21 19:23:00',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    156,
    7,
    2500,
    '2022-07-01 00:00:00',
    'pending',
    '2022-09-21 19:23:05',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    157,
    7,
    2500,
    '2022-08-01 00:00:00',
    'pending',
    '2022-09-21 19:23:11',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    158,
    7,
    2500,
    '2022-09-01 00:00:00',
    'pending',
    '2022-11-14 18:44:54',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    159,
    7,
    2500,
    '2022-10-01 00:00:00',
    'pending',
    '2022-11-14 18:45:03',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    160,
    7,
    3500,
    '2022-11-01 00:00:00',
    'pending',
    '2022-11-14 18:45:57',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    161,
    12,
    4000,
    '2022-09-01 00:00:00',
    'pending',
    '2022-11-14 18:49:46',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    162,
    12,
    4500,
    '2022-10-01 00:00:00',
    'pending',
    '2022-11-14 18:49:58',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    163,
    15,
    1000,
    '2022-10-01 00:00:00',
    'pending',
    '0000-00-00 00:00:00',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    167,
    15,
    1000,
    '2022-10-01 00:00:00',
    'pending',
    '0000-00-00 00:00:00',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    165,
    15,
    500,
    '2022-10-01 00:00:00',
    'pending',
    '0000-00-00 00:00:00',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    166,
    15,
    1000,
    '2022-10-01 00:00:00',
    'pending',
    '0000-00-00 00:00:00',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    168,
    15,
    1000,
    '2022-12-01 00:00:00',
    'pending',
    '2023-01-16 17:17:14',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    169,
    15,
    1000,
    '2022-12-01 00:00:00',
    'pending',
    '2023-01-16 17:17:51',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    170,
    15,
    1000,
    '2022-12-01 00:00:00',
    'pending',
    '2023-01-16 17:17:53',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    171,
    19,
    5,
    '2023-01-02 00:00:00',
    'pending',
    '2023-01-19 00:00:00',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    172,
    19,
    0,
    '0000-00-00 00:00:00',
    'pending',
    '0000-00-00 00:00:00',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    173,
    19,
    6000,
    '0000-00-00 00:00:00',
    'pending',
    '0000-00-00 00:00:00',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    174,
    0,
    0,
    '2023-03-31 17:22:51',
    'pending',
    '2023-03-31 17:22:51',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    175,
    0,
    0,
    '2023-04-01 13:57:50',
    'pending',
    '2023-04-01 13:57:50',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    176,
    0,
    0,
    '2023-04-01 13:58:25',
    'pending',
    '2023-04-01 13:58:25',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    177,
    0,
    0,
    '2023-04-01 14:05:24',
    'pending',
    '2023-04-01 14:05:24',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    178,
    0,
    0,
    '2023-04-01 14:06:29',
    'pending',
    '2023-04-01 14:06:29',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    179,
    0,
    0,
    '2023-04-01 14:45:16',
    'pending',
    '2023-04-01 14:45:16',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    180,
    0,
    0,
    '2023-04-01 14:48:42',
    'pending',
    '2023-04-01 14:48:42',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    181,
    0,
    0,
    '2023-04-01 14:53:07',
    'pending',
    '2023-04-01 14:53:07',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `amount`,
    `period`,
    `status`,
    `date`,
    `comment`
  )
VALUES
  (
    182,
    0,
    0,
    '2023-04-01 14:56:07',
    'pending',
    '2023-04-01 14:56:07',
    ''
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: ref_estate_accessory
# ------------------------------------------------------------

INSERT INTO
  `ref_estate_accessory` (`id`, `estate_id`, `accessory_id`, `status`)
VALUES
  (1, 1, 1, 'old');
INSERT INTO
  `ref_estate_accessory` (`id`, `estate_id`, `accessory_id`, `status`)
VALUES
  (2, 1, 2, 'new');
INSERT INTO
  `ref_estate_accessory` (`id`, `estate_id`, `accessory_id`, `status`)
VALUES
  (3, 1, 3, 'new');
INSERT INTO
  `ref_estate_accessory` (`id`, `estate_id`, `accessory_id`, `status`)
VALUES
  (4, 1, 4, 'old');
INSERT INTO
  `ref_estate_accessory` (`id`, `estate_id`, `accessory_id`, `status`)
VALUES
  (5, 1, 4, 'normal');
INSERT INTO
  `ref_estate_accessory` (`id`, `estate_id`, `accessory_id`, `status`)
VALUES
  (6, 2, 1, 'new');
INSERT INTO
  `ref_estate_accessory` (`id`, `estate_id`, `accessory_id`, `status`)
VALUES
  (7, 2, 2, 'normal');
INSERT INTO
  `ref_estate_accessory` (`id`, `estate_id`, `accessory_id`, `status`)
VALUES
  (8, 2, 4, 'normal');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: role
# ------------------------------------------------------------

INSERT INTO
  `role` (`id`, `name`, `description`)
VALUES
  (1, 'Admin', 'Admin');
INSERT INTO
  `role` (`id`, `name`, `description`)
VALUES
  (2, 'Сlient', 'Сlient');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: state
# ------------------------------------------------------------

INSERT INTO
  `state` (`id`, `name`)
VALUES
  (1, 'Кировоградская');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: task
# ------------------------------------------------------------

INSERT INTO
  `task` (
    `id`,
    `title`,
    `name`,
    `data`,
    `status`,
    `date_start`,
    `interval`
  )
VALUES
  (
    1,
    'Contract',
    'contract',
    '',
    'closed',
    '2023-01-19 12:00:00',
    '0 * * * * *'
  );
INSERT INTO
  `task` (
    `id`,
    `title`,
    `name`,
    `data`,
    `status`,
    `date_start`,
    `interval`
  )
VALUES
  (
    2,
    'Utilitymeter',
    'Utilitymeter',
    '',
    'active',
    '2023-04-08 02:00:00',
    '0 * * * * *'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: user
# ------------------------------------------------------------

INSERT INTO
  `user` (`id`, `username`, `email`, `password`, `role_id`)
VALUES
  (
    1,
    'admin',
    '',
    '$2a$10$OWisVlgw8VCvovKiKAyD8.xJg0H3d6B6amKHOII5t6AQxVa7FzlnW',
    '0'
  );
INSERT INTO
  `user` (`id`, `username`, `email`, `password`, `role_id`)
VALUES
  (
    2,
    'temp',
    '',
    '$2a$10$OWisVlgw8VCvovKiKAyD8.xJg0H3d6B6amKHOII5t6AQxVa7FzlnW',
    '1'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: utilitymeter
# ------------------------------------------------------------

INSERT INTO
  `utilitymeter` (
    `id`,
    `code`,
    `utilityservice_id`,
    `estate_id`,
    `price`,
    `meter_before`,
    `meter_current`,
    `description`,
    `date`
  )
VALUES
  (
    1,
    '1',
    8,
    5,
    319.62,
    1,
    3,
    'electricity-day',
    '2023-03-01 21:11:09'
  );
INSERT INTO
  `utilitymeter` (
    `id`,
    `code`,
    `utilityservice_id`,
    `estate_id`,
    `price`,
    `meter_before`,
    `meter_current`,
    `description`,
    `date`
  )
VALUES
  (
    2,
    '2',
    9,
    2,
    1395.08,
    0,
    0,
    'test',
    '2023-04-08 21:11:09'
  );
INSERT INTO
  `utilitymeter` (
    `id`,
    `code`,
    `utilityservice_id`,
    `estate_id`,
    `price`,
    `meter_before`,
    `meter_current`,
    `description`,
    `date`
  )
VALUES
  (
    4,
    '3',
    9,
    5,
    1395.08,
    0,
    0,
    'electricity-night',
    '2023-04-08 22:50:45'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: utilityservice
# ------------------------------------------------------------

INSERT INTO
  `utilityservice` (
    `id`,
    `name`,
    `unit`,
    `description`,
    `date`,
    `tariff_url`,
    `tariff_selector`
  )
VALUES
  (
    8,
    'electricity-day',
    'kW*h',
    'послуги з розподілу електричної енергії',
    '2023-04-06 13:19:39',
    'https://kiroe.com.ua/tarifi',
    '$(\"div:contains(\'для 1 класу напруги\')\")\n.eq(%me%.length-1)\n.text()\n.split(\'-\')\n%me%[2]\n.replace(/[^0-9,]/g, \'\')\n.replace(/,/g, \'.\')'
  );
INSERT INTO
  `utilityservice` (
    `id`,
    `name`,
    `unit`,
    `description`,
    `date`,
    `tariff_url`,
    `tariff_selector`
  )
VALUES
  (
    9,
    'electricity-night',
    'kW*h',
    'послуги з розподілу електричної енергії',
    '2023-04-06 13:19:39',
    'https://kiroe.com.ua/tarifi',
    '$(\"div:contains(\'для 2 класу напруги\')\")\n.eq(%me%.length-1)\n.text();\n.split(\'-\')\n%me%[2]\n.replace(/[^0-9,]/g, \'\')\n.replace(/,/g, \'.\')'
  );
INSERT INTO
  `utilityservice` (
    `id`,
    `name`,
    `unit`,
    `description`,
    `date`,
    `tariff_url`,
    `tariff_selector`
  )
VALUES
  (
    10,
    'gas',
    'm^3',
    'газ',
    '2023-04-06 13:19:26',
    'https://gas.ua/uk/home/tariffs',
    ''
  );
INSERT INTO
  `utilityservice` (
    `id`,
    `name`,
    `unit`,
    `description`,
    `date`,
    `tariff_url`,
    `tariff_selector`
  )
VALUES
  (
    11,
    'gas-distribution',
    'm^3',
    'газ',
    '2023-04-06 13:19:26',
    '',
    ''
  );
INSERT INTO
  `utilityservice` (
    `id`,
    `name`,
    `unit`,
    `description`,
    `date`,
    `tariff_url`,
    `tariff_selector`
  )
VALUES
  (
    12,
    'water-supply',
    'm^3',
    'централізоване водопостачання',
    '2023-04-06 13:19:19',
    '',
    ''
  );
INSERT INTO
  `utilityservice` (
    `id`,
    `name`,
    `unit`,
    `description`,
    `date`,
    `tariff_url`,
    `tariff_selector`
  )
VALUES
  (
    13,
    'water-drainage',
    'm^3',
    'централізоване водовідведення',
    '2023-04-06 13:19:19',
    '',
    ''
  );
INSERT INTO
  `utilityservice` (
    `id`,
    `name`,
    `unit`,
    `description`,
    `date`,
    `tariff_url`,
    `tariff_selector`
  )
VALUES
  (
    14,
    'water-service',
    'm^3',
    'обслуговування та заміна',
    '2023-04-06 13:19:19',
    '',
    ''
  );
INSERT INTO
  `utilityservice` (
    `id`,
    `name`,
    `unit`,
    `description`,
    `date`,
    `tariff_url`,
    `tariff_selector`
  )
VALUES
  (15, 'warm', '', 'тепло', '2023-04-06 13:18:38', '', '');
INSERT INTO
  `utilityservice` (
    `id`,
    `name`,
    `unit`,
    `description`,
    `date`,
    `tariff_url`,
    `tariff_selector`
  )
VALUES
  (
    16,
    'recycling',
    '',
    'вивезення та захоронення ТПВ',
    '2023-04-06 13:19:04',
    'https://ecostyle.ua/',
    ''
  );
INSERT INTO
  `utilityservice` (
    `id`,
    `name`,
    `unit`,
    `description`,
    `date`,
    `tariff_url`,
    `tariff_selector`
  )
VALUES
  (
    17,
    'housing_maintenance',
    '',
    'ЖЕО',
    '2023-04-06 13:18:53',
    '',
    ''
  );
INSERT INTO
  `utilityservice` (
    `id`,
    `name`,
    `unit`,
    `description`,
    `date`,
    `tariff_url`,
    `tariff_selector`
  )
VALUES
  (
    18,
    'internet',
    '',
    'интернет',
    '2023-04-06 13:19:11',
    '',
    ''
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: utilityservice_invoice
# ------------------------------------------------------------


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
