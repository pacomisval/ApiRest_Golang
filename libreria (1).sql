-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-03-2020 a las 11:05:55
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
(5, 'Lola', '33', 'lolan@mail.com', 'user', ''),
(7, 'Lolo', '2bced9db434009e30b73ba286b3bb334e6d2aae18a2edec0237cc0cbdbf22961', 'lolon@mail.com', 'admin', ''),
(8, 'Ramon', '0114df7f4f60df25bef976b553787df3fff01f2a418333ff3ac150d509bfeac0', 'ramon@mail.com', 'admin', ''),
(9, 'Pau', '10181465e0e0b8cef439778b53c74931cf4bc73034e2ff7972325831aef7acfe', 'pau@mail.com', 'user', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6MCwiTm9tYnJlIjoiUGF1IiwiRW1haWwiOiIiLCJleHAiOjE1ODQ4NzgxNDF9.8O8OTUPOFU2P8LVUuGt5pkeDV4d6BIUxpL0pwjIZrmw'),
(10, 'Emilio', '2024e2860df56ea0d6cb11459de7e4f8b5e8083311ed5434761952ac542d197e', 'emilio@mail.com', 'user', ''),
(11, 'Lucas', '44c8904ed2d01d37f6be11f084b049654dba24d9d3b4068802c51cf4cb4eeb6f', 'lucas@mail.com', 'user', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6MCwiTm9tYnJlIjoiTHVjYXMiLCJFbWFpbCI6IiIsImV4cCI6MTU4NDg4MTc2N30.mz5vq8HOGDHZDrsKqrl-NnIPEEjofwLAMqUhoYJgl4Y'),
(12, 'Paula', '52cf60ef57a7f3649e4387dc2ce5f11338c54cec17e655aee550233075467b3b', 'paula@mail.com', 'user', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6MCwiTm9tYnJlIjoiUGF1bGEiLCJFbWFpbCI6IiIsImV4cCI6MTU4NDg4MjAxOH0.3AQH7wBXQaFZ46ECLXO1hm8QXneaR9Uzy88i215wGho'),
(13, 'Oto', '2e104a9b58c7cb2a880b3d9afcd0294fe40aa7b7388bcc4ec65bb71ac47f974a', 'oto@mail.com', 'admin', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6MCwiTm9tYnJlIjoiT3RvIiwiRW1haWwiOiIiLCJleHAiOjE1ODQ5NDkzODB9.7vk12Df98nKwGDA_D0Rh27B4gCONTJ_1UlhovqvLIWk'),
(14, 'Pedro', '80c37db67e22b4d3c6bfa6a2ac3d1affcfd24eec8517013589ca746d59d2bb9d', 'pedro@mail.com', 'user', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6MCwiTm9tYnJlIjoiUGVkcm8iLCJFbWFpbCI6IiIsImV4cCI6MTU4NDk1MDg4MH0.xX1lEwL5VAOc7I1UMKuEWTshLpqEMR828HNYw2Wtf_w'),
(15, 'Luca', '1790ae77c93581dd3c5722a6fb4ed5540a1ec11c22ef3bd2ca86d39f77c2f059', 'luca@mail.com', 'user', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6MCwiTm9tYnJlIjoiTHVjYSIsIkVtYWlsIjoiIiwiZXhwIjoxNTg0OTUyMTM1fQ.e-frPUzFpCxViNkiTjt5Ee7enQjVuA2gBK3qPx17PhE'),
(16, 'Luz', 'a352fc4fcf754d4a37f3058ac2d5e7525d86339b1f6308ac3b5fc71e6256c408', 'luz@mail.com', 'user', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJJZCI6MCwiTm9tYnJlIjoiTHV6IiwiRW1haWwiOiIiLCJleHAiOjE1ODQ5NTI2Njd9.nRQSWra3o7RmOa4Ivq4WjFZXeyfYqzfVZ3gy01HRIkw'),
(18, 'Lucy', '3397539be27c8f9f7dc53180a7978e94b4e2aaa45542ca49b425c04e737b1c2b', 'lucy@mail.com', 'user', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJOb21icmUiOiJMdWN5IiwiRW1haWwiOiJsdWN5QG1haWwuY29tIiwiZXhwIjoxNTg0OTUzMjkwfQ.yqKHqwXvWtjFc3_OdykaTlF2rNIuq0bM2swTl1-3hyU');

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
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

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
