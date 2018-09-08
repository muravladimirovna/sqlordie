SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- База данных: `srv72360_sqlex`
--

-- --------------------------------------------------------

--
-- Структура таблицы `db`
--

DROP TABLE IF EXISTS `db`;
CREATE TABLE IF NOT EXISTS `db` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `info` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп данных таблицы `db`
--

INSERT INTO `db` (`id`, `info`) VALUES
(1, 'Схема БД состоит из четырех таблиц:<br>\nproduct(maker, model, type)<br>\npc(code, model, speed, ram, hd, cd, price)<br>\nlaptop(code, model, speed, ram, hd, price, screen)<br>\nprinter(code, model, color, type, price)<br>\nТаблица product представляет производителя (maker), номер модели (model) и тип (''PC'' - ПК, ''Laptop'' - ПК-блокнот или ''Printer'' - принтер). \nПредполагается, что номера моделей в таблице product уникальны для всех производителей и типов продуктов. \nВ таблице pc для каждого ПК, однозначно определяемого уникальным кодом – code, указаны модель – model (внешний ключ к таблице product), \nскорость - speed (процессора в мегагерцах), объем памяти - ram (в мегабайтах), размер диска - hd (в гигабайтах), \nскорость считывающего устройства - cd (например, ''4x'') и цена - price. Таблица laptop аналогична таблице pc за исключением того, \nчто вместо скорости CD содержит размер экрана -screen (в дюймах). В таблице printer для каждой модели принтера указывается, \nявляется ли он цветным - color (''y'', если цветной), тип принтера - type (лазерный – ''Laser'', струйный – ''Jet'' или матричный – ''Matrix'') \nи цена - price.'),
(2, 'Схема БД состоит из одной таблицы:<br>\r\nstudent(id, name, lname, date, pol)<br>\r\nТаблица student представляет уникальный номер (id), имя студента (name), фамилия студента (lname), дата рождения (date), пол студента (pol).'),
(3, 'Схема БД состоит из четырех таблиц:<br>\nproduct(maker, model, type)<br>\npc(code, model, speed, ram, hd, cd, price)<br>\nlaptop(code, model, speed, ram, hd, price, screen)<br>\nprinter(code, model, color, type, price)<br>\nТаблица product представляет производителя (maker), номер модели (model) и тип (''PC'' - ПК, ''Laptop'' - ПК-блокнот или ''Printer'' - принтер). \nПредполагается, что номера моделей в таблице product уникальны для всех производителей и типов продуктов. \nВ таблице pc для каждого ПК, однозначно определяемого уникальным кодом – code, указаны модель – model (внешний ключ к таблице product), \nскорость - speed (процессора в мегагерцах), объем памяти - ram (в мегабайтах), размер диска - hd (в гигабайтах), \nскорость считывающего устройства - cd (например, ''4x'') и цена - price. Таблица laptop аналогична таблице pc за исключением того, \nчто вместо скорости CD содержит размер экрана -screen (в дюймах). В таблице printer для каждой модели принтера указывается, \nявляется ли он цветным - color (''y'', если цветной), тип принтера - type (лазерный – ''Laser'', струйный – ''Jet'' или матричный – ''Matrix'') \nи цена - price.');

-- --------------------------------------------------------

--
-- Структура таблицы `eqer`
--

DROP TABLE IF EXISTS `eqer`;
CREATE TABLE IF NOT EXISTS `eqer` (
  `id` int(11) NOT NULL,
  `qer` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `eqer`
--

INSERT INTO `eqer` (`id`, `qer`) VALUES
(1, 'INSERT INTO pc1(code,model,price) VALUES (''13'',''1157'',''820.00'')');

-- --------------------------------------------------------

--
-- Структура таблицы `etasks`
--

DROP TABLE IF EXISTS `etasks`;
CREATE TABLE IF NOT EXISTS `etasks` (
  `id` int(11) NOT NULL,
  `task` text NOT NULL,
  `tname` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `etasks`
--

INSERT INTO `etasks` (`id`, `task`, `tname`) VALUES
(1, 'Добавить в таблицу pc модель ПК 1157 стоимостью 820.00', 'pc'),
(2, 'Задание 2', 'laptop');

-- --------------------------------------------------------

--
-- Структура таблицы `groups`
--

DROP TABLE IF EXISTS `groups`;
CREATE TABLE IF NOT EXISTS `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп данных таблицы `groups`
--

INSERT INTO `groups` (`id`, `name`) VALUES
(1, 'П-13'),
(2, 'П-14'),
(3, 'П-15'),
(4, 'П-16');

-- --------------------------------------------------------

--
-- Структура таблицы `laptop`
--

DROP TABLE IF EXISTS `laptop`;
CREATE TABLE IF NOT EXISTS `laptop` (
  `code` int(11) NOT NULL,
  `model` varchar(50) NOT NULL,
  `speed` smallint(6) NOT NULL,
  `ram` smallint(6) NOT NULL,
  `hd` double NOT NULL,
  `price` decimal(12,2) DEFAULT NULL,
  `screen` tinyint(4) NOT NULL,
  PRIMARY KEY (`code`),
  KEY `FK_Laptop_product` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `laptop`
--

INSERT INTO `laptop` (`code`, `model`, `speed`, `ram`, `hd`, `price`, `screen`) VALUES
(1, '1298', 350, 32, 4, 700.00, 11),
(2, '1321', 500, 64, 8, 970.00, 12),
(3, '1750', 750, 128, 12, 1200.00, 14),
(4, '1298', 600, 64, 10, 1050.00, 15),
(5, '1752', 750, 128, 10, 1150.00, 14),
(6, '1298', 450, 64, 10, 950.00, 12);

-- --------------------------------------------------------

--
-- Структура таблицы `pc`
--

DROP TABLE IF EXISTS `pc`;
CREATE TABLE IF NOT EXISTS `pc` (
  `code` int(11) NOT NULL,
  `model` varchar(50) NOT NULL,
  `speed` smallint(6) NOT NULL,
  `ram` smallint(6) NOT NULL,
  `hd` double NOT NULL,
  `cd` varchar(10) NOT NULL,
  `price` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`code`),
  KEY `FK_pc_product` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `pc`
--

INSERT INTO `pc` (`code`, `model`, `speed`, `ram`, `hd`, `cd`, `price`) VALUES
(1, '1232', 500, 64, 5, '12x', 600.00),
(2, '1121', 750, 128, 14, '40x', 850.00),
(3, '1233', 500, 64, 5, '12x', 600.00),
(4, '1121', 600, 128, 14, '40x', 850.00),
(5, '1121', 600, 128, 8, '40x', 850.00),
(6, '1233', 750, 128, 20, '50x', 950.00),
(7, '1232', 500, 32, 10, '12x', 400.00),
(8, '1232', 450, 64, 8, '24x', 350.00),
(9, '1232', 450, 32, 10, '24x', 350.00),
(10, '1260', 500, 16, 10, '12x', 250.00),
(11, '1233', 900, 128, 40, '40x', 980.00),
(12, '1233', 800, 128, 20, '50x', 970.00);

-- --------------------------------------------------------

--
-- Структура таблицы `pc1`
--

DROP TABLE IF EXISTS `pc1`;
CREATE TABLE IF NOT EXISTS `pc1` (
  `code` int(11) NOT NULL,
  `model` varchar(50) NOT NULL,
  `speed` smallint(6) NOT NULL,
  `ram` smallint(6) NOT NULL,
  `hd` double NOT NULL,
  `cd` varchar(10) NOT NULL,
  `price` decimal(12,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `pc1`
--

INSERT INTO `pc1` (`code`, `model`, `speed`, `ram`, `hd`, `cd`, `price`) VALUES
(1, '1232', 500, 64, 5, '12x', 600.00),
(2, '1121', 750, 128, 14, '40x', 850.00),
(3, '1233', 500, 64, 5, '12x', 600.00),
(4, '1121', 600, 128, 14, '40x', 850.00),
(5, '1121', 600, 128, 8, '40x', 850.00),
(6, '1233', 750, 128, 20, '50x', 950.00),
(7, '1232', 500, 32, 10, '12x', 400.00),
(8, '1232', 450, 64, 8, '24x', 350.00),
(9, '1232', 450, 32, 10, '24x', 350.00),
(10, '1260', 500, 16, 10, '12x', 250.00),
(11, '1233', 900, 128, 40, '40x', 980.00),
(12, '1233', 800, 128, 20, '50x', 970.00),
(13, '1157', 0, 0, 0, '', 820.00);

-- --------------------------------------------------------

--
-- Структура таблицы `printer`
--

DROP TABLE IF EXISTS `printer`;
CREATE TABLE IF NOT EXISTS `printer` (
  `code` int(11) NOT NULL,
  `model` varchar(50) NOT NULL,
  `color` char(1) NOT NULL,
  `type` varchar(10) NOT NULL,
  `price` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`code`),
  KEY `FK_printer_product` (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `printer`
--

INSERT INTO `printer` (`code`, `model`, `color`, `type`, `price`) VALUES
(1, '1276', 'n', 'Laser', 400.00),
(2, '1433', 'y', 'Jet', 270.00),
(3, '1434', 'y', 'Jet', 290.00),
(4, '1401', 'n', 'Matrix', 150.00),
(5, '1408', 'n', 'Matrix', 270.00),
(6, '1288', 'n', 'Laser', 450.00);

-- --------------------------------------------------------

--
-- Структура таблицы `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `maker` varchar(10) NOT NULL,
  `model` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `product`
--

INSERT INTO `product` (`maker`, `model`, `type`) VALUES
('B', '1121', 'PC'),
('A', '1232', 'PC'),
('A', '1233', 'PC'),
('B', '1253', 'Printer'),
('E', '1260', 'PC'),
('A', '1276', 'Printer'),
('D', '1288', 'Printer'),
('A', '1298', 'Laptop'),
('C', '1321', 'Laptop'),
('A', '1401', 'Printer'),
('A', '1408', 'Printer'),
('D', '1433', 'Printer'),
('E', '1434', 'Printer'),
('B', '1750', 'Laptop'),
('A', '1752', 'Laptop'),
('E', '2112', 'PC'),
('E', '2113', 'PC');

-- --------------------------------------------------------

--
-- Структура таблицы `qer`
--

DROP TABLE IF EXISTS `qer`;
CREATE TABLE IF NOT EXISTS `qer` (
  `id` int(11) NOT NULL,
  `qer` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `qer`
--

INSERT INTO `qer` (`id`, `qer`) VALUES
(1, 'select *\r\nfrom pc'),
(2, 'select speed, ram\r\nfrom pc'),
(3, 'select distinct ram, hd\r\nfrom pc'),
(4, 'select model, price from pc order by price'),
(5, 'select ram, price\nfrom pc\norder by ram desc , price desc'),
(6, 'select price, model\r\nfrom pc\r\nwhere price<=1000'),
(7, 'select model, maker\r\nfrom product\r\nwhere type="laptop"'),
(8, 'SELECT cd, model, price\r\nFROM pc\r\nWHERE cd<="40x"'),
(9, 'SELECT model, price\nFROM printer\nWHERE color like "n"'),
(10, 'select model, price, speed\r\nfrom pc\r\nwhere price<=(speed*2)'),
(11, 'SELECT model, maker, type\nFROM product\nWHERE maker="A" and not type="pc"'),
(12, 'select model, maker, type\nfrom product\nwhere type="laptop"'),
(13, 'select model, maker, type\r\nfrom product\r\nwhere type="pc" and maker="a" or type="pc" and maker="b"'),
(14, 'select *\r\nfrom pc\r\nwhere speed>=500 and price<800'),
(15, 'select *\r\nfrom printer\r\nwhere not type="matrix" and price<300'),
(16, 'select model, speed\r\nfrom pc\r\nwhere price between 400 and 600'),
(17, 'select model, speed, hd\r\nfrom pc\r\nwhere hd in (5,10,14,20)'),
(18, 'select ram as mb, hd as gb\r\nfrom pc'),
(19, 'select ram as kb, hd as gb\r\nfrom pc'),
(20, 'select lname, name, pol\nfrom student\nwhere lname like "В%"'),
(21, 'select lname, name\nfrom student\nwhere lname like "А%а"'),
(22, 'select *\r\nfrom student\r\nwhere name = "андрей"'),
(23, 'select *\r\nfrom student\r\nwhere pol="м"'),
(24, 'select *\r\nfrom student\r\nwhere id like "%[02468]"'),
(25, 'select *\r\nfrom student\r\nwhere id like "%1%"'),
(26, 'select min(price) as min_cena, max(price) as max_cena\r\nfrom pc'),
(27, 'select count(model) as kolvo_pc\r\nfrom product\r\nwhere maker="a" and type="pc"'),
(28, 'select count(model) as kolvo, avg(price) as sred_cena\r\nfrom pc\r\ngroup by model'),
(29, 'select maker, count(model) as kolvo\r\nfrom product\r\ngroup by maker'),
(30, 'select pc.model, avg(price) as sred_cena, count(model) as kolvo\r\nfrom pc\r\ngroup by pc.model\r\nhaving avg(price)<800'),
(31, 'select model, min(price) as min_cena, max(price) as max_cena, avg(price) as sred_cena\r\nfrom pc\r\ngroup by model'),
(32, 'select model, min(price) as min_cena, max(price) as max_cena, avg(price) as sred_cena\r\nfrom pc\r\ngroup by model\r\nhaving avg(price)<600'),
(33, 'select ram, count(model) as kolvo\r\nfrom pc\r\ngroup by ram'),
(34, 'select pc.model, maker, price\r\nfrom product inner join pc on pc.model=product.model'),
(35, 'select laptop.model, maker, screen\r\nfrom product inner join laptop on laptop.model=product.model\r\nwhere screen>12'),
(36, 'select  model, price\r\nfrom pc\r\nunion \r\nselect model, price\r\nfrom laptop\r\norder by price'),
(37, 'select type, pc.model, price\r\nfrom product inner join pc on pc.model=product.model\r\nunion \r\nselect type, laptop.model, price\r\nfrom product inner join laptop on laptop.model=product.model'),
(38, 'select maker, type, ram, pc.model\r\nfrom product inner join pc on pc.model=product.model\r\nwhere ram > 64\r\nunion \r\nselect maker, type, hd, laptop.model\r\nfrom product inner join laptop on laptop.model=product.model\r\nwhere hd >= 10'),
(39, 'select distinct pc.model\r\nfrom pc inner join product on product.model = pc.model'),
(40, 'select model\r\nfrom product\r\nwhere not model in (select model\r\nfrom laptop)'),
(41, 'не работает пока'),
(42, 'select ram, avg(price) as sred_cena\r\nfrom pc\r\nwhere ram=128\r\ngroup by ram'),
(43, 'select *\r\nfrom pc\r\nwhere ram=(select min(ram)\r\nfrom pc)'),
(44, 'select *\r\nfrom pc\r\nwhere price >(select avg(price)\r\nfrom pc)'),
(45, 'select model, price\r\nfrom laptop\r\nwhere price > (select max(price) from pc)'),
(46, 'select distinct maker, speed\r\nfrom product inner join\r\nlaptop on laptop.model = product.model\r\nwhere hd>=10'),
(47, 'select product.model, price\r\nfrom product inner join\r\npc on pc.model = product.model\r\nwhere maker="b"\r\nunion\r\nselect product.model, price\r\nfrom product inner join\r\nprinter on printer.model = product.model\r\nwhere maker="b"\r\nunion\r\nselect product.model, price\r\nfrom product inner join\r\nlaptop on laptop.model = product.model\r\nwhere maker="b"'),
(48, 'select distinct maker\r\nfrom pc, product\r\nwhere speed>=450 and pc.model=product.model'),
(49, 'select hd\r\nfrom pc\r\ngroup by hd\r\nhaving count(model)>=2'),
(50, 'select maker, avg(screen) as sred_screen\r\nfrom product, laptop\r\nwhere laptop.model=product.model\r\ngroup by maker'),
(51, 'select maker, count(model) as kolvo\r\nfrom product\r\nwhere type ="pc"\r\ngroup by maker\r\nhaving count(model)>=3'),
(52, 'select maker, max(price) as max_price\r\nfrom product, pc\r\nwhere pc.model=product.model\r\ngroup by maker'),
(53, 'select distinct maker\r\nfrom product, pc\r\nwhere type="pc" and speed>=750 and product.model=pc.model and maker in (select maker\r\nfrom product, laptop\r\nwhere type="laptop" and speed>=750 and product.model=laptop.model)');

-- --------------------------------------------------------

--
-- Структура таблицы `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(12) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'admin'),
(2, 'user');

-- --------------------------------------------------------

--
-- Структура таблицы `student`
--

DROP TABLE IF EXISTS `student`;
CREATE TABLE IF NOT EXISTS `student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `lname` varchar(30) NOT NULL,
  `age` date NOT NULL DEFAULT '1999-01-01',
  `pol` varchar(1) NOT NULL DEFAULT 'м',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=31 ;

--
-- Дамп данных таблицы `student`
--

INSERT INTO `student` (`id`, `name`, `lname`, `age`, `pol`) VALUES
(1, 'Артем', 'Абрамов', '1999-01-01', 'м'),
(2, 'Владимир', 'Абрамов', '1999-01-01', 'м'),
(3, 'Алена', 'Антипова', '1999-01-01', 'ж'),
(4, 'Владислав', 'Васильев', '1999-01-01', 'м'),
(5, 'Елена', 'Ватолина', '1999-01-01', 'ж'),
(6, 'Николай', 'Ващенко', '1999-01-01', 'м'),
(7, 'Андрей', 'Волошин', '1999-01-01', 'м'),
(8, 'Георгий', 'Гурин', '1999-01-01', 'м'),
(9, 'Петр', 'Дмитриев', '1999-01-01', 'м'),
(10, 'Дина', 'Жерноклева', '1999-01-01', 'ж'),
(11, 'Владислав', 'Карапетьянц', '1999-01-01', 'м'),
(12, 'Дмитрий', 'Кателкин', '1999-01-01', 'м'),
(13, 'Александр', 'Ковалев', '1999-01-01', 'м'),
(14, 'Анастасия', 'Козлова', '1999-01-01', 'ж'),
(15, 'Кристиан', 'Корепанов', '1999-01-01', 'м'),
(16, 'Павел', 'Коробицин', '1999-01-01', 'м'),
(17, 'Валерий', 'Кузнецов', '1999-01-01', 'м'),
(18, 'Андрей', 'Марченко', '1999-01-01', 'м'),
(19, 'Екатерина', 'Осягина', '1999-01-01', 'ж'),
(20, 'Андрей', 'Савостьянюк', '1999-01-01', 'м'),
(21, 'Виктория', 'Сердюкова', '1999-01-01', 'ж'),
(22, 'Марина', 'Уракова', '1999-01-01', 'ж'),
(23, 'Никита', 'Усманов', '1999-01-01', 'м'),
(24, 'Марк', 'Чаплыгин', '1999-01-01', 'м'),
(25, 'Татьяна', 'Шкуратова', '1999-01-01', 'ж'),
(26, 'Николай', 'Борсук', '1999-01-01', 'м'),
(27, 'Константин', 'Илле', '1999-01-01', 'м'),
(28, 'Дмитрий', 'Кафтан', '1999-01-01', 'м'),
(29, 'Дарья', 'Коцаренко', '1999-01-01', 'ж'),
(30, 'Станислав', 'Медунов', '1999-01-01', 'м');

-- --------------------------------------------------------

--
-- Структура таблицы `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE IF NOT EXISTS `tasks` (
  `id` int(11) NOT NULL,
  `task` text NOT NULL,
  `db` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `tasks`
--

INSERT INTO `tasks` (`id`, `task`, `db`) VALUES
(1, 'Вывести таблицу pc', 1),
(2, 'Вывести скорость процессора и оперативную память из таблицы pc', 1),
(3, 'Вывести оперативную память и объём жёсткого диска из таблицы pc, исключая повторы', 1),
(4, 'Вывести модели и цены компьютеров, отсортировав результат по цене', 1),
(5, 'Вывести оперативную память и цену компьютеров, выполнить сортировку по убыванию, сначала по памяти, затем по цене', 1),
(6, 'Вывести цену и модели компьютеров, чья цена не превышает 1000$', 1),
(7, 'Вывести модели и производителей планшетов', 1),
(8, 'Вывести скорость сд привода, модели и цену компьютеров поддерживающие скорость привода не более 40', 1),
(9, 'Вывести модель и цену чёрно-белых принтеров', 1),
(10, 'Вывести модели, цену и скорость процессоров тех компьютеров, цена которых не превышает удвоенной частоты процессора', 1),
(11, 'Вывести модели, производителя и тип, для продукции произведённой производителей А и которая не является pc', 1),
(12, 'Вывести модели, производителя и тип, для продукции не являющейся не pc и не принтерами', 1),
(13, 'Вывести модели, производителя и тип, для компьютеров, которые выпущены производителем А или производителем В', 1),
(14, 'Вывести информацию о компьютерах, имеющих частоту процессора не менее 500 Мгц и цену ниже 800$', 1),
(15, 'Вывести информацию о принтерах, которые не являются матричными и стоят меньше 300$', 1),
(16, 'Найти модель и частоту процессора компьютеров стоимостью от 400$ до 600$ (не используя предикаты сравнения)', 1),
(17, 'Найти модель, частоту процессора и объём жесткого диска тех компьютеров, которые комплектуются накопителями 5, 10, 14 или 20 Гб.', 1),
(18, 'Вывести оперативную память, размер жёсткого диска, переименовав столбцы Mb and Gb соответственно.', 1),
(19, 'Вывести оперативную память в килобайтах, размер жёсткого диска, переименовав столбцы Kb и Gb соответственно.', 1),
(20, 'Вывести фамилии, имя и пол студентов, чьи фамилии начинаются на букву "В".', 2),
(21, 'Вывести фамилии и имена студентов, чьи имена начинаются и заканчиваются на букву А', 2),
(22, 'Вывести информацию о студентах с именем Андрей', 2),
(23, 'Вывести информацию о студентах мужского пола.', 2),
(24, '(не работает)\r\nВывести информацию о студентах, с чётными номерами.', 2),
(25, 'Вывести записи из таблицы студент, номера которых будет содержать 1', 2),
(26, 'Найти минимальную и максимальную цену на персональные компьютеры (столбцы назвать корректно)', 1),
(27, 'Найти количество компьютеров, выпущенных производителей А (столбец назвать корректно)', 1),
(28, 'Для каждой модели из таблицы pc вывести количество моделей и среднюю цену (столбцы назвать корректно)', 1),
(29, 'Вывести для каждого производителя количество произведённых им моделей (столбцы назвать корректно)', 1),
(30, 'Для каждой модели компьютеров вывести количество моделей и среднюю цену, для тех чья средняя цена менее 800$', 1),
(31, 'Найти минимальную, максимальную и среднюю цену для каждой модели компьютеров', 1),
(32, 'Для каждой модели компьютеров найти минимальную, максимальную и среднюю цену для тех, чья средняя цена не превышает 600$', 1),
(33, 'Вывести объём оперативной памяти и количество компьютеров, в которых установлен такой же объём', 1),
(34, 'Найти номер модели, производителя и цену для каждого компьютера', 1),
(35, 'Найти модели и производителей, производящих планшеты с диагональю более 12''', 1),
(36, 'Найти номера моделей и цены пк и планшетов, начиная с дешёвых', 1),
(37, 'Найти тип продукции, номер модели и цену пк и планшетов', 1),
(38, 'Найти производителей, тип, объём оперативной памяти и модели для пк, у которых объём оперативной памяти превышает 64 и для планшетов с жёстким диском не меньше 10', 1),
(39, 'Найти модели, которые присутствуют как в таблице пк так и в таблице продукт', 1),
(40, 'Найти модели, из таблицы product, которые отсутствуют в таблице laptop', 1),
(41, '(не работает)\r\nНайти модели, из таблицы принтер, которые отсутствуют в таблице продукт', 1),
(42, 'Найти среднюю цену для ПК, с оперативной памятью 128 Мб и вывести эти данные.\r\n(столбцы назвать корректно)', 1),
(43, 'Вывести информацию о ПК, имеющих минимальную оперативную память', 1),
(44, 'Вывести информацию о ПК, имеющих цену выше средней', 1),
(45, 'Найти модели и цены планшетов, стоимость которых превышает стоимость любого из ПК', 1),
(46, 'Для каждого производителя, выпускающего laptop c объёмом жесткого диска не менее 10 Гбайт, найти скорости таких laptop.', 1),
(47, 'Найдите номера моделей и цены всех продуктов, выпущенных производителем B', 1),
(48, 'Найдите производителей ПК с процессором не менее 450 Мгц.', 1),
(49, 'Найдите размеры жестких дисков, совпадающих у двух и более PC.', 1),
(50, 'Для каждого производителя, найдите средний размер экрана выпускаемых им планшетов.', 1),
(51, 'Найдите производителей, выпускающих как минимум три различных модели ПК. Вывести: Maker, число моделей ПК. ', 1),
(52, 'Найдите максимальную цену ПК, выпускаемых каждым производителем.', 1),
(53, 'Найдите производителей, которые производили бы как ПК\r\nсо скоростью не менее 750 МГц, так и планшенты со скоростью не менее 750 МГц.', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login` text NOT NULL,
  `password` varchar(15) NOT NULL,
  `name` text NOT NULL,
  `lastname` text NOT NULL,
  `avatar` varchar(100) NOT NULL DEFAULT 'default-user.png',
  `score` int(11) NOT NULL DEFAULT '0',
  `answers` text,
  `eanswers` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=42 ;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `password`, `name`, `lastname`, `avatar`, `score`, `answers`, `eanswers`) VALUES
(1, 'Sawel', 'sql.ru', 'Alex', 'Sav', 'puNZzt4SHOs.jpg', 54, 'a:54:{i:0;b:0;i:1;b:0;i:2;b:0;i:3;b:0;i:4;b:0;i:5;b:0;i:6;b:0;i:7;b:0;i:8;b:0;i:9;b:0;i:10;b:0;i:11;b:0;i:12;b:0;i:13;b:0;i:14;b:0;i:15;b:0;i:16;b:0;i:17;b:0;i:18;b:0;i:19;b:0;i:20;b:0;i:21;b:0;i:22;b:0;i:23;b:0;i:24;b:0;i:25;b:0;i:26;b:0;i:27;b:0;i:28;b:0;i:29;b:0;i:30;b:0;i:31;b:0;i:32;b:0;i:33;b:0;i:34;b:0;i:35;b:0;i:36;b:0;i:37;b:0;i:38;b:0;i:39;b:0;i:40;b:0;i:41;b:0;i:42;b:0;i:43;b:0;i:44;b:0;i:45;b:0;i:46;b:0;i:47;b:0;i:48;b:0;i:49;b:0;i:50;b:0;i:51;b:0;i:52;b:0;i:53;b:0;}', ''),
(2, 'marina', '1234', 'Marina', 'Urakova', 'XM2XowO-TdU.jpg', 12, 'a:54:{i:0;b:0;i:1;s:16:"select * from pc";i:2;s:4:"true";i:3;s:31:"select distinct ram, hd\nfrom pc";i:4;s:42:"select model, price from pc order by price";i:5;s:56:"select ram, price\nfrom pc\norder by ram desc , price desc";i:6;s:46:"select price, model\nfrom pc\nwhere price<=1000\n";i:7;s:4:"true";i:8;s:47:"select cd, model, price\nfrom pc\nwhere cd<="40x"";i:9;s:16:"select * from pc";i:10;s:16:"select * from pc";i:11;s:72:"select model, maker, type\nfrom product\nwhere maker="a" and not type="pc"";i:12;s:58:"select model, maker, type\nfrom product\nwhere type="laptop"";i:13;b:0;i:14;b:0;i:15;b:0;i:16;b:0;i:17;b:0;i:18;b:0;i:19;b:0;i:20;b:0;i:21;b:0;i:22;b:0;i:23;b:0;i:24;b:0;i:25;b:0;i:26;b:0;i:27;b:0;i:28;b:0;i:29;b:0;i:30;b:0;i:31;b:0;i:32;b:0;i:33;b:0;i:34;b:0;i:35;b:0;i:36;b:0;i:37;b:0;i:38;b:0;i:39;b:0;i:40;b:0;i:41;b:0;i:42;b:0;i:43;b:0;i:44;b:0;i:45;b:0;i:46;b:0;i:47;b:0;i:48;b:0;i:49;b:0;i:50;b:0;i:51;b:0;i:52;b:0;i:53;b:0;}', ''),
(3, 'savagefar', 'dSraAD2QAEzS', 'Андрей', 'Волошин', 'default-user.png', 52, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;b:0;i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;s:4:"true";}', ''),
(4, 'lordby', 'azasus45', 'Павел', 'Коробицин', 'maxresdefault.jpg', 53, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;s:4:"true";i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;s:4:"true";i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;b:0;}', ''),
(5, 'panda1998', 'panda1998', 'Andrey', 'Marchenko', 'default-user.png', 40, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;s:4:"true";i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;b:0;i:41;b:0;i:42;b:0;i:43;b:0;i:44;b:0;i:45;b:0;i:46;b:0;i:47;b:0;i:48;b:0;i:49;b:0;i:50;b:0;i:51;b:0;i:52;b:0;i:53;b:0;}', ''),
(6, 'vikulja1998', 'viktorin1998', 'Виктория ', 'Сердюкова', 'default-user.png', 52, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;b:0;i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;s:4:"true";}', ''),
(7, 'sql1', 'sql1', 'Алена', 'Антипова', 'default-user.png', 53, 'a:54:{i:0;s:4:"true";i:1;s:18:"select * \r\nfrom pc";i:2;s:25:"select speed,ram\r\nfrom pc";i:3;s:31:"select distinct ram,hd\r\nfrom pc";i:4;s:44:"select model,price\r\nfrom pc\r\norder by price ";i:5;s:56:"select ram,price\r\nfrom pc\r\norder by ram desc ,price desc";i:6;s:48:"select price, model\r\nfrom pc\r\nwhere price < 1000";i:7;s:99:"select distinct laptop.model,maker\r\nfrom product\r\ninner join laptop on product.model=laptop.model\r\n";i:8;s:46:"select cd,model,price\r\nfrom pc\r\nwhere cd <= 40";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;s:4:"true";i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;s:4:"true";}', ''),
(8, 'andrysha', 'wCjNSCRS', 'Андрей', 'Савостьянюк', 'default-user.png', 52, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;b:0;i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;s:4:"true";}', ''),
(9, 'nastyakozlova', '1234567a', 'Анастасия', 'Козлова', 'default-user.png', 51, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;b:0;i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;b:0;}', ''),
(10, 'KARAPETUSHKA', 'Q234165T259190', 'vladislav', 'karapet`yanc', 'default-user.png', 50, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;b:0;i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;b:0;i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;b:0;}', ''),
(11, 'Artem', 'Artem4444', 'Артём', 'Абрамов', 'default-user.png', 54, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;s:4:"true";i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;s:4:"true";i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;s:4:"true";}', ''),
(12, 'leeenaaa', '20031998', 'Елена', 'Ватолина', 'default-user.png', 51, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;s:4:"true";i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;b:0;i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;b:0;}', ''),
(13, 'dije', '123QWE45rt', 'Дина', 'Жерноклёва', 'default-user.png', 53, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;s:4:"true";i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;s:4:"true";}', ''),
(14, 'vlad', '2589Vlad', 'Vladislav', 'Vasilew', '1-2-D72-25-ExplorePAHistory-a0j8p9-a_349.jpg', 52, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;s:4:"true";i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:58:"select hd\r\nfrom pc \r\ngroup by (hd)\r\nhaving count(model)>=2";i:50;s:121:"select  maker, avg(screen) as sred_screen\r\nfrom  product inner join laptop\r\non product.model=laptop.model\r\ngroup by maker";i:51;s:112:"select maker, count(model) as kolvo\r\nfrom product\r\nwhere type = "pc"\r\ngroup by maker\r\nhaving count(model) >= 3\r\n";i:52;s:128:"select maker,max(price) as max_price\r\nfrom pc inner join product\r\non pc.model=product.model\r\nwhere type = "pc"\r\ngroup by maker\r\n";i:53;b:0;}', ''),
(15, 'roadto5000mmr', '123', '1', '1', 'default-user.png', 42, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;b:0;i:24;s:4:"true";i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;b:0;i:40;s:4:"true";i:41;b:0;i:42;b:0;i:43;b:0;i:44;s:4:"true";i:45;b:0;i:46;s:4:"true";i:47;b:0;i:48;s:4:"true";i:49;b:0;i:50;b:0;i:51;b:0;i:52;b:0;i:53;b:0;}', ''),
(16, 'tash', '17savin', 'Татьяна', 'Шкуратова', 'default-user.png', 53, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;s:4:"true";i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;s:4:"true";}', ''),
(17, 'Legate', 'ROME7471D', 'Дмитрий', 'Кателкин', '01acb64782a4.png', 53, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;s:4:"true";i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;s:4:"true";}', ''),
(18, 'sotra18', 'g6', 'Георгий', 'Гурин ', 'default-user.png', 52, 'a:54:{i:0;s:4:"true";i:1;s:15:"select *from pc";i:2;s:26:"select speed,ram\r\nfrom pc ";i:3;s:34:"select distinct ram,hd  \r\nfrom pc ";i:4;s:44:"select model,price\r\nfrom pc\r\norder by price ";i:5;s:55:"select ram,price\r\nfrom pc\r\norder by ram desc,price desc";i:6;s:46:"select price,model\r\nfrom pc \r\nwhere price<1000";i:7;s:53:"select model,maker\r\nfrom product\r\nwhere type="laptop"";i:8;s:47:"select cd,model,price\r\nfrom pc\r\nwhere cd <=40\r\n";i:9;s:51:"select model,price\r\nfrom printer\r\nwhere color <>"y"";i:10;s:56:"select model,price,speed\r\nfrom pc\r\nwhere price < speed*2";i:11;s:73:"select model,maker,type\r\nfrom product \r\nwhere maker ="a" and type<>"pc"\r\n";i:12;s:76:"select model,maker,type\r\nfrom product\r\nwhere type<>"pc" and type<>"printer" ";i:13;s:83:"select model,maker,type\r\nfrom product\r\nwhere (maker="a" or maker="b") and type="pc"";i:14;s:48:"select *\r\nfrom pc\r\nwhere speed=500 and price<800";i:15;s:58:"select*\r\nfrom printer\r\nwhere type<>"matrix" and price <300";i:16;s:60:"select model,speed\r\nfrom pc\r\nwhere price>=400 and price<=600";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;b:0;i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;s:4:"true";}', ''),
(19, 'KeyVoN', 'qwerty321', 'Валера', 'Кузнецов', 'default-user.png', 52, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;b:0;i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;s:4:"true";}', ''),
(20, 'petr', 'xfhfbxtr', 'Петр', 'Дмитриев', '2.png', 51, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;b:0;i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;b:0;}', ''),
(21, 'daryakotsarenko', 'vladlove14', 'Дарья', 'Коцаренко', 'default-user.png', 52, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;b:0;i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;s:4:"true";}', ''),
(22, 'AKovalev', 'Krimnash11', 'Александр', 'Ковалев', 'default-user.png', 51, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;s:4:"true";i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:106:"select maker, speed  from product inner join laptop on product.model = laptop.model   \r\nwhere hd >= 10  \r\n";i:47;b:0;i:48;s:105:"select maker  from pc inner join product on pc.model = product.model where speed >= 450 \r\ngroup by maker ";i:49;s:4:"true";i:50;s:122:"select maker, avg(screen) as sred_screen\r\nfrom product inner join laptop on\r\n laptop.model =  product.model group by maker";i:51;b:0;i:52;s:114:"select maker , max(price)as max_price \r\nfrom pc inner join product \r\non pc.model= product.model  \r\ngroup by maker ";i:53;s:200:"select distinct maker  \r\nfrom pc inner join product \r\non pc.model = product.model  \r\nwhere pc.speed >= 750 and maker in (select  maker  \r\nfrom laptop inner join product on laptop.model = product.model";}', ''),
(23, 'Xrosis', '669626', 'Николай', 'Ващенко', 'default-user.png', 46, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;s:4:"true";i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;b:0;i:46;s:4:"true";i:47;b:0;i:48;s:4:"true";i:49;b:0;i:50;b:0;i:51;b:0;i:52;b:0;i:53;b:0;}', ''),
(24, 'kris1', 'privet099', 'kristian', 'Korepanov', 'default-user.png', 52, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;s:4:"true";i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;b:0;}', ''),
(25, 'cosm211', 'Atikin105', 'Никита', 'Усманов', 'default-user.png', 51, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;b:0;i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;b:0;}', ''),
(26, 'memdunyan', 'egor12', 'Станислав', 'Медунов', 'default-user.png', 23, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;b:0;i:22;s:4:"true";i:23;s:4:"true";i:24;b:0;i:25;s:4:"true";i:26;b:0;i:27;b:0;i:28;b:0;i:29;b:0;i:30;b:0;i:31;b:0;i:32;b:0;i:33;b:0;i:34;b:0;i:35;b:0;i:36;b:0;i:37;b:0;i:38;b:0;i:39;b:0;i:40;b:0;i:41;b:0;i:42;b:0;i:43;b:0;i:44;b:0;i:45;b:0;i:46;b:0;i:47;b:0;i:48;b:0;i:49;b:0;i:50;b:0;i:51;b:0;i:52;b:0;i:53;b:0;}', ''),
(27, 'KROT', 'gogi', 'Николай', 'Борсук', 'default-user.png', 51, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;b:0;i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;b:0;}', ''),
(28, 'allax_edin', 'Bebubo48', 'Костя', 'Илле', 'default-user.png', 53, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;s:4:"true";i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;s:4:"true";}', ''),
(29, 'AcuteSoul', 'PHaNToMMmm222', 'Дмитрий', 'Кафтан', '01acb64782a4.png', 53, 'a:54:{i:0;s:4:"true";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:4:"true";i:17;s:4:"true";i:18;s:4:"true";i:19;s:4:"true";i:20;s:4:"true";i:21;s:4:"true";i:22;s:4:"true";i:23;s:4:"true";i:24;s:4:"true";i:25;s:4:"true";i:26;s:4:"true";i:27;s:4:"true";i:28;s:4:"true";i:29;s:4:"true";i:30;s:4:"true";i:31;s:4:"true";i:32;s:4:"true";i:33;s:4:"true";i:34;s:4:"true";i:35;s:4:"true";i:36;s:4:"true";i:37;s:4:"true";i:38;s:4:"true";i:39;s:4:"true";i:40;s:4:"true";i:41;b:0;i:42;s:4:"true";i:43;s:4:"true";i:44;s:4:"true";i:45;s:4:"true";i:46;s:4:"true";i:47;s:4:"true";i:48;s:4:"true";i:49;s:4:"true";i:50;s:4:"true";i:51;s:4:"true";i:52;s:4:"true";i:53;s:4:"true";}', ''),
(30, 'SDMY', 'sdmy', 'Марк', 'Чаплыгин', 'default-user.png', 14, 'a:54:{i:0;s:5:"false";i:1;s:4:"true";i:2;s:4:"true";i:3;s:4:"true";i:4;s:4:"true";i:5;s:4:"true";i:6;s:4:"true";i:7;s:4:"true";i:8;s:4:"true";i:9;s:4:"true";i:10;s:4:"true";i:11;s:4:"true";i:12;s:4:"true";i:13;s:4:"true";i:14;s:4:"true";i:15;s:4:"true";i:16;s:5:"false";i:17;s:5:"false";i:18;s:5:"false";i:19;s:5:"false";i:20;s:5:"false";i:21;s:5:"false";i:22;s:5:"false";i:23;s:5:"false";i:24;s:5:"false";i:25;s:5:"false";i:26;s:5:"false";i:27;s:5:"false";i:28;s:5:"false";i:29;s:5:"false";i:30;s:5:"false";i:31;s:5:"false";i:32;s:5:"false";i:33;s:5:"false";i:34;s:5:"false";i:35;s:5:"false";i:36;s:5:"false";i:37;s:5:"false";i:38;s:5:"false";i:39;s:5:"false";i:40;s:5:"false";i:41;s:5:"false";i:42;s:5:"false";i:43;s:5:"false";i:44;s:5:"false";i:45;s:5:"false";i:46;s:5:"false";i:47;s:5:"false";i:48;s:5:"false";i:49;s:5:"false";i:50;s:5:"false";i:51;s:5:"false";i:52;s:5:"false";i:53;s:5:"false";}', ''),
(31, 'admin', '1234', 'admin', 'admin', '9nXWIO87KfM.jpg', 1, 'a:54:{i:0;b:0;i:1;s:16:"select * from pc";i:2;b:0;i:3;b:0;i:4;b:0;i:5;b:0;i:6;b:0;i:7;b:0;i:8;b:0;i:9;b:0;i:10;b:0;i:11;b:0;i:12;b:0;i:13;b:0;i:14;b:0;i:15;b:0;i:16;b:0;i:17;b:0;i:18;b:0;i:19;b:0;i:20;b:0;i:21;b:0;i:22;b:0;i:23;b:0;i:24;b:0;i:25;b:0;i:26;b:0;i:27;b:0;i:28;b:0;i:29;b:0;i:30;b:0;i:31;b:0;i:32;b:0;i:33;b:0;i:34;b:0;i:35;b:0;i:36;b:0;i:37;b:0;i:38;b:0;i:39;b:0;i:40;b:0;i:41;b:0;i:42;b:0;i:43;b:0;i:44;b:0;i:45;b:0;i:46;b:0;i:47;b:0;i:48;b:0;i:49;b:0;i:50;b:0;i:51;b:0;i:52;b:0;i:53;b:0;}', ''),
(33, 'petr97', '1234567890', 'Петр', 'Арестов', 'img0.jpg', 1, 'a:54:{i:0;b:0;i:1;s:16:"select * from pc";i:2;b:0;i:3;b:0;i:4;b:0;i:5;b:0;i:6;b:0;i:7;b:0;i:8;b:0;i:9;b:0;i:10;b:0;i:11;b:0;i:12;b:0;i:13;b:0;i:14;b:0;i:15;b:0;i:16;b:0;i:17;b:0;i:18;b:0;i:19;b:0;i:20;b:0;i:21;b:0;i:22;b:0;i:23;b:0;i:24;b:0;i:25;b:0;i:26;b:0;i:27;b:0;i:28;b:0;i:29;b:0;i:30;b:0;i:31;b:0;i:32;b:0;i:33;b:0;i:34;b:0;i:35;b:0;i:36;b:0;i:37;b:0;i:38;b:0;i:39;b:0;i:40;b:0;i:41;b:0;i:42;b:0;i:43;b:0;i:44;b:0;i:45;b:0;i:46;b:0;i:47;b:0;i:48;b:0;i:49;b:0;i:50;b:0;i:51;b:0;i:52;b:0;i:53;b:0;}', ''),
(38, 'test12345', '1234', 'test', 'test', 'default-user.png', 0, 'a:54:{i:0;b:0;i:1;b:0;i:2;b:0;i:3;b:0;i:4;b:0;i:5;b:0;i:6;b:0;i:7;b:0;i:8;b:0;i:9;b:0;i:10;b:0;i:11;b:0;i:12;b:0;i:13;b:0;i:14;b:0;i:15;b:0;i:16;b:0;i:17;b:0;i:18;b:0;i:19;b:0;i:20;b:0;i:21;b:0;i:22;b:0;i:23;b:0;i:24;b:0;i:25;b:0;i:26;b:0;i:27;b:0;i:28;b:0;i:29;b:0;i:30;b:0;i:31;b:0;i:32;b:0;i:33;b:0;i:34;b:0;i:35;b:0;i:36;b:0;i:37;b:0;i:38;b:0;i:39;b:0;i:40;b:0;i:41;b:0;i:42;b:0;i:43;b:0;i:44;b:0;i:45;b:0;i:46;b:0;i:47;b:0;i:48;b:0;i:49;b:0;i:50;b:0;i:51;b:0;i:52;b:0;i:53;b:0;}', ''),
(39, 'test12345', '1234', 'test', 'test', 'default-user.png', 0, 'a:54:{i:0;b:0;i:1;b:0;i:2;b:0;i:3;b:0;i:4;b:0;i:5;b:0;i:6;b:0;i:7;b:0;i:8;b:0;i:9;b:0;i:10;b:0;i:11;b:0;i:12;b:0;i:13;b:0;i:14;b:0;i:15;b:0;i:16;b:0;i:17;b:0;i:18;b:0;i:19;b:0;i:20;b:0;i:21;b:0;i:22;b:0;i:23;b:0;i:24;b:0;i:25;b:0;i:26;b:0;i:27;b:0;i:28;b:0;i:29;b:0;i:30;b:0;i:31;b:0;i:32;b:0;i:33;b:0;i:34;b:0;i:35;b:0;i:36;b:0;i:37;b:0;i:38;b:0;i:39;b:0;i:40;b:0;i:41;b:0;i:42;b:0;i:43;b:0;i:44;b:0;i:45;b:0;i:46;b:0;i:47;b:0;i:48;b:0;i:49;b:0;i:50;b:0;i:51;b:0;i:52;b:0;i:53;b:0;}', ''),
(40, 'test12345', '1234', 'test', 'test', 'default-user.png', 0, 'a:54:{i:0;b:0;i:1;b:0;i:2;b:0;i:3;b:0;i:4;b:0;i:5;b:0;i:6;b:0;i:7;b:0;i:8;b:0;i:9;b:0;i:10;b:0;i:11;b:0;i:12;b:0;i:13;b:0;i:14;b:0;i:15;b:0;i:16;b:0;i:17;b:0;i:18;b:0;i:19;b:0;i:20;b:0;i:21;b:0;i:22;b:0;i:23;b:0;i:24;b:0;i:25;b:0;i:26;b:0;i:27;b:0;i:28;b:0;i:29;b:0;i:30;b:0;i:31;b:0;i:32;b:0;i:33;b:0;i:34;b:0;i:35;b:0;i:36;b:0;i:37;b:0;i:38;b:0;i:39;b:0;i:40;b:0;i:41;b:0;i:42;b:0;i:43;b:0;i:44;b:0;i:45;b:0;i:46;b:0;i:47;b:0;i:48;b:0;i:49;b:0;i:50;b:0;i:51;b:0;i:52;b:0;i:53;b:0;}', ''),
(41, 'test12345', '1234', 'test', 'test', 'default-user.png', 0, 'a:54:{i:0;b:0;i:1;b:0;i:2;b:0;i:3;b:0;i:4;b:0;i:5;b:0;i:6;b:0;i:7;b:0;i:8;b:0;i:9;b:0;i:10;b:0;i:11;b:0;i:12;b:0;i:13;b:0;i:14;b:0;i:15;b:0;i:16;b:0;i:17;b:0;i:18;b:0;i:19;b:0;i:20;b:0;i:21;b:0;i:22;b:0;i:23;b:0;i:24;b:0;i:25;b:0;i:26;b:0;i:27;b:0;i:28;b:0;i:29;b:0;i:30;b:0;i:31;b:0;i:32;b:0;i:33;b:0;i:34;b:0;i:35;b:0;i:36;b:0;i:37;b:0;i:38;b:0;i:39;b:0;i:40;b:0;i:41;b:0;i:42;b:0;i:43;b:0;i:44;b:0;i:45;b:0;i:46;b:0;i:47;b:0;i:48;b:0;i:49;b:0;i:50;b:0;i:51;b:0;i:52;b:0;i:53;b:0;}', '');

-- --------------------------------------------------------

--
-- Структура таблицы `users_groups`
--

DROP TABLE IF EXISTS `users_groups`;
CREATE TABLE IF NOT EXISTS `users_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=33 ;

--
-- Дамп данных таблицы `users_groups`
--

INSERT INTO `users_groups` (`id`, `user_id`, `group_id`) VALUES
(1, 1, 0),
(2, 2, 2),
(3, 3, 2),
(4, 4, 2),
(5, 5, 2),
(6, 6, 2),
(7, 7, 2),
(8, 8, 2),
(9, 9, 2),
(10, 10, 2),
(11, 11, 2),
(12, 12, 2),
(13, 13, 2),
(14, 14, 2),
(15, 15, 2),
(16, 16, 2),
(17, 17, 2),
(18, 18, 2),
(19, 19, 2),
(20, 20, 2),
(21, 21, 2),
(22, 22, 2),
(23, 23, 2),
(24, 24, 2),
(25, 25, 2),
(26, 26, 2),
(27, 27, 2),
(28, 28, 2),
(29, 29, 2),
(30, 30, 1),
(31, 31, 2),
(32, 33, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `users_roles`
--

DROP TABLE IF EXISTS `users_roles`;
CREATE TABLE IF NOT EXISTS `users_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=65 ;

--
-- Дамп данных таблицы `users_roles`
--

INSERT INTO `users_roles` (`id`, `user_id`, `role_id`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 2),
(5, 5, 2),
(6, 6, 2),
(7, 7, 2),
(8, 8, 2),
(9, 9, 2),
(10, 10, 2),
(11, 11, 2),
(12, 12, 2),
(13, 13, 2),
(14, 14, 2),
(15, 15, 2),
(16, 16, 2),
(17, 17, 2),
(18, 18, 2),
(19, 19, 2),
(20, 20, 2),
(21, 21, 2),
(22, 22, 2),
(23, 23, 2),
(24, 24, 2),
(25, 25, 2),
(26, 26, 2),
(27, 27, 2),
(28, 28, 2),
(29, 29, 2),
(30, 30, 2),
(31, 31, 2),
(32, 33, 2),
(64, 2, 2);

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `laptop`
--
ALTER TABLE `laptop`
  ADD CONSTRAINT `FK_Laptop_product` FOREIGN KEY (`model`) REFERENCES `product` (`model`);

--
-- Ограничения внешнего ключа таблицы `pc`
--
ALTER TABLE `pc`
  ADD CONSTRAINT `FK_pc_product` FOREIGN KEY (`model`) REFERENCES `product` (`model`);

--
-- Ограничения внешнего ключа таблицы `printer`
--
ALTER TABLE `printer`
  ADD CONSTRAINT `FK_printer_product` FOREIGN KEY (`model`) REFERENCES `product` (`model`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
