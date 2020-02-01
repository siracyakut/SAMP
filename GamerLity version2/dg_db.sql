-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 01 Şub 2020, 01:28:43
-- Sunucu sürümü: 10.4.11-MariaDB
-- PHP Sürümü: 7.4.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `dg`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `adminler`
--

CREATE TABLE `adminler` (
  `kullaniciadi` varchar(25) COLLATE utf8_turkish_ci NOT NULL,
  `sifre` varchar(25) COLLATE utf8_turkish_ci NOT NULL,
  `yetki` int(25) NOT NULL,
  `dogrulama` varchar(500) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `arkadaslar`
--

CREATE TABLE `arkadaslar` (
  `ID` int(11) NOT NULL,
  `arkadas` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `kullanici` varchar(50) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `atmler`
--

CREATE TABLE `atmler` (
  `ID` int(11) NOT NULL,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `F` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `atmler`
--

INSERT INTO `atmler` (`ID`, `X`, `Y`, `Z`, `F`) VALUES
(0, 1987.51, 959.072, 10.8203, 92.5684),
(1, 287.186, 2012.88, 17.6406, 92.6605),
(2, -2352.1, -27.1423, 35.3203, 184.074),
(3, 2506.8, 2065.18, 10.8203, 0.815893),
(4, 1287.81, -1643.48, 13.5469, 91.37),
(5, -1571.36, 668.427, 7.1875, 92.9995),
(6, -2880.5, 481.644, 4.91406, 90.9154);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `banlog`
--

CREATE TABLE `banlog` (
  `ip` varchar(16) COLLATE utf8_turkish_ci NOT NULL,
  `player` varchar(25) COLLATE utf8_turkish_ci NOT NULL,
  `times` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `aktif` int(50) NOT NULL DEFAULT 1,
  `sebep` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `admin` varchar(500) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bitcoin_satim`
--

CREATE TABLE `bitcoin_satim` (
  `ID` int(11) NOT NULL,
  `miktar` int(11) NOT NULL,
  `satici` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `fiyat` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bolgeler`
--

CREATE TABLE `bolgeler` (
  `bolgeid` int(11) NOT NULL,
  `bolgeisim` varchar(30) COLLATE utf8_turkish_ci NOT NULL,
  `sahipceteid` int(11) NOT NULL DEFAULT -1,
  `sahipname` varchar(30) COLLATE utf8_turkish_ci NOT NULL DEFAULT 'Yok',
  `bolgeseviye` int(3) NOT NULL DEFAULT 1,
  `bolgerenk` int(11) NOT NULL DEFAULT 2,
  `bolgex` float NOT NULL,
  `bolgey` float NOT NULL,
  `bolgez` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `bolgeler`
--

INSERT INTO `bolgeler` (`bolgeid`, `bolgeisim`, `sahipceteid`, `sahipname`, `bolgeseviye`, `bolgerenk`, `bolgex`, `bolgey`, `bolgez`) VALUES
(1, 'Isimsiz Bolge', -1, 'Yok', 1, 3, 2583.09, 2276.56, 10.8203),
(2, 'Isimsiz Bolge', -1, 'Yok', 1, 4, 2376.11, 2319.5, 8.14062),
(3, 'Isimsiz Bolge', -1, 'Yok', 1, 4, 2176.02, 1992.09, 10.8203),
(4, 'Isimsiz Bolge', -1, 'Yok', 1, 3, 2564.88, 2751.8, 10.4799),
(5, 'Isimsiz Bolge', -1, 'Yok', 1, 3, 2758.38, 2534.16, 10.4814),
(6, 'Isimsiz Bolge', -1, 'Yok', 1, 4, 1484.83, 2772.1, 10.4793),
(7, 'Isimsiz Bolge', -1, 'Yok', 1, 4, 1502.25, 2195.79, 10.4787),
(8, 'Isimsiz Bolge', -1, 'Yok', 1, 3, 1085.46, 1079.36, 10.496),
(9, 'Isimsiz Bolge', -1, 'Yok', 1, 4, 1142.43, 1312.54, 10.4799),
(10, 'Isimsiz Bolge', -1, 'Yok', 1, 4, 1427.06, 750.852, 10.4803),
(11, 'Isimsiz Bolge', -1, 'Yok', 1, 4, 2824.57, 953.888, 10.4092),
(12, 'Isimsiz Bolge', -1, 'Yok', 1, 1, 1052.67, 2174.39, 10.4809),
(14, 'Isimsiz Bolge', -1, 'Yok', 1, 3, 212.682, 1912.89, 17.3016),
(15, 'Isimsiz Bolge', -1, 'Yok', 1, 4, -526.72, 2590.13, 53.4154),
(16, 'Isimsiz Bolge', -1, 'Yok', 1, 4, -2260.41, 2309.39, 4.4758),
(17, 'Isimsiz Bolge', -1, 'Yok', 1, 4, 198.355, 1432.22, 10.2436),
(18, 'Isimsiz Bolge', -1, 'Yok', 1, 1, -542.541, -88.8897, 62.8875),
(19, 'Isimsiz Bolge', -1, 'Yok', 1, 4, -61.5403, 48.9115, 2.76782),
(20, 'Isimsiz Bolge', -1, 'Yok', 1, 4, -29.802, -311.94, 5.08475),
(21, 'Isimsiz Bolge', -1, 'Yok', 1, 4, -541.627, -492.708, 25.1798),
(22, 'Isimsiz Bolge', -1, 'Yok', 1, 4, -1019.58, -659.359, 31.6656),
(23, 'Isimsiz Bolge', -1, 'Yok', 1, 4, 1929.29, 171.857, 36.9396),
(24, 'Isimsiz Bolge', -1, 'Yok', 1, 1, 1497.55, -695.705, 94.4087),
(25, 'Isimsiz Bolge', -1, 'Yok', 1, 3, 682.893, -1275.47, 13.2309),
(26, 'Isimsiz Bolge', -1, 'Yok', 1, 3, 1787.45, -1909.86, 13.0543),
(27, 'Isimsiz Bolge', -1, 'Yok', 1, 3, 2783.77, -2456.59, 13.2941),
(28, 'Isimsiz Bolge', -1, 'Yok', 1, 3, 1970.39, -1157.2, 20.6163),
(30, 'Isimsiz Bolge', -1, 'Yok', 1, 3, 2801.81, -1090.68, 30.382),
(31, 'Isimsiz Bolge', -1, 'Yok', 1, 3, 1130.57, -1463.2, 15.4478),
(32, 'Isimsiz Bolge', -1, 'Yok', 1, 3, 232.155, -1842.51, 3.01445),
(33, 'Isimsiz Bolge', -1, 'Yok', 1, 4, -56.4337, -1137.61, 0.739569),
(34, 'Isimsiz Bolge', -1, 'Yok', 1, 3, -377.835, -1432.68, 25.3839),
(35, 'Isimsiz Bolge', -1, 'Yok', 1, 4, -1112.32, -1652.35, 76.0248),
(36, 'Isimsiz Bolge', -1, 'Yok', 1, 4, -1428.47, -1517.33, 101.403),
(37, 'Isimsiz Bolge', -1, 'Yok', 1, 4, -1834.08, -1653.92, 21.4079),
(38, 'Isimsiz Bolge', -1, 'Yok', 1, 3, -1268.55, 459.156, 6.84417),
(39, 'Isimsiz Bolge', -1, 'Yok', 1, 4, -1589.9, 83.9039, 3.21469),
(40, 'Isimsiz Bolge', -1, 'Yok', 1, 1, -2661.45, 610.191, 14.4531),
(41, 'Isimsiz Bolge', -1, 'Yok', 1, 1, 2336.07, -1226.04, 27.9766),
(42, 'Isimsiz Bolge', -1, 'Yok', 1, 1, 2597.15, 1824.05, 10.3816);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `bugraporlog`
--

CREATE TABLE `bugraporlog` (
  `BUGRAPOR_ID` int(11) NOT NULL,
  `gonderen` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `mesaj` varchar(2048) COLLATE utf8_turkish_ci NOT NULL,
  `tarih` varchar(500) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `ceteler`
--

CREATE TABLE `ceteler` (
  `ID` int(11) NOT NULL,
  `Isim` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `Tag` varchar(7) COLLATE utf8_turkish_ci NOT NULL,
  `Renk` int(11) NOT NULL,
  `Kasa` int(11) NOT NULL,
  `Skin` int(11) NOT NULL,
  `Level` int(11) NOT NULL,
  `EXP` int(11) NOT NULL,
  `cetebolgesayisi` int(11) NOT NULL DEFAULT 0,
  `uyesayisi` int(11) NOT NULL,
  `Mekan` int(11) NOT NULL DEFAULT -1,
  `Rank1` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `Rank2` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `Rank3` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `Rank4` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `Rank5` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `Rank6` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `Rank7` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `Rank8` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `Rank9` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `Rank10` varchar(50) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `cetemekanlari`
--

CREATE TABLE `cetemekanlari` (
  `ID` int(11) NOT NULL,
  `sahipcete` int(11) NOT NULL DEFAULT -1,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `fiyat` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `cetemekanlari`
--

INSERT INTO `cetemekanlari` (`ID`, `sahipcete`, `X`, `Y`, `Z`, `fiyat`) VALUES
(0, -1, -1642.44, 1203.11, 7.25323, 2500000),
(1, -1, 2463.91, 2034.1, 11.0625, 2500000),
(2, -1, -2429.3, -2795.03, 3, 20000000),
(3, -1, 1080.42, -780.565, 106.858, 5000000),
(4, -1, 2176.81, 1136.11, 12.6018, 1000000),
(5, -1, 2846.57, -2049.19, 10.9232, 5000000),
(6, -1, 248.341, -1263.51, 69.6434, 5000000),
(7, -1, -2794.69, -1529.08, 139.269, 2000000),
(8, -1, -2127.36, -2440.32, 30.625, 4000000),
(9, -1, -2642.36, 1356.09, 7.15294, 10000000),
(10, -1, 2192.7, 1676.96, 12.3672, 10000000),
(11, -1, -2042.03, -97.6225, 35.1641, 5000000),
(12, -1, -546.715, 2588.48, 53.5156, 20000000);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `chatlog`
--

CREATE TABLE `chatlog` (
  `LOG_ID` int(11) NOT NULL,
  `gonderen` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `mesaj` varchar(2048) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `dukkanlar`
--

CREATE TABLE `dukkanlar` (
  `ID` int(11) NOT NULL,
  `sahip` int(11) NOT NULL DEFAULT -1,
  `X` float NOT NULL,
  `Y` float NOT NULL,
  `Z` float NOT NULL,
  `fiyat` int(11) NOT NULL,
  `birikenpara` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `dukkanlar`
--

INSERT INTO `dukkanlar` (`ID`, `sahip`, `X`, `Y`, `Z`, `fiyat`, `birikenpara`) VALUES
(0, -1, -1661.27, 1227.91, 7.17969, 1000000, 0),
(1, -1, -1665.68, 1234.57, 7.17969, 1000000, 0),
(2, -1, -1671.89, 1241.18, 7.1875, 1000000, 0),
(3, -1, -1678.31, 1245.36, 7.17969, 1000000, 0),
(4, -1, -1685.29, 1251.48, 7.17969, 1000000, 0),
(5, -1, -1695.2, 1253.73, 7.20011, 1000000, 0),
(6, -1, -1700.95, 1259.14, 7.19777, 1000000, 0),
(7, -1, -1706.83, 1265.04, 7.19787, 1000000, 0),
(8, -1, -1712.79, 1271.01, 7.19797, 1000000, 0),
(9, -1, -1718.6, 1276.83, 7.19807, 1000000, 0),
(10, -1, 1284.75, -1584.68, 13.5469, 1000000, 0),
(11, -1, 1258.23, -1583.17, 13.5469, 1000000, 0),
(12, -1, 1238.44, -1583.29, 13.4731, 1000000, 0),
(13, -1, 1217.64, -1583.42, 13.5469, 1000000, 0),
(14, -1, 1183.42, -1583.65, 13.5531, 1000000, 0),
(15, -1, 1163.05, -1584.72, 13.5469, 1000000, 0),
(16, -1, 1160.88, -1601.4, 13.5469, 1000000, 0),
(17, -1, -1581.04, 948.504, 7.1875, 1000000, 0),
(18, -1, -1581.78, 955.786, 7.1875, 1000000, 0),
(19, -1, -1584.19, 963.15, 7.1875, 1000000, 0),
(20, -1, -1588.51, 970.313, 7.19527, 1000000, 0),
(21, -1, -1592.4, 976.441, 7.19527, 1000000, 0),
(22, -1, -1597.7, 983.707, 7.19527, 1000000, 0),
(23, -1, -1602.82, 989.235, 7.1875, 1000000, 0),
(24, -1, -1608.22, 996.971, 7.19017, 1000000, 0),
(25, -1, -1611.91, 1002.59, 7.1875, 1000000, 0),
(26, -1, -1618.11, 1012.04, 7.1875, 2000000, 0),
(27, -1, -1618.79, 1019.53, 7.1875, 2000000, 0),
(28, -1, -1619.01, 1026.98, 7.1875, 2000000, 0),
(29, -1, -1618.52, 1035.33, 7.1875, 2000000, 0),
(30, -1, -1618.72, 1042.56, 7.1875, 2000000, 0),
(31, -1, -1617.67, 1051, 7.1875, 2000000, 0),
(32, -1, -1618.67, 1057.91, 7.1875, 2000000, 0),
(33, -1, -1618.04, 1065.86, 7.1875, 2000000, 0),
(34, -1, -1618.15, 1074.52, 7.1875, 2000000, 0),
(35, -1, -1618.42, 1082.46, 7.1875, 2000000, 0),
(36, -1, -1616.17, 1097.6, 7.1875, 1000000, 0),
(37, -1, -1615.78, 1106.28, 7.1875, 1000000, 0),
(38, -1, -1616.44, 1113.82, 7.1875, 1000000, 0),
(39, -1, -1616.24, 1122.23, 7.1875, 1000000, 0),
(40, -1, -1615.66, 1130.69, 7.1875, 1000000, 0),
(41, -1, -1615.43, 1139.21, 7.1875, 1000000, 0),
(42, -1, -1615.86, 1147.21, 7.1875, 1000000, 0),
(43, -1, -1616.11, 1155.25, 7.17969, 1000000, 0),
(44, -1, -1619.01, 1163.52, 7.1875, 1000000, 0),
(45, -1, -1627.36, 1170.25, 7.1875, 1000000, 0),
(46, -1, -1641.46, 1205.36, 7.2508, 3000000, 0),
(47, -1, -1910.96, 829.595, 35.1719, 2000000, 0),
(48, -1, -1882.01, 823.291, 35.1762, 3000000, 0),
(49, -1, -1884.53, 863.109, 35.1719, 3000000, 0),
(50, -1, -1953.98, 827.022, 42.5286, 1000000, 0),
(51, -1, -1963.17, 826.035, 44.1991, 1000000, 0),
(52, -1, -1984.84, 826.505, 45.4453, 1000000, 0),
(53, -1, 1931.92, 1345.54, 9.96875, 20000000, 0),
(54, -1, -1968.42, 294.397, 35.1719, 3000000, 0),
(55, -1, 2392.33, 2044.99, 10.8203, 5000000, 0),
(56, -1, 2409.91, 2017.44, 10.8203, 5000000, 0),
(57, -1, 2408.94, 1997.21, 10.8203, 5000000, 0),
(58, -1, 2367.46, 1982.46, 10.8203, 5000000, 0),
(59, -1, 2189.19, 1990.27, 10.8203, 5000000, 0),
(60, -1, 2029.18, 1007.98, 10.8282, 50000000, 0),
(61, -1, 2089.12, 1449.53, 10.8203, 10000000, 0),
(62, -1, 2332.6, 2164.1, 10.8249, 10000000, 0),
(63, -1, 954.427, -1047.39, 30.2422, 5000000, 0),
(64, -1, 953.511, -1022.52, 31.603, 5000000, 0),
(65, -1, 2371.65, 2167.9, 10.3843, 10000000, 0),
(66, -1, 2540.77, 2161.42, 10.3846, 10000000, 0),
(67, -1, 2127.91, 2376.46, 10.8203, 100000000, 0),
(68, -1, 2538.87, 2149.91, 10.3846, 10000000, 0),
(69, -1, 2557.34, 2103.77, 10.3846, 10000000, 0),
(70, -1, 2563.6, 1442.59, 10.3837, 10000000, 0),
(71, -1, 2513.45, 1322.42, 10.3912, 10000000, 0),
(72, -1, 2505.3, 1322.96, 10.3835, 10000000, 0),
(73, -1, 2494.64, 1323.66, 10.3852, 10000000, 0),
(74, -1, 2484.99, 1322.77, 10.3848, 10000000, 0),
(75, -1, 2549.16, 1302.66, 10.3797, 10000000, 0),
(76, -1, -2430.01, 20.0267, 35.2434, 5000000, 0),
(77, -1, -2434.36, 30.1686, 34.9534, 5000000, 0),
(78, -1, -2444.37, 30.1709, 34.2975, 5000000, 0),
(79, -1, -2450.66, 32.3834, 33.8848, 5000000, 0),
(80, -1, -2458.3, 32.2978, 32.7448, 5000000, 0),
(81, -1, -2464.54, 32.4354, 31.7707, 5000000, 0),
(82, -1, -2492.43, 29.2349, 25.6139, 5000000, 0),
(83, -1, -2509.83, 26.1587, 25.6314, 5000000, 0),
(84, -1, -2508.13, 11.8258, 25.7477, 5000000, 0),
(85, -1, -2492.74, -5.33466, 25.7656, 5000000, 0),
(86, -1, -2492.75, -16.7686, 25.7656, 5000000, 0),
(87, -1, -2493.01, -28.5559, 25.7656, 5000000, 0),
(88, -1, -2493.85, -38.5365, 25.7656, 5000000, 0),
(89, -1, -2492.76, -47.2381, 25.7116, 5000000, 0),
(90, -1, -2493.18, -56.2943, 25.6352, 5000000, 0),
(91, -1, -2510.3, -50.3931, 25.6799, 10000000, 0),
(92, -1, -2492.75, -89.9412, 25.6172, 10000000, 0),
(93, -1, -2492.91, -108.832, 25.6172, 10000000, 0),
(94, -1, -2493, -142.316, 25.6094, 5000000, 0),
(95, -1, -2492.46, -153.858, 25.6094, 5000000, 0),
(96, -1, -2430.16, -182.112, 34.8852, 5000000, 0),
(97, -1, -2438.74, -196.965, 34.8909, 5000000, 0),
(98, -1, -2429.15, -156.259, 34.884, 5000000, 0),
(99, -1, -2428.91, -147.294, 34.8689, 5000000, 0),
(100, -1, -2428.9, -128.073, 34.8925, 5000000, 0),
(101, -1, -2428.1, -110.937, 34.8831, 5000000, 0),
(102, -1, -2428.51, -94.9976, 34.8838, 5000000, 0),
(103, -1, -2428.73, -83.7267, 34.8903, 5000000, 0),
(104, -1, -2433.28, -62.5427, 34.7242, 5000000, 0),
(105, -1, -2428.93, -52.7257, 34.8731, 5000000, 0),
(106, -1, -2428.62, -42.7214, 34.8821, 5000000, 0),
(107, -1, -2433.69, 48.4693, 34.5567, 5000000, 0),
(108, -1, -2428.66, 66.5291, 34.7448, 5000000, 0),
(109, -1, 2268.33, 962.529, 10.3781, 5000000, 0),
(110, -1, 2259.71, 963.722, 10.3856, 5000000, 0),
(111, -1, 2249.99, 964.092, 10.3823, 5000000, 0),
(112, -1, 2238.46, 964.202, 10.3838, 5000000, 0),
(113, -1, 2176.98, 965.201, 10.3819, 15000000, 0),
(114, -1, 2155.59, 941.774, 10.3915, 15000000, 0),
(115, -1, 2139.06, 954.849, 10.3134, 20000000, 0),
(116, -1, -1493.79, 920.238, 6.749, 20000000, 0),
(117, -1, -2509.79, -101.906, 25.6172, 5000000, 0),
(118, -1, -2510.18, -94.2035, 25.6172, 5000000, 0),
(119, -1, -2509.31, -85.5137, 25.6172, 5000000, 0),
(120, -1, -2515.34, -78.4582, 24.3152, 5000000, 0),
(121, -1, -2523, -79.0197, 21.8882, 5000000, 0),
(122, -1, -2531.74, -79.1484, 19.1245, 5000000, 0),
(123, -1, -2541.96, -79.4194, 15.9009, 5000000, 0),
(124, -1, 1238, -7767.32, 15.6486, 5000000, 0),
(125, -1, 1238.04, -7781.72, 15.6457, 5000000, 0),
(126, -1, 1237.94, -7802.22, 15.647, 5000000, 0),
(127, -1, 1237.41, -7820.71, 15.6455, 5000000, 0),
(128, -1, 1238.32, -7839.84, 15.649, 5000000, 0),
(129, -1, 1238.88, -7865.09, 15.6449, 1000000, 0),
(130, -1, 1238.91, -7873.11, 15.6493, 1000000, 0),
(131, -1, 1238.94, -7881.19, 15.6455, 1000000, 0),
(132, -1, 1238.98, -7889.71, 15.6492, 1000000, 0),
(133, -1, 1238.14, -7906.92, 15.6624, 1000000, 0),
(134, -1, 1238.4, -7916.14, 15.6475, 1000000, 0),
(135, -1, 1238.52, -7924.67, 15.6458, 1000000, 0),
(136, -1, 1238.63, -7932.01, 15.6454, 1000000, 0),
(137, -1, 1238.31, -7949.97, 15.66, 1000000, 0),
(138, -1, 1238, -7959.3, 15.6489, 1000000, 0),
(139, -1, 1238.06, -7967.2, 15.6489, 1000000, 0),
(140, -1, 1237.97, -7975.36, 15.648, 1000000, 0),
(141, -1, 1238.28, -7989.31, 15.657, 1000000, 0),
(142, -1, 1238.33, -7997.51, 15.647, 1000000, 0),
(143, -1, 1238.37, -8003.74, 15.6489, 1000000, 0),
(144, -1, 1238.44, -8014.06, 15.6568, 1000000, 0),
(145, -1, 1238.5, -8023.89, 15.6583, 10000000, 0),
(146, -1, 1238.55, -8031.81, 15.6576, 10000000, 0),
(147, -1, 1238.61, -8041.03, 15.6474, 10000000, 0),
(148, -1, 834.602, -7520.33, 16.565, 1000000000, 0),
(149, -1, 811.635, -7543.03, 17.863, 100000000, 0),
(150, -1, 859.896, -7543.35, 17.8636, 100000000, 0),
(151, -1, 842.572, -7606.31, 15.7458, 1000000, 0);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `etklog`
--

CREATE TABLE `etklog` (
  `animator` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `etk` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `zaman` varchar(500) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `jaillog`
--

CREATE TABLE `jaillog` (
  `oyuncu` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `admin` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `zaman` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `sebep` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `dk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `kicklog`
--

CREATE TABLE `kicklog` (
  `oyuncu` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `admin` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `sebep` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `tarih` varchar(500) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `nbanlog`
--

CREATE TABLE `nbanlog` (
  `oyuncu` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `ip` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `admin` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `sebep` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `zaman` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `sure` bigint(255) NOT NULL,
  `sure2` bigint(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `onerilog`
--

CREATE TABLE `onerilog` (
  `ONERI_ID` int(11) NOT NULL,
  `gonderen` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `mesaj` varchar(2048) COLLATE utf8_turkish_ci NOT NULL,
  `tarih` varchar(500) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `oyuncular`
--

CREATE TABLE `oyuncular` (
  `sqlid` int(11) NOT NULL,
  `kullaniciadi` varchar(24) COLLATE utf8_turkish_ci NOT NULL,
  `sifre` varchar(135) COLLATE utf8_turkish_ci NOT NULL,
  `money` int(11) NOT NULL,
  `Deaths` int(11) NOT NULL,
  `Kills` int(11) NOT NULL,
  `dLevel` int(11) NOT NULL,
  `Anim` int(11) NOT NULL DEFAULT 0,
  `CEO` int(11) NOT NULL DEFAULT 0,
  `score` int(11) NOT NULL,
  `LoggedIn` int(11) NOT NULL,
  `LastOn` varchar(50) COLLATE utf8_turkish_ci NOT NULL DEFAULT 'Yok',
  `RegisteredDate` varchar(50) COLLATE utf8_turkish_ci NOT NULL DEFAULT 'Yok',
  `TimesOnServer` int(11) NOT NULL,
  `bannedxd` int(11) NOT NULL,
  `Registered` int(11) NOT NULL DEFAULT 1,
  `Jailed` int(11) NOT NULL,
  `JailTime` int(11) NOT NULL,
  `IP` varchar(30) COLLATE utf8_turkish_ci NOT NULL DEFAULT 's',
  `pinfox` float NOT NULL,
  `pinfoy` float NOT NULL,
  `pinfoz` float NOT NULL,
  `onlinet` int(11) NOT NULL,
  `skinplayer` int(11) NOT NULL DEFAULT -1,
  `rengim` int(11) NOT NULL,
  `bannedtime` int(11) NOT NULL,
  `cete` int(11) NOT NULL DEFAULT -1,
  `ceterutbe` int(11) NOT NULL DEFAULT 0,
  `Serial` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `oyundaiste` int(11) NOT NULL,
  `mutesure` int(11) NOT NULL,
  `basari_ilkmesaj` int(11) NOT NULL,
  `basari_5hsatma` int(11) NOT NULL,
  `basari_etkkatil` int(11) NOT NULL,
  `headshotlar` int(11) NOT NULL DEFAULT 0,
  `dukkanivar` int(11) NOT NULL DEFAULT -1,
  `vehiclemod1` varchar(500) COLLATE utf8_turkish_ci NOT NULL DEFAULT '0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,-1,-1,0',
  `vehiclemod2` varchar(500) COLLATE utf8_turkish_ci NOT NULL DEFAULT '0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,-1,-1,0',
  `vehiclemod3` varchar(500) COLLATE utf8_turkish_ci NOT NULL DEFAULT '0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,-1,-1,0',
  `vehiclemod4` varchar(500) COLLATE utf8_turkish_ci NOT NULL DEFAULT '0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,-1,-1,0',
  `vehiclemod5` varchar(500) COLLATE utf8_turkish_ci NOT NULL DEFAULT '0,0,0,0,0,0,0,0,0,0,0,0,0,0,3,-1,-1,0',
  `yetki_ismi` varchar(500) COLLATE utf8_turkish_ci NOT NULL DEFAULT ' ',
  `VIP` int(11) NOT NULL DEFAULT 0,
  `VIP_Sure` int(11) NOT NULL DEFAULT 0,
  `cekilisgun` int(11) NOT NULL DEFAULT -1,
  `dukkanalimzaman` int(11) NOT NULL DEFAULT 0,
  `dukkansatimzaman` int(11) NOT NULL DEFAULT 0,
  `BitCoin` int(11) NOT NULL DEFAULT 0,
  `DaireIzin` int(11) NOT NULL DEFAULT 0,
  `EtkSayisi` int(11) NOT NULL DEFAULT 0,
  `basari_ilkarkadas` int(11) NOT NULL DEFAULT 0,
  `GunlukSpec` int(11) NOT NULL DEFAULT 0,
  `GunlukEtk` int(11) NOT NULL DEFAULT 0,
  `Kisisel_Durum` varchar(2048) COLLATE utf8_turkish_ci NOT NULL,
  `exp` int(11) NOT NULL DEFAULT 0,
  `seviye` int(11) DEFAULT 1,
  `maxexp` int(11) NOT NULL DEFAULT 150,
  `mute_` int(11) NOT NULL DEFAULT 0,
  `banka` int(11) NOT NULL DEFAULT 0,
  `ratio` int(11) NOT NULL DEFAULT 0,
  `GLKredi` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `pmlog`
--

CREATE TABLE `pmlog` (
  `PM_ID` int(11) NOT NULL,
  `gonderen` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `alici` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `mesaj` varchar(2048) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `sarkilar`
--

CREATE TABLE `sarkilar` (
  `ID` int(11) NOT NULL,
  `Isim` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `link` varchar(1024) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `sarkilar`
--

INSERT INTO `sarkilar` (`ID`, `Isim`, `link`) VALUES
(0, 'Sagopa Kajmer - 366.Gun', 'http://k003.kiwi6.com/hotlink/813d54vk46/Sagopa_Kajmer_-_366.G_n_-_from_YouTube.mp3'),
(1, 'Sagopa Kajmer - Sertlik Kaninda Var Hayatin', 'http://k003.kiwi6.com/hotlink/q2f3qscbny/Sagopa_Kajmer_-_Sertlik_Kan_nda_Var_Hayat_n_Official_Video_-_from_YouTube.mp3'),
(2, 'Kolera - Pespaye', 'http://k003.kiwi6.com/hotlink/vofm54lnou/Kolera_-_Pespaye_Video_Klip_-_from_YouTube.mp3'),
(3, 'Lariss - Dale Papi', 'http://k003.kiwi6.com/hotlink/3cqdb7xr0k/Lariss_-_Dale_Papi_Official_Video_-_from_YouTube.mp3'),
(4, 'Calvin Harris - Outside ft. Ellie Goulding', 'http://k003.kiwi6.com/hotlink/w8hou1k0ei/Calvin_Harris_feat._Ellie_Goulding_-_Outside_-_from_YouTube.mp3'),
(5, 'No.1 - Ciceklerde bir telas var', 'http://k003.kiwi6.com/hotlink/03s8vptmet/No.1_-_i_eklerde_bir_tela_var_official_video_-_from_YouTube.mp3'),
(6, 'Norm Ender - Kaktus', 'http://k003.kiwi6.com/hotlink/x2szj7wq56/Norm_Ender_-_Kakt_s_-_from_YouTube.mp3'),
(7, 'Radyo - HITPLAY', 'http://radyo.dogannet.tv/hitplay'),
(8, 'Radyo - RAP', 'http://radyo.dogannet.tv/turkrap'),
(9, 'Heijan feat Muti - Davay Davay (2017)', 'http://k003.kiwi6.com/hotlink/imx3pn6zeq/Heijan_feat_Muti_-_Davay_Davay_2017_-_from_YouTube.mp3'),
(10, 'Cagatay Akman - Sensin Benim En Derin Kuyum', 'http://k003.kiwi6.com/hotlink/z762fhx8lv/a_atay_Akman_-_Sensin_Benim_En_Derin_Kuyum_Official_Video_-_from_YouTube.mp3'),
(11, 'INNA - Gimmie Gimmie', 'http://k003.kiwi6.com/hotlink/zb3hscvdj6/INNA_-_Gimmie_Gimmie_-_Official_Music_Video_-_from_YouTube.mp3'),
(12, 'Bitti Artik Bu Sevda BERAT TOKSOZ (ft. Baris Kocak)', 'http://k003.kiwi6.com/hotlink/mrtsb3zxfw/Bitti_Art_k_Bu_Sevda_BERAT_TOKS_Z_ft._Bar_Ko_ak_s_zleri_asa_da_-_from_YouTube.mp3'),
(13, 'Kolera Feat. Sagopa Kajmer - Hircinlar', 'http://k003.kiwi6.com/hotlink/jk2csxgbfn/Kolera_Feat._Sagopa_Kajmer_-_H_r_nlar_-_from_YouTube.mp3'),
(14, 'Super Sako Mi Gna - ft: Hayko', 'http://k003.kiwi6.com/hotlink/yjft4wtvp6/Super_Sako_Ft_Spitakci_Hayko_-_Mi_Gna_-_from_YouTube.mp3'),
(15, 'BO - Unutursun', 'http://k003.kiwi6.com/hotlink/tpbdbd4710/B_-_Unutursun_1_.mp3'),
(16, 'Nigar Muharrem - Omzumda Aglayan Bir Sen', 'http://k003.kiwi6.com/hotlink/pvst7uwawf/Nigar_Muharrem_-_Omuzumda_Aglayan_Bir_Sen_Remix_.mp3'),
(17, 'Serhat Durmus - La Calin', 'http://k003.kiwi6.com/hotlink/9a4y9mg6bd/Serhat_Durmus_-_Le_C_lin_mp3cut.net_.mp3'),
(18, 'No Method - Let Me Go', 'http://k003.kiwi6.com/hotlink/k37jlqp433/No_Method_-_Let_Me_Go_Official_Lyric_Video_.mp3'),
(19, 'Alan Walker - Sing Me To Sleep', 'http://k003.kiwi6.com/hotlink/ftyhu0k1aw/Alan_Walker_-_Sing_Me_To_Sleep.mp3'),
(20, 'Nigar Muharrem - Ona Gore', 'http://k003.kiwi6.com/hotlink/8j3hcpjpbl/ALEDON_-_Nigar_MuharremOna_g_re_TRAP_2017.mp3'),
(21, 'Amorf - Belalim', 'http://k003.kiwi6.com/hotlink/h3ie3c44ne/Amorf_-_Belal_m.mp3'),
(22, 'Martin Garrix - Animals', 'http://k003.kiwi6.com/hotlink/0iu73cq9ez/Martin_Garrix_-_Animals_Official_Video_.mp3'),
(23, 'Furkan Soysal - Babylon', 'http://k003.kiwi6.com/hotlink/au7brldsrt/Furkan_Soysal_-_Babylon.mp3'),
(24, 'retron yava?', 'http://k003.kiwi6.com/hotlink/nxvj8rc4rp/RETRON_-_C_ER_M_S_KT_N.mp3'),
(25, 'Eypio', 'http://k003.kiwi6.com/hotlink/gfjq2fy9e3/Eypio_-_G_m_n_Beni_ukura_ukur_Dizi_M_zi_i_Official_Music_Video_.mp3'),
(26, 'ban ban çiki çiki ban', 'http://k003.kiwi6.com/hotlink/kuhls6rhl9/Ban_ban_iki_iki_ban_ban.mp3'),
(27, 'Tarkan-Yolla', 'http://k003.kiwi6.com/hotlink/qtcncqv6d3/Tarkan_-_Yolla.mp3'),
(28, 'ErikDal?-Remix', 'http://k003.kiwi6.com/hotlink/we0s7k4479/ER_K_DALI_2017_-_MER_FARUK_BOSTAN_-_OFFICIAL_REMIX.mp3'),
(29, 'Mihriban', 'http://k003.kiwi6.com/hotlink/90t35ubd9y/Musa_Ero_lu_Mihriban_1_.mp3'),
(30, 'BadBoysRmx', 'http://k003.kiwi6.com/hotlink/lyq24lxklf/Inner_Circle_-_Bad_Boys_Major_Lazer_x_Gianni_Marino_Remix_.mp3'),
(31, 'Furkansoysal midnight', 'http://k003.kiwi6.com/hotlink/kur02l7ziy/Furkan_Soysal_-_Midnight_Original_Mix_.mp3'),
(32, 'Vur Allah A?k?na Vur', 'http://k003.kiwi6.com/hotlink/zd1fd69ldl/VUR_ALLAH_A_KINA_VUR.mp3'),
(33, 'Olurum Turkiyem', 'http://k003.kiwi6.com/hotlink/ixfiy9gsmg/L_R_M_T_RK_YEM.mp3'),
(34, 'Serdar Ortaç - G?ybet', 'http://k003.kiwi6.com/hotlink/7fw0qcwijj/Serdar_Orta_-_G_ybet.mp3'),
(35, 'izmir mar??', 'http://k003.kiwi6.com/hotlink/pvb5faqaku/Fl_rt_-_zmir_Mar_.mp3'),
(36, 'Ali Ayseyi seviyor', 'http://k003.kiwi6.com/hotlink/pzw80ni4im/ali_k_n_k_ali_ay_eyi_seviyor.mp3'),
(37, 'Duyanlara Duymay', 'http://k003.kiwi6.com/hotlink/ndwhhxtucf/Halil_Sezai_-_Duyanlara_Duymayanlara_Official_Audio_.mp3'),
(38, 'Elfida', 'http://k003.kiwi6.com/hotlink/xvzekqkyta/Hozan_Be_ir_-_Elfida.mp3'),
(39, 'Üryan geldim', 'http://k003.kiwi6.com/hotlink/jmc3517tlw/Cem_Karaca_-_ryan_Geldim_1972_.mp3'),
(40, 'tanr?', 'http://kiwi6.com/file/ubucmbq3p3'),
(41, 'tanr?dagi', 'http://k003.kiwi6.com/hotlink/ubucmbq3p3/Tanr_Da_lar_ndan.mp3'),
(42, 'EthernosMusic', 'http://k003.kiwi6.com/hotlink/r5nchqwb7a/Mundian_To_Bach_Ke.mp3'),
(43, 'EthernosMusic', 'http://k003.kiwi6.com/hotlink/r5nchqwb7a/Mundian_To_Bach_Ke.mp3'),
(44, 'Karahisar Kalesi', 'http://k003.kiwi6.com/hotlink/qkdkh9u708/Karahisar_Kalesi.mp3'),
(45, 'Dont let medown', 'http://k003.kiwi6.com/hotlink/cazohd0kk3/Don_t_Let_Me_Down-_The_Chainsmokers_ft._Daya_Lyrics.mp3'),
(46, 'Vay Delikanli', 'http://k003.kiwi6.com/hotlink/8q9aznw9kd/Veysel_Mutlu_-_Vay_Delikanl_G_nl_m_-_Official_Video_.mp3'),
(47, 'Türk Pop Radyo', 'http://radyo.dogannet.tv/turkpop'),
(48, 'elimize verdiler', 'http://k003.kiwi6.com/hotlink/s6mlinx7gb/Elimize_Verdiler_.mp3'),
(49, 'Cendere', 'http://k003.kiwi6.com/hotlink/dwt9fmou7c/Cendere_V2_.mp3'),
(50, 'Muslum BABA - Affet', 'http://k003.kiwi6.com/hotlink/mo6br071h5/M_sl_m_G_rses_-_Affet.mp3'),
(51, 'Muslum Baba - Nilüfer', 'http://k003.kiwi6.com/hotlink/2oaj99qw8k/M_sl_m_G_rses_-_Nil_fer.mp3'),
(52, 'Muslum Baba - Sigara', 'http://k003.kiwi6.com/hotlink/uk0hy3ui3a/M_sl_m_G_rses_-_Sigara.mp3'),
(53, 'Muslum baba - tutam?yorum zaman?', 'http://k003.kiwi6.com/hotlink/sokjju86qo/M_sl_m_G_rses_Tutam_yorum_Zaman_.mp3'),
(54, 'Müslüm Baba Show', 'http://k003.kiwi6.com/hotlink/ztdkihe1rj/AUD-20180213-WA0010.mp3'),
(55, 'Beni ?yi San?yorlar', 'http://k003.kiwi6.com/hotlink/f9cva6dztx/Beni_yi_San_yorlar.mp3'),
(56, 'işçi retron yavaş', 'asdğp');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `sbanlog`
--

CREATE TABLE `sbanlog` (
  `serial` varchar(72) COLLATE utf8_turkish_ci NOT NULL,
  `name` varchar(24) COLLATE utf8_turkish_ci NOT NULL,
  `time` varchar(50) COLLATE utf8_turkish_ci NOT NULL,
  `playerip` varchar(16) COLLATE utf8_turkish_ci NOT NULL,
  `sebep` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `admin` varchar(500) COLLATE utf8_turkish_ci NOT NULL,
  `ban_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `sorular`
--

CREATE TABLE `sorular` (
  `ID` int(11) NOT NULL,
  `Soru` varchar(1024) COLLATE utf8_turkish_ci NOT NULL,
  `Cevap` varchar(500) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `sorular`
--

INSERT INTO `sorular` (`ID`, `Soru`, `Cevap`) VALUES
(1, '01 nerenin plakasidir?', 'Adana'),
(2, '03 nerenin plakasidir?', 'Afyonkarahisar'),
(3, '06 nerenin plakasidir?', 'Ankara'),
(4, '12.3 kilowatt kac watt eder?', '12300'),
(5, '2010 kultur baskenti secilen ilimiz hangisidir?', 'istanbul'),
(6, 'Akdeniz`i Atlas Okyanusu`na baglayan bogazin adi nedir?', 'Cebelitarik Bogazi'),
(7, 'Agzi mantar tikali siseleri acmak icin kullanilan alet?', 'Turbuson'),
(8, 'A4 kagidinin standart boyutlari nedir?', '210x297'),
(9, '17 Agustos depreminin merkez ussu neresidir?', 'Golcuk'),
(10, '79 nerenin plakasidir?', 'Kilis'),
(11, 'Dunyanin ilk haritasini cizen unlu Turk denizcisi kimdir?', 'Piri Reis'),
(12, 'Tarihte Turk adiyla kurulan ilk Turk devleti nedir?', 'Gokturkler'),
(13, 'Telefonun mucidi kimdir?', 'Graham Bell'),
(14, 'Nobel oldulleri hangi ulkede verilmektedir?', 'isvec'),
(15, 'Yeni Turk Lira`sindaki `Yeni` sozcugu hangi tarihte atilmistir?', '01.01.2009'),
(16, 'Turk tarihinin en unlu mimari kimdir?', 'Mimar Sinan'),
(17, 'GamerLity kisaltmasi nedir?', 'GL');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `sunucu_ayarlari`
--

CREATE TABLE `sunucu_ayarlari` (
  `rekor` int(11) NOT NULL,
  `rekortarih` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Tablo döküm verisi `sunucu_ayarlari`
--

INSERT INTO `sunucu_ayarlari` (`rekor`, `rekortarih`) VALUES
(50, 1516790908);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `yazilar`
--

CREATE TABLE `yazilar` (
  `id` int(11) NOT NULL,
  `baslik` varchar(255) COLLATE utf8_turkish_ci NOT NULL,
  `resim` text COLLATE utf8_turkish_ci NOT NULL,
  `yazi` text COLLATE utf8_turkish_ci NOT NULL,
  `yazar` varchar(255) COLLATE utf8_turkish_ci NOT NULL,
  `tarih` varchar(255) COLLATE utf8_turkish_ci NOT NULL,
  `kategori` varchar(24) COLLATE utf8_turkish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `adminler`
--
ALTER TABLE `adminler`
  ADD UNIQUE KEY `kullaniciadi` (`kullaniciadi`);

--
-- Tablo için indeksler `arkadaslar`
--
ALTER TABLE `arkadaslar`
  ADD PRIMARY KEY (`ID`);

--
-- Tablo için indeksler `bitcoin_satim`
--
ALTER TABLE `bitcoin_satim`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Tablo için indeksler `bolgeler`
--
ALTER TABLE `bolgeler`
  ADD PRIMARY KEY (`bolgeid`);

--
-- Tablo için indeksler `bugraporlog`
--
ALTER TABLE `bugraporlog`
  ADD PRIMARY KEY (`BUGRAPOR_ID`);

--
-- Tablo için indeksler `ceteler`
--
ALTER TABLE `ceteler`
  ADD PRIMARY KEY (`ID`);

--
-- Tablo için indeksler `cetemekanlari`
--
ALTER TABLE `cetemekanlari`
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Tablo için indeksler `chatlog`
--
ALTER TABLE `chatlog`
  ADD PRIMARY KEY (`LOG_ID`);

--
-- Tablo için indeksler `dukkanlar`
--
ALTER TABLE `dukkanlar`
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Tablo için indeksler `onerilog`
--
ALTER TABLE `onerilog`
  ADD PRIMARY KEY (`ONERI_ID`);

--
-- Tablo için indeksler `oyuncular`
--
ALTER TABLE `oyuncular`
  ADD PRIMARY KEY (`sqlid`);

--
-- Tablo için indeksler `pmlog`
--
ALTER TABLE `pmlog`
  ADD PRIMARY KEY (`PM_ID`);

--
-- Tablo için indeksler `sarkilar`
--
ALTER TABLE `sarkilar`
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Tablo için indeksler `sbanlog`
--
ALTER TABLE `sbanlog`
  ADD PRIMARY KEY (`ban_id`),
  ADD UNIQUE KEY `ban_id` (`ban_id`);

--
-- Tablo için indeksler `sorular`
--
ALTER TABLE `sorular`
  ADD PRIMARY KEY (`ID`);

--
-- Tablo için indeksler `yazilar`
--
ALTER TABLE `yazilar`
  ADD PRIMARY KEY (`id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `arkadaslar`
--
ALTER TABLE `arkadaslar`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `bitcoin_satim`
--
ALTER TABLE `bitcoin_satim`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `bolgeler`
--
ALTER TABLE `bolgeler`
  MODIFY `bolgeid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- Tablo için AUTO_INCREMENT değeri `bugraporlog`
--
ALTER TABLE `bugraporlog`
  MODIFY `BUGRAPOR_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `ceteler`
--
ALTER TABLE `ceteler`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `chatlog`
--
ALTER TABLE `chatlog`
  MODIFY `LOG_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `onerilog`
--
ALTER TABLE `onerilog`
  MODIFY `ONERI_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `oyuncular`
--
ALTER TABLE `oyuncular`
  MODIFY `sqlid` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `pmlog`
--
ALTER TABLE `pmlog`
  MODIFY `PM_ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `sbanlog`
--
ALTER TABLE `sbanlog`
  MODIFY `ban_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `sorular`
--
ALTER TABLE `sorular`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Tablo için AUTO_INCREMENT değeri `yazilar`
--
ALTER TABLE `yazilar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
