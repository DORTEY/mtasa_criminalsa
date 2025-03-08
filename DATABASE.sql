-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Erstellungszeit: 08. Mrz 2025 um 12:19
-- Server-Version: 10.5.28-MariaDB-0+deb11u1
-- PHP-Version: 8.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `criminalsa`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Accounts`
--

CREATE TABLE `Accounts` (
  `ID` int(11) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `DiscordID` text DEFAULT NULL,
  `Serial` text NOT NULL,
  `Password` text NOT NULL,
  `Secret` text NOT NULL DEFAULT '[ [ ] ]',
  `Promoter` varchar(50) NOT NULL,
  `SpawnPos` varchar(150) NOT NULL DEFAULT '{0,0,0,0}',
  `AdminLevel` int(11) NOT NULL DEFAULT 0,
  `Stats` text NOT NULL DEFAULT '[ [ ] ]',
  `Booster` text NOT NULL DEFAULT '[ [ ] ]',
  `Levels` text DEFAULT '\'[ [ ] ]\'',
  `WeaponSkins` text NOT NULL DEFAULT '[ [ ] ]',
  `PedSkins` text NOT NULL DEFAULT '[ [ ] ]',
  `Achievements` text NOT NULL DEFAULT '[ [ ] ]',
  `Pickups` text NOT NULL DEFAULT '[ [ ] ]',
  `EventPickups` text NOT NULL DEFAULT '[ [ ] ]',
  `Skin` int(11) NOT NULL DEFAULT 1,
  `Settings` text NOT NULL DEFAULT '[ [ ] ]',
  `Date` text NOT NULL DEFAULT '[ [ ] ]',
  `Activated` int(11) NOT NULL DEFAULT 1,
  `LoggedinDB` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Bans`
--

CREATE TABLE `Bans` (
  `ID` int(11) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Serial` varchar(50) NOT NULL,
  `Admin` varchar(50) NOT NULL,
  `Reason` text NOT NULL DEFAULT 'Security ban'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Codes`
--

CREATE TABLE `Codes` (
  `ID` int(11) NOT NULL,
  `Code` varchar(50) NOT NULL,
  `Type` varchar(25) NOT NULL,
  `Item` varchar(25) NOT NULL,
  `Amount` int(11) NOT NULL,
  `UsedBy` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Counter`
--

CREATE TABLE `Counter` (
  `User` bigint(255) NOT NULL DEFAULT 1,
  `Vehicles` bigint(255) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `Counter`
--

INSERT INTO `Counter` (`User`, `Vehicles`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Hideout`
--

CREATE TABLE `Hideout` (
  `ID` int(11) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `HideUpgrades` text NOT NULL DEFAULT '[ [ ] ]',
  `HideItems` text NOT NULL DEFAULT '[ [ ] ]',
  `HideTimers` text NOT NULL DEFAULT '[ [ ] ]',
  `HideLaundry` text NOT NULL DEFAULT '[ [ ] ]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Inventory`
--

CREATE TABLE `Inventory` (
  `ID` int(11) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Money` text NOT NULL DEFAULT '[ [ ] ]',
  `Items` longtext NOT NULL,
  `Points` text NOT NULL DEFAULT '[ [ ] ]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `OfflineMessages`
--

CREATE TABLE `OfflineMessages` (
  `ID` int(11) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `TIme` int(11) NOT NULL,
  `Text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Vehicles`
--

CREATE TABLE `Vehicles` (
  `ID` bigint(25) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `VehID` int(11) NOT NULL,
  `Plate` varchar(50) NOT NULL,
  `Color` text NOT NULL DEFAULT '[ [ ] ]',
  `LightColor` text NOT NULL DEFAULT '[ [ ] ]',
  `Tunings` text NOT NULL DEFAULT '[ { "Paintjob": 9999999 } ]'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `Whitelist`
--

CREATE TABLE `Whitelist` (
  `ID` int(11) NOT NULL,
  `DiscordUserID` varchar(50) NOT NULL,
  `Serial` text NOT NULL,
  `Access` varchar(25) NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `Accounts`
--
ALTER TABLE `Accounts`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `Bans`
--
ALTER TABLE `Bans`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `Codes`
--
ALTER TABLE `Codes`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `Counter`
--
ALTER TABLE `Counter`
  ADD PRIMARY KEY (`User`);

--
-- Indizes für die Tabelle `Hideout`
--
ALTER TABLE `Hideout`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `Inventory`
--
ALTER TABLE `Inventory`
  ADD PRIMARY KEY (`Username`);

--
-- Indizes für die Tabelle `OfflineMessages`
--
ALTER TABLE `OfflineMessages`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `Vehicles`
--
ALTER TABLE `Vehicles`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `Whitelist`
--
ALTER TABLE `Whitelist`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `Bans`
--
ALTER TABLE `Bans`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `Codes`
--
ALTER TABLE `Codes`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `OfflineMessages`
--
ALTER TABLE `OfflineMessages`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `Whitelist`
--
ALTER TABLE `Whitelist`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
