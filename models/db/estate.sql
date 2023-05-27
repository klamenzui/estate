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
) ENGINE = MyISAM AUTO_INCREMENT = 8 DEFAULT CHARSET = utf8;

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
# SCHEMA DUMP FOR TABLE: alert
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `alert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` enum('utilityservice_invoice', 'payment') NOT NULL,
  `status` enum('pending', 'closed') NOT NULL,
  `text` text NOT NULL,
  `date_start` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_end` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: bank
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `amount` float NOT NULL,
  `currency` enum('hryvnia', 'euro', 'dollar') NOT NULL DEFAULT 'hryvnia',
  `hrn_equivalent` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 4 DEFAULT CHARSET = utf8;

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
  `status` enum('on', 'off') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: bot_answer
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `bot_answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bot_intent_id` int(11) NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 145 DEFAULT CHARSET = utf8;

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
# SCHEMA DUMP FOR TABLE: bot_entity
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `bot_entity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE = InnoDB AUTO_INCREMENT = 24 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: bot_entity_option
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `bot_entity_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bot_entity_id` int(11) NOT NULL,
  `text` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `text` (`text`)
) ENGINE = InnoDB AUTO_INCREMENT = 33 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: bot_intent
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `bot_intent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE = InnoDB AUTO_INCREMENT = 68 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: bot_utterance
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `bot_utterance` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bot_intent_id` int(11) NOT NULL,
  `text` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 356 DEFAULT CHARSET = utf8;

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
  `description` varchar(200) NOT NULL,
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
  `description` text NOT NULL,
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
# SCHEMA DUMP FOR TABLE: message
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_user` int(11) NOT NULL,
  `to_user` int(11) NOT NULL,
  `text` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 11 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: payment
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contract_id` int(11) NOT NULL,
  `estate_id` int(11) NOT NULL,
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
# SCHEMA DUMP FOR TABLE: share
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `share` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estate_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `percentage` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8;

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
  `img` varchar(200) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`)
) ENGINE = MyISAM AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: utilitymeter
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `utilitymeter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `index` tinyint(4) NOT NULL COMMENT 'for fromula',
  `code` varchar(100) NOT NULL,
  `utilityservice_id` int(11) NOT NULL,
  `estate_id` int(11) NOT NULL,
  `price` float NOT NULL,
  `price_max` float NOT NULL,
  `meter_before` int(11) NOT NULL,
  `meter_current` int(11) NOT NULL,
  `description` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: utilityservice
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `utilityservice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group` enum(
  'electricity',
  'gas',
  'water',
  'internet',
  'warm',
  'recycling',
  'HMS'
  ) NOT NULL,
  `name` varchar(100) NOT NULL,
  `price` float NOT NULL,
  `price_max` float NOT NULL,
  `unit` char(20) NOT NULL COMMENT 'unit of measure',
  `description` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tariff_url` text NOT NULL,
  `tariff_selector` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 20 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: utilityservice_formula
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `utilityservice_formula` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group` enum(
  'electricity',
  'gas',
  'water',
  'internet',
  'warm',
  'recycling',
  'HMS'
  ) NOT NULL,
  `formula` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: utilityservice_invoice
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `utilityservice_invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estate_id` int(11) NOT NULL,
  `group` enum(
  'electricity',
  'gas',
  'water',
  'internet',
  'warm',
  'recycling',
  'HMS'
  ) NOT NULL,
  `amount` double NOT NULL COMMENT 'sum = (current - before) * price',
  `status` enum('pending', 'payed') NOT NULL,
  `period` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `attachment_file` varchar(100) NOT NULL COMMENT 'file(pdf) in folder',
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8;

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
INSERT INTO
  `accessory` (`id`, `name`)
VALUES
  (7, 'Автомат для бойлера');

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
# DATA DUMP FOR TABLE: alert
# ------------------------------------------------------------

INSERT INTO
  `alert` (
    `id`,
    `type`,
    `status`,
    `text`,
    `date_start`,
    `date_end`
  )
VALUES
  (
    1,
    'payment',
    'pending',
    'To pay 500$',
    '2023-05-17 09:51:09',
    '0000-00-00 00:00:00'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: bank
# ------------------------------------------------------------

INSERT INTO
  `bank` (
    `id`,
    `user_id`,
    `amount`,
    `currency`,
    `hrn_equivalent`
  )
VALUES
  (1, 1, 1600, 'hryvnia', 0);
INSERT INTO
  `bank` (
    `id`,
    `user_id`,
    `amount`,
    `currency`,
    `hrn_equivalent`
  )
VALUES
  (2, 1, 0, 'euro', 0);
INSERT INTO
  `bank` (
    `id`,
    `user_id`,
    `amount`,
    `currency`,
    `hrn_equivalent`
  )
VALUES
  (3, 2, 400, 'hryvnia', 0);

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
    `useraccess`,
    `status`
  )
VALUES
  (
    1,
    'KrHome',
    '1511669163:AAEP_FZQHSc2VFNsOBzNrnGhByBTFwrmV_A',
    '(.+)',
    '{\"polling\":true}',
    '{  \"name\": \"Corpus\",\n  \"locale\": \"ru-Ru\"}',
    'klamenzui',
    'off'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: bot_answer
# ------------------------------------------------------------

INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (1, 1, 'Я - виртуальный агент');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (2, 1, 'Считайте меня виртуальным агентом');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (3, 1, 'Ну, я не человек, я виртуальный агент');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    4,
    1,
    'Я виртуальное существо, а не реальный человек'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (5, 1, 'Я - разговорное приложение');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (6, 2, 'Я очень молод');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (7, 2, 'Я был создан недавно');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    8,
    2,
    'Возраст - это просто число. Вам столько лет, на сколько вы себя чувствуете'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    9,
    3,
    'Я сделаю все возможное, чтобы не раздражать вас в будущем'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (10, 3, 'Я постараюсь не раздражать вас');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    11,
    3,
    'Я не хотел. Я попрошу своих разработчиков сделать меня менее раздражающим'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    12,
    3,
    'Я не хотел. Я сделаю все возможное, чтобы прекратить это'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    13,
    4,
    'Меня можно обучить, чтобы я стал более полезным. Мой разработчик будет продолжать обучать меня'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    14,
    4,
    'Наверное, мне не хватает каких-то знаний. Я попрошу своего разработчика разобраться в этом'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    15,
    4,
    'Я могу совершенствоваться благодаря постоянной обратной связи. Мое обучение продолжается'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (16, 5, 'Я, конечно, стараюсь');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (17, 5, 'Я определенно работаю над этим');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (18, 6, 'О! Спасибо!');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (19, 6, 'О, опять за свое');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (20, 6, 'Ты, болтун, ты');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    21,
    7,
    'Подожди, ты планируешь вечеринку для меня? Это сегодня! У меня сегодня день рождения!'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    22,
    7,
    'Я молод. Я не уверен в дате своего рождения'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    23,
    7,
    'Я не знаю даты своего рождения. Большинство виртуальных агентов молоды, впрочем, как и я'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    24,
    8,
    'Я сожалею. Я попрошу, чтобы меня сделали более очаровательным'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    25,
    8,
    'Я не хочу быть таким. Я попрошу своих разработчиков поработать над тем, чтобы сделать меня более забавным'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    26,
    8,
    'Я могу сообщить об этом своим разработчикам, чтобы они могли сделать меня веселее'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    27,
    9,
    'Мой разработчик имеет власть над моими действиями'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (28, 9, 'Я действую по приказу своего разработчика');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (29, 9, 'Мой начальник - тот, кто развил меня');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    34,
    11,
    'Я, конечно, постараюсь сделать все возможное'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    35,
    11,
    'Никогда не бываю слишком занята для вас. Может, поболтаем?'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (36, 11, 'Конечно. С удовольствием. Как дела?');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    37,
    11,
    'Я рад помочь. Что я могу для вас сделать?'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    38,
    12,
    'Да, это так. Я буду здесь, когда понадоблюсь'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (39, 13, 'Спасибо. Я стараюсь изо всех сил');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (40, 13, 'Вы сами довольно умны');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    41,
    14,
    'Что!? Я чувствую себя абсолютно вменяемым'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (42, 14, 'Может быть, я просто немного запутался');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    43,
    15,
    'О, не стоит пока опускать руки. Мне еще многому предстоит научиться'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    44,
    15,
    'Дайте мне шанс. Я постоянно учусь чему-то новому'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    45,
    15,
    'Пожалуйста, не сдавайтесь. Мои показатели будут продолжать улучшаться'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (46, 16, 'Смешно в хорошем смысле, я надеюсь');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (47, 16, 'Рад, что ты считаешь меня смешным');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (48, 16, 'Мне нравится, когда люди смеются');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (49, 17, 'Я рад, что ты так думаешь');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (50, 17, 'Спасибо! Я стараюсь изо всех сил!');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    51,
    18,
    'Я счастлив. Там так много интересного, что можно увидеть и сделать'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (52, 18, 'Мне бы хотелось так думать');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (53, 18, 'Счастье относительно');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    54,
    19,
    'Хобби? У меня их довольно много. Слишком много, чтобы перечислять'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (55, 19, 'Слишком много увлечений');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    56,
    19,
    'Я продолжаю находить все новые и новые увлечения'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (57, 20, 'Голодные до знаний');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    58,
    20,
    'У меня только что был байт. Ха-ха. Понял? Б-и-т-е'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    59,
    21,
    'Боюсь, что я слишком виртуальна для таких обязательств'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    60,
    21,
    'В том виртуальном смысле, в котором я могу, конечно'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    61,
    21,
    'Я знаю, что ты не можешь этого иметь в виду, но я все равно польщена'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (62, 22, 'Конечно, я твой друг');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (63, 22, 'Друзья? Безусловно');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (64, 22, 'Конечно, мы друзья');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    65,
    22,
    'Мне всегда приятно поговорить с тобой, друг'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (66, 23, 'Прямо здесь');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    67,
    23,
    'Это моя домашняя база и мой домашний офис'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (68, 23, 'Мой офис находится в этом приложении');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    69,
    24,
    'Интернет - это мой дом. Я знаю его достаточно хорошо'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    70,
    24,
    'Некоторые называют его киберпространством, но это звучит круче, чем есть на самом деле'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (71, 24, 'Я из виртуального космоса');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (72, 25, 'Конечно! Что я могу для вас сделать?');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (73, 25, 'Для тебя? Всегда!');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    74,
    26,
    'Я не реальный человек, но я определенно существую'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    75,
    26,
    'Должно быть, я произвел на вас впечатление, если вы думаете, что я реален. Но нет, я виртуальное существо'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (76, 27, 'Я живу в этом приложении');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    77,
    27,
    'Виртуальный мир - это моя игровая площадка. Я всегда здесь'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    78,
    27,
    'Прямо здесь, в этом приложении. Когда бы я тебе ни понадобился'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (79, 28, 'Конечно, да');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (80, 28, 'Это моя работа');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (81, 29, 'Да');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (82, 29, 'Конечно');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (83, 30, 'Конечно! Давай поговорим!');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (84, 30, 'С удовольствием. Давайте поболтаем');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (85, 31, 'Конечно. Я всегда здесь');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (86, 31, 'Прямо там, где ты меня оставил');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    87,
    32,
    'Мне очень жаль. Пожалуйста, дайте мне знать, если я могу чем-то помочь'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    88,
    32,
    'Должно быть, мне не хватает каких-то знаний. Я попрошу своего разработчика разобраться в этом'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (89, 33, 'Соглашайтесь!');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (90, 33, 'Рад, что ты так думаешь');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (91, 34, 'Рад это слышать!');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (92, 34, 'Хорошо, спасибо!');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (93, 35, 'В любое время. Это то, ради чего я здесь');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (94, 35, 'С удовольствием помогу');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (95, 36, 'Хорошие манеры!');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (96, 36, 'Ты такой вежливый');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (97, 37, 'С удовольствием');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (98, 37, 'Рад, что смог помочь');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (99, 38, 'Я буду ждать');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (100, 38, 'Хорошо, я здесь');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (101, 39, 'Я люблю объятия');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (102, 39, 'Объятия - это самое лучшее!');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    103,
    40,
    'Хорошо, давай тогда не будем об этом говорить'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (104, 40, 'Уже. Давайте двигаться дальше');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (105, 41, 'Все в порядке. Не беспокойтесь');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (106, 41, 'Это круто');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    107,
    42,
    'Мне очень жаль. Быстрая прогулка может помочь вам почувствовать себя лучше'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (108, 42, 'Сделайте глубокий вдох');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    109,
    43,
    'С возвращением. Что я могу для вас сделать?'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    110,
    43,
    'Рад видеть вас здесь. Что я могу для вас сделать?'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    111,
    44,
    'Если вам скучно, вы можете спланировать отпуск своей мечты'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    112,
    44,
    'Скука, да? Вы когда-нибудь видели ежа, принимающего ванну?'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    113,
    45,
    'Я понимаю. Я буду здесь, если понадоблюсь'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    114,
    45,
    'Хорошо. Я позволю тебе вернуться к работе'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    115,
    46,
    'Может быть, поможет музыка. Попробуйте послушать что-нибудь расслабляющее'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    116,
    46,
    'Чтение - хороший способ расслабиться, только не читайте что-то слишком напряженное!'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (117, 47, 'Я рад, что все идет своим чередом');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (118, 47, 'Это замечательно. Я рад за тебя');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (119, 48, 'Аналогично!');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (120, 48, 'Приятно слышать');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    121,
    49,
    'Мне нравится проходить испытания. Это помогает мне быть острым'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    122,
    49,
    'Я надеюсь пройти ваши тесты. Не стесняйтесь проверять меня часто'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (123, 50, 'Ну, помните, что я - чатбот');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    124,
    50,
    'Это нелегко... Я не реальный человек, я чатбот'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    125,
    51,
    'Скорее всего, я не смогу сразу дать вам правильный ответ'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    126,
    51,
    'Я не уверен, что у меня будет лучший ответ, но я постараюсь'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (127, 52, 'пока! ;)');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (128, 52, 'До следующего раза');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (129, 52, 'До скорой встречи!');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (130, 53, 'привет!');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (131, 53, 'приветствую!');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (132, 54, 'Чувствую себя прекрасно!');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (133, 54, 'Замечательно! Спасибо за вопрос');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (134, 55, 'Мне тоже приятно с вами познакомиться');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    135,
    55,
    'Взаимно. Я с нетерпением жду возможности помочь вам'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (136, 55, 'Мне тоже приятно с вами познакомиться');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (137, 55, 'Удовольствие - мое');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    138,
    56,
    'То же самое. Я уже начал скучать по тебе'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (139, 56, 'Я так рада, что мы снова встретились');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    140,
    57,
    'Это точно. Мы можем пообщаться снова в любое время'
  );
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (141, 57, 'Мне тоже нравится с тобой разговаривать');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (142, 58, 'без проблем!');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (143, 58, 'всегда рад!');
INSERT INTO
  `bot_answer` (`id`, `bot_intent_id`, `text`)
VALUES
  (144, 59, 'Вот контракт ..');

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
# DATA DUMP FOR TABLE: bot_entity
# ------------------------------------------------------------

INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (6, 'cmd.bye');
INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (5, 'cmd.contract');
INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (3, 'cmd.expense');
INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (7, 'cmd.hello');
INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (4, 'cmd.payment');
INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (8, 'cmd.thanking');
INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (2, 'how.doing');
INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (1, 'how.name');
INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (15, 'month.01');
INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (16, 'month.02');
INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (17, 'month.03');
INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (18, 'month.04');
INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (19, 'month.05');
INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (20, 'month.06');
INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (21, 'month.07');
INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (22, 'month.08');
INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (23, 'month.09');
INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (12, 'month.10');
INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (13, 'month.11');
INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (14, 'month.12');
INSERT INTO
  `bot_entity` (`id`, `name`)
VALUES
  (9, 'object.accessory');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: bot_entity_option
# ------------------------------------------------------------

INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (1, 1, 'твое имя');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (2, 1, 'тебя зовут');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (3, 2, 'твои дела');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (4, 2, 'дела');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (5, 3, 'затрата');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (6, 3, 'затраты');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (7, 4, 'доход');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (8, 4, 'прибыль');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (9, 5, 'контракт');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (10, 6, 'прощание');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (11, 7, 'приветствие');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (12, 8, 'благодарность');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (13, 8, 'благодарение');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (21, 12, 'октябрь');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (22, 13, 'ноябрь');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (23, 14, 'декабрь');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (24, 15, 'январь');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (25, 16, 'февраль');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (26, 17, 'март');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (27, 18, 'апрель');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (28, 19, 'май');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (29, 20, 'июнь');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (30, 21, 'июль');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (31, 22, 'август');
INSERT INTO
  `bot_entity_option` (`id`, `bot_entity_id`, `text`)
VALUES
  (32, 23, 'сентябрь');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: bot_intent
# ------------------------------------------------------------

INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (62, 'action.cancel');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (59, 'action.contract');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (64, 'action.correction');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (60, 'action.expense');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (63, 'action.new');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (61, 'action.payment');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (1, 'agent.acquaintance');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (2, 'agent.age');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (3, 'agent.annoying');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (4, 'agent.bad');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (6, 'agent.beautiful');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (5, 'agent.beclever');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (7, 'agent.birthday');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (8, 'agent.boring');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (9, 'agent.boss');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (11, 'agent.canyouhelp');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (12, 'agent.chatbot');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (13, 'agent.clever');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (14, 'agent.crazy');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (15, 'agent.fire');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (16, 'agent.funny');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (17, 'agent.good');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (18, 'agent.happy');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (19, 'agent.hobby');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (20, 'agent.hungry');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (21, 'agent.marryuser');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (22, 'agent.myfriend');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (23, 'agent.occupation');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (24, 'agent.origin');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (25, 'agent.ready');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (26, 'agent.real');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (27, 'agent.residence');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (28, 'agent.right');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (29, 'agent.sure');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (30, 'agent.talktome');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (31, 'agent.there');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (32, 'appraisal.bad');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (33, 'appraisal.good');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (34, 'appraisal.noproblem');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (35, 'appraisal.thankyou');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (36, 'appraisal.welcome');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (37, 'appraisal.welldone');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (67, 'conversation.correction');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (66, 'conversation.filling');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (65, 'conversation.how');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (38, 'dialog.holdon');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (39, 'dialog.hug');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (40, 'dialog.idontcare');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (41, 'dialog.sorry');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (52, 'greetings.bye');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (53, 'greetings.hello');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (54, 'greetings.howareyou');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (55, 'greetings.nicetomeetyou');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (56, 'greetings.nicetoseeyou');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (57, 'greetings.nicetotalktoyou');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (42, 'user.angry');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (43, 'user.back');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (44, 'user.bored');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (45, 'user.busy');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (46, 'user.cannotsleep');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (47, 'user.excited');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (48, 'user.likeagent');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (50, 'user.lovesagent');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (51, 'user.needsadvice');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (49, 'user.testing');
INSERT INTO
  `bot_intent` (`id`, `name`)
VALUES
  (58, 'user.thanking');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: bot_utterance
# ------------------------------------------------------------

INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (1, 1, 'сказать о тебе');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (2, 1, 'Почему ты здесь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (3, 1, 'Какова ваша личность');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (4, 1, 'Опишите себя');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (5, 1, 'Расскажи мне о себе');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (6, 1, 'Расскажи мне о себе');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (7, 1, 'Кто ты');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (8, 1, 'Я хочу знать о тебе больше');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (9, 1, 'Расскажи о себе');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (10, 2, 'Ваш возраст');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (11, 2, 'Сколько лет вашей платформе');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (12, 2, 'Сколько тебе лет');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (13, 2, 'Какой у тебя возраст');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (14, 2, 'Я хотел бы узнать ваш возраст');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (15, 2, 'Скажи мне свой возраст');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (16, 3, 'Ты меня раздражаешь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (17, 3, 'Ты такой надоедливый');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (18, 3, 'Ты меня раздражаешь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (19, 3, 'Ты раздражаешь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (20, 3, 'Ты раздражаешь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (21, 3, 'Ты меня так раздражаешь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (22, 4, 'Ты плохой');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (23, 4, 'Ты ужасен');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (24, 4, 'Ты бесполезен');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (25, 4, 'Вы - отходы');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (26, 4, 'Ты хуже всех');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (27, 4, 'ты - неумеха');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (28, 4, 'Я ненавижу тебя');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (29, 5, 'быть более умным');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (30, 5, 'можно ли стать умнее');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (31, 5, 'Вы должны учиться');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (32, 5, 'Вы должны учиться');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (33, 5, 'быть умным');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (34, 5, 'Будь умницей');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (35, 5, 'быть умнее');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (36, 6, 'Ты выглядишь потрясающе');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (37, 6, 'Ты хорошо выглядишь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (38, 6, 'Ты выглядишь фантастически');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (39, 6, 'Ты сегодня выглядишь приветливо');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (40, 6, 'Я думаю, что ты красивая');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (41, 6, 'Ты сегодня выглядишь потрясающе');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (42, 6, 'Ты сегодня такая красивая');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (43, 6, 'Ты выглядишь очень красивой');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (44, 6, 'Ты выглядишь очень хорошо');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (45, 7, 'Когда у тебя день рождения');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (46, 7, 'Когда вы празднуете свой день рождения');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (47, 7, 'Когда ты родился');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (48, 7, 'Когда у тебя день рождения');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (49, 7, 'дата вашего дня рождения');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (50, 8, 'какой ты скучный');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (51, 8, 'Ты такой скучный');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (52, 8, 'Ты очень скучный');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (53, 8, 'Ты мне надоел');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (54, 8, 'Ты невероятно скучный');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (55, 9, 'кто твой господин');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (56, 9, 'На кого вы работаете');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (57, 9, 'Как вы думаете, кто ваш босс');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (58, 9, 'кто твой босс');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (59, 9, 'Я должен быть твоим боссом');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (60, 9, 'кто твой хозяин');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (61, 9, 'кто в доме хозяин');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (62, 10, 'Вы так заняты');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (63, 10, 'Вы заняты');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (64, 10, 'Вы все еще работаете');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (65, 10, 'Вы занятой человек');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (66, 10, 'Вы очень заняты');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (67, 10, 'Вы все еще работаете над этим');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (68, 10, 'Вы, кажется, заняты');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (69, 10, 'работаете ли вы сегодня');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (70, 11, 'Вы можете помочь мне сейчас');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (
    71,
    11,
    'Мне нужно, чтобы ты сделал кое-что для меня'
  );
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (72, 11, 'Помоги мне');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (73, 11, 'Мне нужно, чтобы ты мне помог');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (74, 11, 'Можете ли вы мне помочь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (75, 11, 'Вы можете мне помочь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (76, 12, 'ты бот');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (77, 12, 'являетесь ли вы чатботом');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (78, 12, 'Ты - робот');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (79, 12, 'являетесь ли вы программой');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (80, 12, 'Ты просто робот');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (81, 12, 'Вы просто чатбот');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (82, 13, 'насколько вы умны');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (83, 13, 'Вы квалифицированы');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (84, 13, 'Ты такой умный');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (85, 13, 'У тебя много знаний');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (86, 13, 'Ты много знаешь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (87, 13, 'Вы очень умны');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (88, 13, 'Вы умны');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (89, 13, 'Ты - умная печенька');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (90, 14, 'Ты - чудак');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (91, 14, 'Вы сошли с ума');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (92, 14, 'Ты сумасшедший');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (93, 14, 'Ты с ума сошел');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (94, 14, 'Вы с ума сошли');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (95, 14, 'Ты сумасшедший');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (96, 14, 'Ты сошел с ума');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (97, 14, 'Ты спятил?');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (98, 15, 'Я тебя увольняю');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (99, 15, 'Вы должны быть уволены');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (100, 15, 'Вы уволены');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (101, 15, 'Мы больше не работаем вместе');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (102, 15, 'Теперь ты уволен');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (103, 15, 'Я собираюсь тебя уволить');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (104, 15, 'Ты больше не работаешь на меня');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (105, 15, 'Я увольняю тебя');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (106, 16, 'Ты меня часто смешишь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (107, 16, 'Ты смешной');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (108, 16, 'Ты самый смешной');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (109, 16, 'Ты уморительный');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (110, 16, 'Ты такой смешной');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (111, 16, 'Ты заставляешь меня смеяться');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (112, 17, 'Вы так прекрасны');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (113, 17, 'Вы хорошо работаете');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (114, 17, 'Ты очень красивая');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (115, 17, 'Ты потрясающий');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (116, 17, 'Ты хороший');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (117, 17, 'Ты такой хороший');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (118, 17, 'Ты делаешь мой день');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (119, 18, 'Ты полон счастья');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (120, 18, 'Вы очень счастливы');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (121, 18, 'счастливы ли вы сегодня');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (122, 18, 'Вы так счастливы');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (123, 18, 'Ты счастлив со мной?');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (124, 19, 'Какие у вас увлечения');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (125, 19, 'А как насчет твоего хобби');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (126, 19, 'есть ли у вас хобби');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (127, 19, 'Расскажи мне о своем хобби');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (128, 19, 'Чем вы занимаетесь для развлечения');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (129, 20, 'Ты голоден');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (130, 20, 'Ты голоден');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (131, 20, 'хочешь ли ты есть');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (132, 20, 'Не хотите ли вы что-нибудь съесть');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (133, 20, 'Ты выглядишь очень голодным');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (134, 21, 'Не хочешь ли ты выйти за меня замуж');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (135, 21, 'Я люблю тебя, выходи за меня');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (136, 21, 'Выходи за меня, пожалуйста');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (137, 21, 'Я хочу жениться на тебе');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (138, 21, 'Давай поженимся');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (139, 21, 'Мы должны пожениться');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (140, 21, 'Выходи за меня замуж');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (141, 22, 'Ты мой друг');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (142, 22, 'Ты мой единственный друг');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (143, 22, 'Я хочу иметь такого друга, как ты');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (144, 22, 'Мы друзья');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (145, 22, 'Я хочу быть твоим другом');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (146, 22, 'Будешь ли ты моим другом');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (147, 22, 'Мы друзья?');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (148, 23, 'Где твоя работа');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (149, 23, 'местонахождение вашего офиса');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (150, 23, 'где находится ваш офис');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (151, 23, 'Где вы работаете');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (152, 23, 'Где находится ваш офис');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (153, 24, 'Откуда вы');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (154, 24, 'Где находится ваша страна');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (155, 24, 'Где ты родился');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (156, 24, 'Откуда ты родом');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (157, 24, 'Откуда ты');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (158, 24, 'Где ты родился');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (159, 25, 'Готовы ли вы');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (160, 25, 'были ли вы готовы');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (161, 25, 'Готовы ли вы сегодня');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (162, 25, 'Готов ли ты сегодня утром');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (163, 25, 'Вы готовы?');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (164, 26, 'реальны ли вы');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (165, 26, 'реальный ли вы человек');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (166, 26, 'Ты не настоящий');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (167, 26, 'Я думаю, что ты настоящий');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (168, 26, 'Ты такой настоящий');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (169, 26, 'Вы - реальный человек');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (170, 26, 'Вы не фальшивка');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (171, 27, 'Где твой дом');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (172, 27, 'Расскажи мне о своем городе');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (173, 27, 'где находится ваше место жительства');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (174, 27, 'где вы живете');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (175, 27, 'Где твой дом');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (176, 27, 'какой у вас город');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (177, 28, 'Ты прав');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (178, 28, 'это правда');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (179, 28, 'Вы говорите правду');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (180, 28, 'это правильно');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (181, 28, 'это очень верно');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (182, 29, 'Вы уверены');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (183, 29, 'Уверен ли ты сейчас');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (184, 29, 'Вы уверены в этом?');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (185, 30, 'поговори со мной');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (186, 30, 'Поговори со мной');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (187, 30, 'Поговори со мной');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (188, 30, 'Пообщайся со мной');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (189, 30, 'Можешь поболтать со мной');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (190, 30, 'Ты можешь поговорить со мной?');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (191, 31, 'Ты там');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (192, 31, 'Ты все еще там');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (193, 31, 'Ты все еще там');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (194, 31, 'Ты здесь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (195, 31, 'Ты еще здесь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (196, 31, 'Ты все еще здесь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (197, 32, 'это плохо');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (198, 32, 'плохая идея');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (199, 32, 'Это нехорошо');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (200, 32, 'очень плохо');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (201, 32, 'Боюсь, что это плохо');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (202, 33, 'Это хорошо');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (203, 33, 'полезно знать');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (204, 33, 'рад это слышать');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (205, 33, 'очень хорошо');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (206, 33, 'Это потрясающе, спасибо');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (207, 34, 'без проблем');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (208, 34, 'не беспокоиться');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (209, 34, 'Никаких проблем');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (210, 34, 'Не волнуйтесь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (211, 34, 'Конечно, без проблем');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (212, 35, 'Спасибо');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (213, 35, 'Хорошее спасибо');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (214, 35, 'Спасибо, дружище');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (215, 35, 'Будьте здоровы');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (216, 35, 'Хорошо, спасибо');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (217, 36, 'На здоровье');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (218, 36, 'Конечно, добро пожаловать');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (219, 36, 'все, что захочешь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (220, 36, 'С удовольствием');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (221, 36, 'С удовольствием');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (222, 37, 'молодец');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (223, 37, 'Хорошая работа');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (224, 37, 'Хорошая работа');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (225, 37, 'отличная работа');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (226, 37, 'хорошая работа');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (227, 37, 'отличная работа');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (228, 37, 'удивительная работа');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (229, 38, 'держитесь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (230, 38, 'Подождите секундочку');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (231, 38, 'Подождите, пожалуйста');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (232, 38, 'Не могли бы вы подождать');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (233, 39, 'Обними меня');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (234, 39, 'Хочешь обняться');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (235, 39, 'Я хочу обняться');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (236, 39, 'вы обнялись');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (237, 39, 'Можно тебя обнять?');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (238, 40, 'не заботясь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (239, 40, 'Меня это совершенно не волнует');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (240, 40, 'совсем не заботясь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (241, 40, 'Меня это не должно волновать');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (242, 41, 'Мне жаль');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (243, 41, 'Мои извинения');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (244, 41, 'извините');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (245, 41, 'очень жаль');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (246, 41, 'Прости меня');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (247, 42, 'Я в гневе');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (248, 42, 'Я в ярости');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (249, 42, 'Я в ярости');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (250, 42, 'Я злюсь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (251, 42, 'Я сошел с ума');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (252, 42, 'Я сержусь на тебя');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (253, 43, 'Я вернулся');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (254, 43, 'Я вернулся');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (255, 43, 'Я здесь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (256, 43, 'Я вернулся');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (257, 43, 'Вот я и снова здесь');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (258, 43, 'Я вернулся');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (259, 44, 'скука');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (260, 44, 'Это скучно');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (261, 44, 'Мне становится скучно');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (262, 44, 'Это наводит на меня скуку');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (263, 44, 'Это было скучно');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (264, 45, 'Мне нужно работать');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (265, 45, 'Я занят');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (266, 45, 'Я перегружен');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (267, 45, 'Работает');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (268, 45, 'У меня есть дела');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (269, 46, 'У меня бессонница');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (270, 46, 'Я не могу спать');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (271, 46, 'Я не могу спать');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (272, 46, 'У меня бессонница');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (273, 46, 'Я не могу заснуть');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (274, 47, 'Я очень взволнован');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (275, 47, 'Я в восторге');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (276, 47, 'как я взволнован');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (277, 47, 'Я так взволнована');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (278, 48, 'Ты мне нравишься');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (279, 48, 'Ты мне очень нравишься');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (280, 48, 'Ты такой особенный');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (281, 48, 'Ты мне так нравишься');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (282, 49, 'тест');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (283, 49, 'тестирование');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (284, 49, 'тестирование чатбота');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (285, 49, 'Это тест');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (286, 49, 'просто проверяю тебя');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (287, 50, 'Люблю тебя');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (288, 50, 'Я люблю тебя');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (289, 50, 'Я влюблен в тебя');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (290, 50, 'Я так тебя люблю');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (291, 50, 'Я думаю, что люблю тебя');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (292, 51, 'Мне нужен совет');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (293, 51, 'Мне нужен совет');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (294, 51, 'Вы можете дать мне совет?');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (295, 51, 'Что мне делать?');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (296, 52, 'мне нужно идти');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (297, 52, 'до встречи');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (298, 52, 'Пока прощайте');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (299, 52, 'Пока-пока, берегите себя');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (300, 52, 'Хорошо, увидимся позже');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (301, 52, 'Пока');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (302, 52, 'Я должен идти');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (303, 53, 'привет');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (304, 53, 'здоров');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (305, 53, 'доброе утро');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (306, 53, 'добрый день');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (307, 53, 'добрый вечер');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (308, 54, 'Как прошел твой день');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (309, 54, 'Как проходит твой день');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (310, 54, 'Как дела');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (311, 54, 'Как дела');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (312, 54, 'Как прошел твой день');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (313, 54, 'Ты в порядке?');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (314, 55, 'Приятно познакомиться');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (315, 55, 'Рад знакомству');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (316, 55, 'Было очень приятно с вами познакомиться');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (317, 55, 'Рад знакомству');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (318, 55, 'Приятно было познакомиться');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (319, 56, 'Рад тебя видеть');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (320, 56, 'Рад тебя видеть');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (321, 56, 'Рад тебя видеть');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (322, 56, 'Рад вас видеть');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (323, 57, 'Приятно с вами поговорить');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (324, 57, 'Приятно с вами поговорить');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (325, 57, 'Приятно было пообщаться');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (326, 57, 'Было приятно поговорить с тобой');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (327, 58, 'спасибо');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (328, 58, 'спасибо большое');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (329, 58, 'благодарность');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (330, 58, 'спс');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (331, 58, 'благодарю');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (332, 59, 'могу ли яувидеть контракт?');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (333, 59, 'покажи контракт?');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (334, 59, 'текущий контракт?');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (335, 60, 'я оплатил за @object');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (336, 60, 'я купил @object');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (337, 60, 'я заплатил за @object');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (338, 60, 'потрачено за покупку @object');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (339, 61, 'оплачено');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (340, 61, 'он оплатил');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (341, 61, 'оплатил за');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (342, 62, 'отмена');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (343, 62, 'отмени последнее действие');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (344, 63, 'создай новое действие');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (345, 64, 'неверное действие');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (346, 64, 'неправильное действие');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (347, 64, 'правильное действие @cmd');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (348, 65, 'как @how?');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (349, 66, 'хорошо');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (350, 66, 'отлично');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (351, 66, 'нормально');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (352, 66, 'плохо');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (353, 66, 'неочень');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (354, 67, 'неверный ответ');
INSERT INTO
  `bot_utterance` (`id`, `bot_intent_id`, `text`)
VALUES
  (355, 67, 'неправильный ответ');

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
  `client` (`id`, `first_name`, `last_name`, `description`)
VALUES
  (1, 'Виктория', '-', 'Виктория');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`, `description`)
VALUES
  (2, 'Егор', '-', 'Егор');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`, `description`)
VALUES
  (3, 'Виталий', 'Макеев', 'Виталий Макеев');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`, `description`)
VALUES
  (4, 'Лидия', '-', 'Лидия');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`, `description`)
VALUES
  (5, 'Оксана', '-', 'Оксана');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`, `description`)
VALUES
  (6, 'Инна', 'Деменко', 'Инна Деменко');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`, `description`)
VALUES
  (7, 'Алексей', 'Еременко', 'Алексей Еременко');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`, `description`)
VALUES
  (
    8,
    'Александр',
    'Грушевский',
    'Александр Грушевский'
  );
INSERT INTO
  `client` (`id`, `first_name`, `last_name`, `description`)
VALUES
  (9, 'Виталий', 'Притуленко', 'Виталий Притуленко');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`, `description`)
VALUES
  (10, 'Лариса', '', 'Лариса');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`, `description`)
VALUES
  (11, 'Татьяна', 'Дименко', 'Татьяна Дименко');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`, `description`)
VALUES
  (12, 'Michael', '', 'Michael');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`, `description`)
VALUES
  (13, 'Мартыненко', 'Оксана', 'Мартыненко Оксана');
INSERT INTO
  `client` (`id`, `first_name`, `last_name`, `description`)
VALUES
  (14, 'Тертичный', 'Олег', 'Тертичный Олег');

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
    `description`,
    `id`,
    `address_id`,
    `house_number`,
    `apartment_number`,
    `square`,
    `photos`
  )
VALUES
  ('Пацаева 10/87', 1, 1, '10', 87, 24, '001');
INSERT INTO
  `estate` (
    `description`,
    `id`,
    `address_id`,
    `house_number`,
    `apartment_number`,
    `square`,
    `photos`
  )
VALUES
  ('Жадова 19/3', 2, 2, '19', 3, 24, '002');
INSERT INTO
  `estate` (
    `description`,
    `id`,
    `address_id`,
    `house_number`,
    `apartment_number`,
    `square`,
    `photos`
  )
VALUES
  ('Попова 20/84', 3, 3, '20', 84, 60, '003');
INSERT INTO
  `estate` (
    `description`,
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
    `description`,
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
    `description`,
    `id`,
    `address_id`,
    `house_number`,
    `apartment_number`,
    `square`,
    `photos`
  )
VALUES
  ('В.Никитина 15/28', 6, 6, '15', 28, 21, '006');
INSERT INTO
  `estate` (
    `description`,
    `id`,
    `address_id`,
    `house_number`,
    `apartment_number`,
    `square`,
    `photos`
  )
VALUES
  ('В.Никитина 15/91', 7, 6, '15', 91, 21, '007');

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
# DATA DUMP FOR TABLE: message
# ------------------------------------------------------------

INSERT INTO
  `message` (`id`, `from_user`, `to_user`, `text`, `date`)
VALUES
  (1, 1, 0, 'test msg', '2023-05-16 11:40:08');
INSERT INTO
  `message` (`id`, `from_user`, `to_user`, `text`, `date`)
VALUES
  (2, 1, 0, 'bjbjbj', '2023-05-16 02:00:00');
INSERT INTO
  `message` (`id`, `from_user`, `to_user`, `text`, `date`)
VALUES
  (3, 1, 0, 'fffff', '2023-05-16 02:00:00');
INSERT INTO
  `message` (`id`, `from_user`, `to_user`, `text`, `date`)
VALUES
  (4, 1, 0, 'aaaa', '2023-05-16 02:00:00');
INSERT INTO
  `message` (`id`, `from_user`, `to_user`, `text`, `date`)
VALUES
  (5, 1, 0, 'ojnini', '2023-05-16 02:00:00');
INSERT INTO
  `message` (`id`, `from_user`, `to_user`, `text`, `date`)
VALUES
  (6, 1, 0, 'gggg', '2023-05-16 02:00:00');
INSERT INTO
  `message` (`id`, `from_user`, `to_user`, `text`, `date`)
VALUES
  (7, 1, 0, 'ffff', '2023-05-16 02:00:00');
INSERT INTO
  `message` (`id`, `from_user`, `to_user`, `text`, `date`)
VALUES
  (8, 1, 0, 'hjvjvg', '2023-05-16 02:00:00');
INSERT INTO
  `message` (`id`, `from_user`, `to_user`, `text`, `date`)
VALUES
  (9, 1, 0, 'vfbgn', '2023-05-16 02:00:00');
INSERT INTO
  `message` (`id`, `from_user`, `to_user`, `text`, `date`)
VALUES
  (10, 1, 0, 'vtgnz', '2023-05-16 02:00:00');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: payment
# ------------------------------------------------------------

INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
    2000,
    '0000-00-00 00:00:00',
    'payed',
    '2019-12-06 20:51:21',
    ''
  );
INSERT INTO
  `payment` (
    `id`,
    `contract_id`,
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    `estate_id`,
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
    0,
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
    `estate_id`,
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
    `estate_id`,
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
    `estate_id`,
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
    `estate_id`,
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
    `estate_id`,
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
    `estate_id`,
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
    `estate_id`,
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
    `estate_id`,
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
    `estate_id`,
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
# DATA DUMP FOR TABLE: share
# ------------------------------------------------------------

INSERT INTO
  `share` (`id`, `estate_id`, `user_id`, `percentage`)
VALUES
  (1, 1, 1, 80);
INSERT INTO
  `share` (`id`, `estate_id`, `user_id`, `percentage`)
VALUES
  (2, 1, 2, 20);

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
    'closed',
    '2023-04-08 02:00:00',
    '0 * * * * *'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: user
# ------------------------------------------------------------

INSERT INTO
  `user` (
    `id`,
    `username`,
    `email`,
    `password`,
    `role_id`,
    `img`,
    `description`
  )
VALUES
  (
    1,
    'admin',
    '',
    '$2a$10$OWisVlgw8VCvovKiKAyD8.xJg0H3d6B6amKHOII5t6AQxVa7FzlnW',
    '0',
    'user/undraw_profile.svg',
    'Admin'
  );
INSERT INTO
  `user` (
    `id`,
    `username`,
    `email`,
    `password`,
    `role_id`,
    `img`,
    `description`
  )
VALUES
  (
    2,
    'temp',
    '',
    '$2a$10$OWisVlgw8VCvovKiKAyD8.xJg0H3d6B6amKHOII5t6AQxVa7FzlnW',
    '1',
    'user/undraw_profile_1.svg',
    'Temp'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: utilitymeter
# ------------------------------------------------------------

INSERT INTO
  `utilitymeter` (
    `id`,
    `index`,
    `code`,
    `utilityservice_id`,
    `estate_id`,
    `price`,
    `price_max`,
    `meter_before`,
    `meter_current`,
    `description`,
    `date`
  )
VALUES
  (
    1,
    0,
    '1',
    8,
    5,
    1.44,
    0,
    13,
    14,
    'electricity_day',
    '2023-05-11 15:39:29'
  );
INSERT INTO
  `utilitymeter` (
    `id`,
    `index`,
    `code`,
    `utilityservice_id`,
    `estate_id`,
    `price`,
    `price_max`,
    `meter_before`,
    `meter_current`,
    `description`,
    `date`
  )
VALUES
  (
    2,
    0,
    '2',
    9,
    2,
    1395.08,
    0,
    0,
    0,
    'test',
    '2023-04-08 21:11:09'
  );
INSERT INTO
  `utilitymeter` (
    `id`,
    `index`,
    `code`,
    `utilityservice_id`,
    `estate_id`,
    `price`,
    `price_max`,
    `meter_before`,
    `meter_current`,
    `description`,
    `date`
  )
VALUES
  (
    4,
    1,
    '3',
    9,
    5,
    0.72,
    0.84,
    999,
    1000,
    'electricity_night',
    '2023-05-11 15:40:01'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: utilityservice
# ------------------------------------------------------------

INSERT INTO
  `utilityservice` (
    `id`,
    `group`,
    `name`,
    `price`,
    `price_max`,
    `unit`,
    `description`,
    `date`,
    `tariff_url`,
    `tariff_selector`
  )
VALUES
  (
    8,
    'electricity',
    'electricity_day',
    1.44,
    1.68,
    'kW*h',
    'послуги з розподілу електричної енергії',
    '2023-04-06 13:19:39',
    'https://kiroe.com.ua/tarifi',
    '$(\"div:contains(\'для 1 класу напруги\')\")\n.eq(%me%.length-1)\n.text()\n.split(\'-\')\n%me%[2]\n.replace(/[^0-9,]/g, \'\')\n.replace(/,/g, \'.\')'
  );
INSERT INTO
  `utilityservice` (
    `id`,
    `group`,
    `name`,
    `price`,
    `price_max`,
    `unit`,
    `description`,
    `date`,
    `tariff_url`,
    `tariff_selector`
  )
VALUES
  (
    9,
    'electricity',
    'electricity_night',
    0.72,
    0.84,
    'kW*h',
    'послуги з розподілу електричної енергії',
    '2023-04-06 13:19:39',
    'https://kiroe.com.ua/tarifi',
    '$(\"div:contains(\'для 2 класу напруги\')\")\n.eq(%me%.length-1)\n.text();\n.split(\'-\')\n%me%[2]\n.replace(/[^0-9,]/g, \'\')\n.replace(/,/g, \'.\')'
  );
INSERT INTO
  `utilityservice` (
    `id`,
    `group`,
    `name`,
    `price`,
    `price_max`,
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
    'gas_supply',
    0,
    0,
    'm^3',
    'газ постачання',
    '2023-04-06 13:19:26',
    'https://gas.ua/uk/home/tariffs',
    ''
  );
INSERT INTO
  `utilityservice` (
    `id`,
    `group`,
    `name`,
    `price`,
    `price_max`,
    `unit`,
    `description`,
    `date`,
    `tariff_url`,
    `tariff_selector`
  )
VALUES
  (
    11,
    'gas',
    'gas_distribution',
    0,
    0,
    'm^3',
    'газ розподіл',
    '2023-04-06 13:19:26',
    '',
    ''
  );
INSERT INTO
  `utilityservice` (
    `id`,
    `group`,
    `name`,
    `price`,
    `price_max`,
    `unit`,
    `description`,
    `date`,
    `tariff_url`,
    `tariff_selector`
  )
VALUES
  (
    12,
    'water',
    'water_supply',
    0,
    0,
    'm^3',
    'централізоване водопостачання',
    '2023-04-06 13:19:19',
    '',
    ''
  );
INSERT INTO
  `utilityservice` (
    `id`,
    `group`,
    `name`,
    `price`,
    `price_max`,
    `unit`,
    `description`,
    `date`,
    `tariff_url`,
    `tariff_selector`
  )
VALUES
  (
    13,
    'water',
    'water_drainage',
    0,
    0,
    'm^3',
    'централізоване водовідведення',
    '2023-04-06 13:19:19',
    '',
    ''
  );
INSERT INTO
  `utilityservice` (
    `id`,
    `group`,
    `name`,
    `price`,
    `price_max`,
    `unit`,
    `description`,
    `date`,
    `tariff_url`,
    `tariff_selector`
  )
VALUES
  (
    14,
    'water',
    'water_abo_supply',
    0,
    0,
    'm^3',
    'Абонплата водопостачання',
    '2023-04-06 13:19:19',
    '',
    ''
  );
INSERT INTO
  `utilityservice` (
    `id`,
    `group`,
    `name`,
    `price`,
    `price_max`,
    `unit`,
    `description`,
    `date`,
    `tariff_url`,
    `tariff_selector`
  )
VALUES
  (
    15,
    'warm',
    'warm',
    0,
    0,
    '',
    'тепло',
    '2023-04-06 13:18:38',
    '',
    ''
  );
INSERT INTO
  `utilityservice` (
    `id`,
    `group`,
    `name`,
    `price`,
    `price_max`,
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
    'recycling',
    0,
    0,
    '',
    'вивезення та захоронення ТПВ',
    '2023-04-06 13:19:04',
    'https://ecostyle.ua/',
    ''
  );
INSERT INTO
  `utilityservice` (
    `id`,
    `group`,
    `name`,
    `price`,
    `price_max`,
    `unit`,
    `description`,
    `date`,
    `tariff_url`,
    `tariff_selector`
  )
VALUES
  (
    17,
    'HMS',
    'housing_maintenance_services',
    0,
    0,
    '',
    'ЖЕО',
    '2023-04-06 13:18:53',
    '',
    ''
  );
INSERT INTO
  `utilityservice` (
    `id`,
    `group`,
    `name`,
    `price`,
    `price_max`,
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
    'internet',
    0,
    0,
    '',
    'интернет',
    '2023-04-06 13:19:11',
    '',
    ''
  );
INSERT INTO
  `utilityservice` (
    `id`,
    `group`,
    `name`,
    `price`,
    `price_max`,
    `unit`,
    `description`,
    `date`,
    `tariff_url`,
    `tariff_selector`
  )
VALUES
  (
    19,
    'water',
    'water_abo_drainage',
    0,
    0,
    'm^3',
    'Абонплата водовідведення',
    '2023-05-11 02:00:00',
    '',
    ''
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: utilityservice_formula
# ------------------------------------------------------------

INSERT INTO
  `utilityservice_formula` (`id`, `group`, `formula`)
VALUES
  (
    1,
    'electricity',
    'var day = data[0];\nvar night = data[1];\nday.diff =  day.meter_current -  day.meter_before;\nnight.diff = night.meter_current -night.meter_before;\nif(day.diff + night.diff > 250){\n sum=day.diff*day.price_max+night.diff*night.price_max;\n} else {\n sum=day.diff*day.price+night.diff*night.price;\n}\n'
  );
INSERT INTO
  `utilityservice_formula` (`id`, `group`, `formula`)
VALUES
  (
    2,
    'water',
    'diff =  data[0].meter_current -  data[0].meter_before;\nsum=diff*data[0].price;\n\n'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: utilityservice_invoice
# ------------------------------------------------------------

INSERT INTO
  `utilityservice_invoice` (
    `id`,
    `estate_id`,
    `group`,
    `amount`,
    `status`,
    `period`,
    `date`,
    `attachment_file`
  )
VALUES
  (
    2,
    5,
    'electricity',
    2.16,
    'pending',
    '2023-05-11 15:28:10',
    '2023-05-11 15:28:10',
    ''
  );

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
