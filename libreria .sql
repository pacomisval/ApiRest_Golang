-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 17-03-2020 a las 12:04:43
-- Versión del servidor: 10.4.10-MariaDB
-- Versión de PHP: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `libreria`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autor`
--

CREATE TABLE `autor` (
  `id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `autor`
--

INSERT INTO `autor` (`id`, `first_name`, `last_name`) VALUES
(5, 'Pepe', 'Ramos'),
(6, 'Ana', 'Martinez'),
(7, 'Ramon', 'Saez'),
(8, 'Raul', 'Martin'),
(11, 'Alberto', 'Perez'),
(12, 'Enrique', 'Palu'),
(13, 'Sebas', 'Carrillo'),
(14, 'Luz', 'Benito');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `books`
--

CREATE TABLE `books` (
  `id` int(7) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `isbn` varchar(15) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `idAutor` int(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `books`
--

INSERT INTO `books` (`id`, `nombre`, `isbn`, `idAutor`) VALUES
(18, 'Se ha escrito un crimen', '1212121212', 6),
(19, 'El caballero negro', '1313131313', 7),
(20, 'La cena de caza perruna a las dos', '3737373737', 5),
(21, 'Ya no soy aquel hombre', '1515151515', 5),
(22, 'Tu ves a comerte las bolitas', '1616161616', 8),
(23, 'Que te ha parecido el viaje', '1717171717', 6),
(24, 'Venga malotes fuera de aqui', '1818181818', 7),
(25, 'Nos vemos el el camino', '1919191919', 7),
(26, 'Hemos encontrado un hueco', '2020202020', 7),
(28, 'La comida fue a las dos', '4040404040', 8),
(30, 'Alberto', '1414141414', 11),
(31, 'Probando probando', '4141414141', 7),
(32, 'Comenzando a ver la luz', '0', 8),
(33, 'Comenzando por el principio', '', 5),
(34, 'Vamos ha comer', '', 5),
(35, 'No entres que voy a fregar', '0', 5),
(36, 'No entres que me voyr', '0', 5),
(38, 'Rapido que se acaba todo', '3131313131', 5),
(39, 'Bahamas esta desierta', '3232323232', 6),
(40, 'Apologia del teerremoto', '3434343434', 6),
(41, 'Capricho del destino', '3535353535', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(70) DEFAULT NULL,
  `password` varchar(250) NOT NULL,
  `email` varchar(100) NOT NULL,
  `rol` enum('user','admin','root') NOT NULL,
  `tok` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `password`, `email`, `rol`, `tok`) VALUES
(1, 'Enrique', 'guzman', 'enrique@mail.com', 'user', ''),
(2, 'Manu', '????VK?)?,?)xbڝ?Jz???8lG??T?V', 'manu@mail.com', 'user', ''),
(3, 'Pablo', '33', 'pablo@mail.com', 'user', ''),
(4, 'Belen', '???K?@?\Z?g?@;????N?\0?????HJ??', 'belen@mail.com', 'user', ''),
(5, 'Lola', '33', 'lolan@mail.com', 'user', '');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `autor`
--
ALTER TABLE `autor`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_books_idAutor` (`idAutor`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `autor`
--
ALTER TABLE `autor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `books`
--
ALTER TABLE `books`
  MODIFY `id` int(7) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `fk_books_idAutor` FOREIGN KEY (`idAutor`) REFERENCES `autor` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
