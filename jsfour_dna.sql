USE `essentialmode`;

CREATE TABLE `jsfour_dnaTEMP` (
  `pk` varchar(255) COLLATE utf8mb4_bin NOT NULL,
  `killer` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `dead` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `weapon` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_bin DEFAULT 'murder',
  `lastdigits` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `uploader` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `datum` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`pk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
