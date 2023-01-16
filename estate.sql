-- phpMyAdmin SQL Dump
-- version 4.0.4.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Erstellungszeit: 16. Jan 2023 um 13:44
-- Server Version: 5.6.13
-- PHP-Version: 5.4.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Datenbank: `estate`
--
CREATE DATABASE IF NOT EXISTS `estate` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `estate`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `accessory`
--

CREATE TABLE IF NOT EXISTS `accessory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Daten für Tabelle `accessory`
--

INSERT INTO `accessory` (`id`, `name`) VALUES
(1, 'Унитаз'),
(2, 'Бойлер'),
(3, 'Балконный блок'),
(4, 'Диван'),
(5, 'Смеситель (сантехника)'),
(6, 'Счетчик электроэнергии');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `address`
--

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Daten für Tabelle `address`
--

INSERT INTO `address` (`id`, `street`, `city_id`, `state_id`, `country_id`, `zip_code`, `longitude`, `latitude`) VALUES
(1, 'Пацаева', 1, 1, 1, '', '0', '0'),
(2, 'Жадова', 1, 1, 1, '', '0', '0'),
(3, 'Попова', 1, 1, 1, '', '0', '0'),
(4, 'Сугоклеевская', 2, 1, 1, '', '48.464936', '32.203764'),
(5, 'Дачная', 1, 1, 1, '', '48.454410', '32.203997'),
(6, 'В.Никитина', 1, 0, 1, '25000', '48.530489', '32.274170');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bot`
--

CREATE TABLE IF NOT EXISTS `bot` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `token` varchar(200) NOT NULL,
  `pattern` varchar(50) NOT NULL,
  `options` text NOT NULL,
  `useraccess` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Daten für Tabelle `bot`
--

INSERT INTO `bot` (`id`, `name`, `token`, `pattern`, `options`, `useraccess`) VALUES
(1, 'KrHome', '1511669163:AAEP_FZQHSc2VFNsOBzNrnGhByBTFwrmV_A', '(.+)', '{"polling":true}', 'klamenzui');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bot_chat`
--

CREATE TABLE IF NOT EXISTS `bot_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `title` varchar(100) NOT NULL,
  `type` varchar(50) NOT NULL,
  `all_members_are_administrators` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT 'on/off',
  PRIMARY KEY (`id`),
  UNIQUE KEY `chat_id` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Daten für Tabelle `bot_chat`
--

INSERT INTO `bot_chat` (`id`, `code`, `title`, `type`, `all_members_are_administrators`, `status`) VALUES
(4, '-818696924', '#5: Дача', 'group', 1, 1),
(5, '-549807249', '#6: Никитина 15-28', 'group', 1, 0),
(6, '-516388453', '#1: Пацаева 10-87', 'group', 1, 0),
(7, '-274988667', '#2: Жадова 19-3', 'group', 1, 0),
(8, '-586687556', '#7: Никитина 15-91', 'group', 1, 0),
(9, '-483285968', '#3: Попова 20-84', 'group', 1, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bot_commands`
--

CREATE TABLE IF NOT EXISTS `bot_commands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `command` text COLLATE utf8_unicode_ci NOT NULL,
  `action_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Daten für Tabelle `bot_commands`
--

INSERT INTO `bot_commands` (`id`, `command`, `action_id`) VALUES
(1, 'оплата % %', 0),
(2, 'покупка % %', 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `capital`
--

CREATE TABLE IF NOT EXISTS `capital` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sum` float NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `currency` enum('EUR','HRN','USD') CHARACTER SET latin1 NOT NULL DEFAULT 'EUR',
  `exchange_rate` float NOT NULL COMMENT '(EUR equivalent)',
  `comment` varchar(255) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Daten für Tabelle `capital`
--

INSERT INTO `capital` (`id`, `sum`, `date`, `currency`, `exchange_rate`, `comment`) VALUES
(1, 5000, '2019-09-22 18:17:55', 'EUR', 0, 'in ua'),
(2, 100, '2019-09-22 18:25:11', 'EUR', 0, 'in de'),
(3, 5000, '2019-09-22 18:25:11', 'EUR', 0, 'in de');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `city`
--

CREATE TABLE IF NOT EXISTS `city` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Daten für Tabelle `city`
--

INSERT INTO `city` (`id`, `name`) VALUES
(1, 'Кропивницкий'),
(2, 'Черняховка');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `client`
--

CREATE TABLE IF NOT EXISTS `client` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(15) NOT NULL,
  `last_name` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=18 ;

--
-- Daten für Tabelle `client`
--

INSERT INTO `client` (`id`, `first_name`, `last_name`) VALUES
(1, 'Виктория', '-'),
(2, 'Егор', '-'),
(3, 'Виталий', 'Макеев'),
(4, 'Лидия', '-'),
(5, 'Оксана', '-'),
(6, 'Инна', 'Деменко'),
(7, 'Алексей', 'Еременко'),
(8, 'Александр', 'Грушевский'),
(9, 'Виталий', 'Притуленко'),
(10, 'Лариса', ''),
(11, 'Татьяна', 'Дименко'),
(12, 'Michael', ''),
(13, 'Мартыненко', 'Оксана'),
(14, 'Тертичный', 'Олег');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `contract`
--

CREATE TABLE IF NOT EXISTS `contract` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `estate_id` int(11) NOT NULL,
  `status` enum('active','closed','freezed') NOT NULL,
  `period_type` enum('daily','weekly','monthly') NOT NULL DEFAULT 'monthly',
  `price` float NOT NULL,
  `date_start` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_end` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Daten für Tabelle `contract`
--

INSERT INTO `contract` (`id`, `client_id`, `estate_id`, `status`, `period_type`, `price`, `date_start`, `date_end`) VALUES
(1, 1, 1, 'closed', 'monthly', 1800, '2018-06-01 00:00:00', '0000-00-00 00:00:00'),
(2, 2, 2, 'closed', 'monthly', 2200, '2018-09-01 00:00:00', '2019-01-31 00:00:00'),
(3, 3, 2, 'closed', 'monthly', 2500, '2019-02-11 19:20:40', '0000-00-00 00:00:00'),
(4, 4, 1, 'closed', 'monthly', 2000, '2018-12-15 05:00:00', '0000-00-00 00:00:00'),
(5, 6, 2, 'closed', 'monthly', 3000, '2019-04-13 04:00:00', '2019-07-11 00:00:00'),
(6, 7, 2, 'active', 'monthly', 3000, '2019-07-15 19:48:44', '0000-00-00 00:00:00'),
(7, 8, 1, 'active', 'monthly', 2000, '2019-10-31 04:00:00', '0000-00-00 00:00:00'),
(8, 9, 6, 'closed', 'monthly', 3000, '2019-11-25 05:00:00', '0000-00-00 00:00:00'),
(9, 10, 6, 'closed', 'monthly', 3000, '2020-04-01 15:58:45', '2020-09-30 00:00:00'),
(10, 11, 6, 'closed', 'monthly', 2900, '2020-10-01 15:58:45', '0000-00-00 00:00:00'),
(11, 12, 3, 'active', 'monthly', 2000, '2020-09-15 04:00:00', '0000-00-00 00:00:00'),
(12, 13, 6, 'active', 'monthly', 3000, '2021-04-12 04:00:00', '0000-00-00 00:00:00'),
(13, 13, 7, 'closed', 'monthly', 3000, '2021-03-25 04:00:00', '2021-04-12 00:00:00'),
(14, 14, 7, 'active', 'monthly', 3000, '2021-04-19 04:00:00', '0000-00-00 00:00:00'),
(15, 1, 5, 'active', 'monthly', 11111, '2022-11-30 23:00:00', '2023-03-01 00:00:00');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `country`
--

CREATE TABLE IF NOT EXISTS `country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Daten für Tabelle `country`
--

INSERT INTO `country` (`id`, `name`) VALUES
(1, 'Украина');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `estate`
--

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Daten für Tabelle `estate`
--

INSERT INTO `estate` (`comment`, `id`, `address_id`, `house_number`, `apartment_number`, `square`, `photos`) VALUES
('Пацаева', 1, 1, '10', 87, 24, '001'),
('Жадова', 2, 2, '19', 3, 24, '002'),
('Попова', 3, 3, '20', 84, 60, '003'),
('Земля', 4, 4, '67', 0, 1200, '004'),
('Дача', 5, 5, '', 0, 600, '005'),
('Vasylia Nikitina', 6, 6, '15', 28, 21, '006'),
('', 7, 6, '15', 91, 21, '007');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `expense`
--

CREATE TABLE IF NOT EXISTS `expense` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estate_id` int(11) NOT NULL,
  `ref_estate_accessory_id` int(11) NOT NULL,
  `type` enum('accessory','accommodation','service') NOT NULL,
  `summe` double NOT NULL,
  `description` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `estate_id` (`estate_id`),
  KEY `ref_est_acc` (`ref_estate_accessory_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=38 ;

--
-- Daten für Tabelle `expense`
--

INSERT INTO `expense` (`id`, `estate_id`, `ref_estate_accessory_id`, `type`, `summe`, `description`, `date`) VALUES
(1, 1, 0, '', 245372.5, 'Покупка квартиры ( 8045 eur )', '2018-05-22 22:00:00'),
(2, 2, 0, '', 290875, 'Покупка квартиры ( 8950 eur )', '2018-09-03 22:00:00'),
(3, 1, 0, '', 2900, 'Нотариус', '2019-02-11 20:41:16'),
(4, 1, 0, '', 877, 'Переоформление', '2019-02-11 20:41:16'),
(5, 1, 0, '', 12925, 'Риелтор ( 500 $ )', '2019-02-11 20:59:48'),
(6, 1, 2, 'accessory', 2500, 'Бойлер', '2019-02-11 21:04:12'),
(7, 1, 0, 'service', 500, 'Установка бойлера', '2019-02-11 21:07:10'),
(8, 1, 3, 'accessory', 5000, 'Балконный блок', '2019-02-11 21:09:27'),
(9, 2, 6, 'accessory', 1350, 'Покупка унитаза', '2018-09-12 02:00:00'),
(10, 2, 0, 'service', 450, 'Установка унитаза', '2018-09-14 15:00:00'),
(11, 2, 0, 'service', 400, 'Покупка труб к унитазу', '2018-09-14 15:37:02'),
(12, 2, 0, 'service', 300, 'Кран, Свет', '2019-10-26 18:45:48'),
(13, 1, 0, 'service', 2000, 'Диван', '2019-10-26 19:06:19'),
(14, 2, 0, 'accessory', 6000, 'Диван, Стенка', '2019-10-26 19:16:29'),
(15, 6, 0, '', 281742.6, 'Покупка квартиры ( 10436.57 eur )', '2019-11-13 17:09:15'),
(16, 6, 0, 'accessory', 2500, 'Шкаф', '2019-11-13 17:28:39'),
(17, 6, 0, 'accessory', 3500, 'Холодильник', '2019-11-13 17:28:39'),
(18, 6, 0, 'accessory', 3000, 'Стиральная машина', '2019-11-13 17:28:39'),
(19, 6, 0, '', 12502, 'Риелтор ( 470 € ) курс 26.6', '2019-11-13 17:32:55'),
(20, 6, 0, '', 1364, 'Касса', '2019-11-14 19:52:38'),
(21, 6, 0, '', 4000, 'Иннеса за документы', '2019-11-14 19:52:38'),
(22, 6, 0, '', 470, 'Касса', '2019-11-14 19:52:38'),
(23, 1, 0, 'accessory', 350, 'Электрика, счетчик', '2019-11-19 19:35:50'),
(24, 1, 0, 'accessory', 200, 'Замок на дверях', '2019-11-19 19:39:45'),
(25, 1, 0, 'accessory', 250, 'Замена стекла дверей', '2019-11-19 19:39:45'),
(26, 1, 0, 'accessory', 40, 'Подставка для шампуней', '2019-11-19 19:39:45'),
(27, 1, 0, 'service', 100, 'Бензин и прочее', '2019-11-19 19:39:45'),
(28, 2, 0, 'service', 50, 'Электричество', '2019-11-19 20:01:54'),
(29, 6, 0, 'accessory', 400, 'Кран', '2019-12-06 20:11:58'),
(30, 6, 0, 'service', 500, 'Бензин', '2019-12-06 20:11:58'),
(31, 2, 0, 'service', 700, 'Покупка Кран', '2020-01-25 04:00:00'),
(32, 5, 0, 'service', 2000, 'оплата дачи за 2020 год', '2020-12-19 18:17:11'),
(33, 7, 0, 'service', 1096, 'коммунальные', '2021-04-26 14:25:51'),
(34, 7, 0, 'service', 300, 'Бензин', '2021-04-26 14:25:51'),
(35, 6, 4, 'accessory', 1900, '1500+200+200 бензин мы старую машинку забирали и два раза туда обратно а это далеко', '2021-09-05 02:00:00'),
(36, 2, 0, 'accessory', 2700, 'на двухтарифный счетчик', '2021-10-10 15:40:06'),
(37, 6, 0, 'accessory', 600, 'Кран и трубки', '2021-08-06 02:00:00');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `payment`
--

CREATE TABLE IF NOT EXISTS `payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `contract_id` int(11) NOT NULL,
  `summe` float NOT NULL,
  `period` date NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `contract_id` (`contract_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=163 ;

--
-- Daten für Tabelle `payment`
--

INSERT INTO `payment` (`id`, `contract_id`, `summe`, `period`, `date`, `comment`) VALUES
(1, 1, 1800, '2018-06-01', '2018-05-31 22:00:00', ''),
(2, 1, 1800, '2018-07-01', '2018-06-30 22:00:00', ''),
(3, 1, 1800, '2018-08-01', '2018-07-31 22:00:00', ''),
(4, 1, 1800, '2018-09-01', '2018-08-31 22:00:00', ''),
(5, 2, 0, '2018-09-20', '2018-09-30 22:00:00', ''),
(6, 2, 2200, '2018-10-01', '2019-02-11 17:18:39', ''),
(7, 2, 2200, '2018-11-01', '2019-02-11 17:19:06', ''),
(8, 2, 2200, '2018-12-01', '2019-02-11 17:21:36', ''),
(9, 2, 500, '2019-01-01', '2019-02-11 17:21:36', 'Долг'),
(10, 3, 2500, '2019-02-01', '2019-02-11 17:21:36', ''),
(11, 1, 1800, '2018-10-01', '2019-02-11 19:39:07', ''),
(12, 1, 1800, '2018-11-01', '2019-02-11 19:40:44', ''),
(13, 4, 2000, '2018-12-01', '2019-02-11 19:40:44', ''),
(14, 3, 2500, '2019-03-01', '2019-04-12 06:13:24', ''),
(15, 4, 2000, '2019-01-01', '2019-04-12 06:22:53', ''),
(16, 4, 2000, '2019-02-01', '2019-04-12 06:22:53', ''),
(17, 5, 3000, '2019-04-13', '2019-07-10 18:59:37', ''),
(18, 5, 3000, '2019-05-01', '2019-07-10 19:01:55', ''),
(19, 5, 3000, '2019-06-01', '2019-07-10 19:01:55', ''),
(20, 4, 2000, '2019-03-01', '2019-07-10 19:27:39', ''),
(21, 4, 1500, '2019-04-01', '2019-07-10 19:28:14', ''),
(22, 4, 2000, '2019-05-01', '2019-07-10 19:31:10', ''),
(23, 4, 2000, '2019-06-01', '2019-07-10 19:31:10', ''),
(24, 6, 2800, '2019-07-01', '2019-09-12 17:45:01', '.200 интернет'),
(27, 4, 2000, '2019-07-01', '2019-09-12 18:07:35', ''),
(33, 6, 3000, '2019-09-15', '2019-09-22 15:39:38', ''),
(34, 6, 3000, '2019-10-23', '2019-10-26 18:42:02', ''),
(35, 6, 3000, '2019-11-18', '2019-11-19 19:01:45', ''),
(36, 6, 3000, '2019-08-19', '2019-11-19 19:23:24', ''),
(38, 7, 2000, '2019-11-01', '2019-12-06 19:51:21', ''),
(39, 8, 3000, '2019-11-25', '2019-12-06 20:12:48', ''),
(40, 6, 3000, '2019-12-22', '2019-12-23 11:26:03', ''),
(45, 7, 2000, '2019-12-27', '2020-01-05 19:45:21', ''),
(46, 8, 3000, '2019-12-20', '2020-01-11 17:31:20', ''),
(47, 7, 2000, '2020-01-05', '2020-01-11 18:07:28', ''),
(48, 7, 2000, '2020-02-03', '2020-02-03 18:31:12', ''),
(49, 8, 3000, '2020-01-25', '2020-02-03 18:33:26', ''),
(51, 6, 3000, '2020-01-15', '2020-02-10 17:42:06', ''),
(52, 7, 2000, '2020-03-03', '2020-03-12 19:18:22', ''),
(53, 6, 3000, '2020-02-20', '2020-03-12 19:19:07', ''),
(54, 8, 3000, '2020-02-25', '2020-03-12 19:19:32', ''),
(55, 9, 3000, '2020-04-01', '2020-12-06 16:06:27', ''),
(56, 9, 3000, '2020-05-01', '2020-12-06 16:12:16', ''),
(57, 9, 3000, '2020-06-01', '2020-12-06 16:13:42', ''),
(58, 9, 3000, '2020-07-01', '2020-12-06 16:13:56', ''),
(59, 9, 3000, '2020-08-01', '2020-12-06 16:14:11', ''),
(60, 9, 3000, '2020-09-01', '2020-12-06 16:14:57', ''),
(61, 10, 2900, '2020-10-01', '2020-12-06 16:15:32', '(Вл - 300)'),
(62, 10, 2900, '2020-11-01', '2020-12-06 16:15:55', '(Владик - 300)'),
(63, 7, 2000, '2020-04-01', '2020-12-06 16:20:55', ''),
(64, 7, 2000, '2020-05-01', '2020-12-06 16:21:12', ''),
(65, 7, 2000, '2020-06-01', '2020-12-06 16:21:29', ''),
(66, 7, 2000, '2020-07-01', '2020-12-06 16:21:37', ''),
(67, 7, 2000, '2020-08-01', '2020-12-06 16:21:54', ''),
(68, 7, 2000, '2020-09-01', '2020-12-06 16:22:04', ''),
(69, 7, 2000, '2020-10-01', '2020-12-06 16:22:16', ''),
(70, 7, 2000, '2020-11-01', '2020-12-06 16:22:26', ''),
(71, 6, 3000, '2020-03-01', '2020-12-06 16:23:56', ''),
(72, 6, 3000, '2020-04-01', '2020-12-06 16:24:08', ''),
(73, 6, 3000, '2020-05-01', '2020-12-06 16:24:20', ''),
(74, 6, 3000, '2020-06-01', '2020-12-06 16:24:28', ''),
(75, 6, 3000, '2020-07-01', '2020-12-06 16:24:40', ''),
(76, 6, 3000, '2020-08-01', '2020-12-06 16:24:56', ''),
(77, 6, 3000, '2020-09-01', '2020-12-06 16:25:09', ''),
(79, 6, 3000, '2020-10-01', '2020-12-19 17:56:47', ''),
(81, 6, 3000, '2020-12-01', '2020-12-19 17:58:47', ''),
(82, 6, 3000, '2020-11-01', '2020-12-19 17:59:36', ''),
(83, 11, 2000, '2020-09-01', '2020-12-19 18:11:05', ''),
(84, 11, 2000, '2020-10-01', '2020-12-19 18:11:14', ''),
(85, 11, 2000, '2020-11-01', '2020-12-19 18:12:21', ''),
(87, 11, 1000, '2020-12-01', '2020-12-19 18:13:00', ''),
(88, 10, 2900, '2020-12-01', '2021-04-14 15:10:52', ''),
(89, 10, 2900, '2021-01-01', '2021-04-14 15:11:39', ''),
(90, 10, 3000, '2021-02-01', '2021-04-14 15:12:03', ''),
(91, 10, 3000, '2021-03-01', '2021-04-14 15:14:36', ''),
(92, 6, 3000, '2021-01-01', '2021-04-14 15:15:35', ''),
(93, 6, 3000, '2021-02-01', '2021-04-14 15:15:42', ''),
(94, 6, 3000, '2021-03-01', '2021-04-14 15:15:51', ''),
(95, 7, 2000, '2020-12-01', '2021-04-14 15:16:27', ''),
(96, 7, 2000, '2021-01-01', '2021-04-14 15:16:36', ''),
(97, 7, 2000, '2021-02-01', '2021-04-14 15:16:50', ''),
(98, 7, 2000, '2021-03-01', '2021-04-14 15:16:58', ''),
(99, 12, 3000, '2021-04-12', '2021-04-26 14:14:39', ''),
(100, 13, 2800, '2021-03-25', '2021-04-26 14:18:53', ''),
(101, 14, 3000, '2021-04-19', '2021-04-26 14:20:55', ''),
(102, 12, 2600, '2021-05-03', '2021-07-25 16:24:50', ''),
(104, 12, 3000, '2021-06-01', '2021-07-25 16:26:00', ''),
(106, 7, 2100, '2021-06-01', '2021-07-25 16:31:38', ''),
(107, 7, 2000, '2021-05-01', '2021-07-25 16:33:04', ''),
(108, 7, 2000, '2021-04-01', '2021-07-25 16:33:15', ''),
(109, 7, 2500, '2021-07-01', '2021-07-25 16:33:50', ''),
(110, 6, 3000, '2021-04-01', '2021-07-25 16:35:07', ''),
(111, 6, 3000, '2021-05-01', '2021-07-25 16:35:15', ''),
(112, 6, 3000, '2021-06-01', '2021-07-25 16:35:22', ''),
(115, 6, 3000, '2021-07-01', '2021-12-28 17:30:27', ''),
(116, 6, 3000, '2021-08-01', '2021-12-28 17:30:52', ''),
(117, 6, 3000, '2021-09-01', '2021-12-28 17:31:00', ''),
(121, 7, 2000, '2021-08-01', '2021-12-28 18:02:53', ''),
(122, 7, 2000, '2021-09-01', '2021-12-28 18:03:03', ''),
(123, 7, 2000, '2021-10-01', '2021-12-28 18:03:13', ''),
(124, 7, 2000, '2021-11-01', '2021-12-28 18:03:31', ''),
(125, 7, 2000, '2021-12-01', '2021-12-28 18:03:46', ''),
(126, 12, 3000, '2021-07-01', '2021-12-28 18:04:44', ''),
(127, 12, 3000, '2021-08-01', '2021-12-28 18:05:15', ''),
(128, 12, 3000, '2021-09-01', '2021-12-28 18:05:23', ''),
(129, 12, 3000, '2021-10-01', '2021-12-28 18:05:29', ''),
(130, 12, 3000, '2021-11-01', '2021-12-28 18:05:46', ''),
(131, 6, 3000, '2021-10-01', '2022-09-21 16:08:11', ''),
(132, 6, 3000, '2021-11-01', '2022-09-21 16:08:26', ''),
(133, 6, 3000, '2021-12-01', '2022-09-21 16:08:33', ''),
(134, 6, 3000, '2022-01-01', '2022-09-21 16:08:50', ''),
(135, 6, 3000, '2022-02-01', '2022-09-21 16:08:59', ''),
(136, 6, 3000, '2022-03-01', '2022-09-21 16:09:06', ''),
(137, 6, 3000, '2022-04-01', '2022-09-21 16:09:13', ''),
(138, 6, 3000, '2022-05-01', '2022-09-21 16:09:23', ''),
(139, 6, 3000, '2022-06-01', '2022-09-21 16:09:48', ''),
(140, 6, 3000, '2022-07-01', '2022-09-21 16:10:03', ''),
(141, 6, 3000, '2022-08-01', '2022-09-21 16:10:13', ''),
(142, 12, 3000, '2021-12-01', '2022-09-21 16:47:58', ''),
(143, 12, 3000, '2022-01-01', '2022-09-21 16:48:34', ''),
(144, 12, 3000, '2022-02-01', '2022-09-21 16:48:42', ''),
(145, 12, 3000, '2022-03-01', '2022-09-21 16:48:47', ''),
(146, 12, 4000, '2022-04-01', '2022-09-21 16:49:09', ''),
(147, 12, 4000, '2022-05-01', '2022-09-21 16:49:18', ''),
(148, 12, 4000, '2022-06-01', '2022-09-21 16:49:26', ''),
(149, 12, 4000, '2022-07-01', '2022-09-21 16:49:31', ''),
(150, 12, 4000, '2022-08-01', '2022-09-21 16:49:37', ''),
(151, 7, 2000, '2022-01-01', '2022-09-21 17:22:06', ''),
(152, 7, 2000, '2022-02-01', '2022-09-21 17:22:18', ''),
(153, 7, 2000, '2022-04-01', '2022-09-21 17:22:44', ''),
(154, 7, 2500, '2022-05-01', '2022-09-21 17:22:53', ''),
(155, 7, 2500, '2022-06-01', '2022-09-21 17:23:00', ''),
(156, 7, 2500, '2022-07-01', '2022-09-21 17:23:05', ''),
(157, 7, 2500, '2022-08-01', '2022-09-21 17:23:11', ''),
(158, 7, 2500, '2022-09-01', '2022-11-14 17:44:54', ''),
(159, 7, 2500, '2022-10-01', '2022-11-14 17:45:03', ''),
(160, 7, 3500, '2022-11-01', '2022-11-14 17:45:57', ''),
(161, 12, 4000, '2022-09-01', '2022-11-14 17:49:46', ''),
(162, 12, 4500, '2022-10-01', '2022-11-14 17:49:58', '');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ref_estate_accessory`
--

CREATE TABLE IF NOT EXISTS `ref_estate_accessory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estate_id` int(11) NOT NULL,
  `accessory_id` int(11) NOT NULL,
  `status` enum('new','almost_new','normal','old') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Daten für Tabelle `ref_estate_accessory`
--

INSERT INTO `ref_estate_accessory` (`id`, `estate_id`, `accessory_id`, `status`) VALUES
(1, 1, 1, 'old'),
(2, 1, 2, 'new'),
(3, 1, 3, 'new'),
(4, 1, 4, 'old'),
(5, 1, 4, 'normal'),
(6, 2, 1, 'new'),
(7, 2, 2, 'normal'),
(8, 2, 4, 'normal');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `role`
--

CREATE TABLE IF NOT EXISTS `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Daten für Tabelle `role`
--

INSERT INTO `role` (`id`, `name`, `description`) VALUES
(1, 'Admin', 'Admin'),
(2, 'Сlient', 'Сlient');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `state`
--

CREATE TABLE IF NOT EXISTS `state` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Daten für Tabelle `state`
--

INSERT INTO `state` (`id`, `name`) VALUES
(1, 'Кировоградская');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `task`
--

CREATE TABLE IF NOT EXISTS `task` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `data` text NOT NULL,
  `status` enum('active','closed') NOT NULL DEFAULT 'active',
  `date_start` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `interval` char(50) DEFAULT NULL COMMENT 'Y-M-D h:m:s',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Daten für Tabelle `task`
--

INSERT INTO `task` (`id`, `title`, `name`, `data`, `status`, `date_start`, `interval`) VALUES
(1, 'test', 'test', '', 'active', '0000-00-00 00:00:00', '0 * * * * *');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Daten für Tabelle `user`
--

INSERT INTO `user` (`id`, `username`, `email`, `password`, `role_id`) VALUES
(1, 'admin', '', '$2a$10$OWisVlgw8VCvovKiKAyD8.xJg0H3d6B6amKHOII5t6AQxVa7FzlnW', '0'),
(2, 'temp', '', '$2a$10$OWisVlgw8VCvovKiKAyD8.xJg0H3d6B6amKHOII5t6AQxVa7FzlnW', '1');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
