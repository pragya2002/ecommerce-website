-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jan 14, 2022 at 08:19 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `GeminiTeens`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `sno` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `product` varchar(100) NOT NULL,
  `price` varchar(10) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `img_url` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `sno` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `last` varchar(100) NOT NULL,
  `feedback` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`sno`, `email`, `phone`, `last`, `feedback`) VALUES
(4, 'pragya.yss10@gmail.com', '08840079618', 'tote bag', ' this is an awesome website and i love it!'),
(19, 'shrirama786@gmail.com', '9940698260', 'bag/chain/shirt/shorts/glasses', 'so i was looking up on instagram and i found this site and to my surprise,everything they offer is so cheap for the quality they are offering,first i thought it was a scam but after i got the products and saw them first hand,i feel like i cheated the company by paying so less for these top quality products.I absolutely love them and so does my imaginary girlfriend,and about the website,i absolutely love the feel-good vibe the website is giving and how neatly the products are categorised.KUDOS TO THE WEB DEVELOPER,i\'d thank him/her my heart out cuz she/he saved me a lot of money cuz the website is the first thing my imaginary girlfriend fell in love with <3.thank you gemini teens!!!');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `sno` int(11) NOT NULL,
  `username` varchar(20) NOT NULL,
  `product` text NOT NULL,
  `quantity` int(11) NOT NULL,
  `img_url` text NOT NULL,
  `price` varchar(11) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`sno`, `username`, `product`, `quantity`, `img_url`, `price`, `date`) VALUES
(51, 'thisisshri', 'Oversized Shirt', 1, 'https://media.nastygal.com/i/nastygal/agg40722_blue_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp', '799', '2022-01-14 11:39:11'),
(52, 'thisisshri', 'Denim Shorts', 1, 'https://media.nastygal.com/i/nastygal/agg73500_mid%20blue_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp', '599', '2022-01-14 11:39:11'),
(53, 'thisisshri', 'Structured Croc Cross Body Mini Bag', 1, 'https://media.nastygal.com/i/nastygal/agg68992_white_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp', '2499', '2022-01-14 11:39:11'),
(54, 'thisisshri', '\'Til Eye Found You Cat-Eye Tinted Sunglasses', 1, 'https://media.nastygal.com/i/nastygal/agg51457_black_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp', '800', '2022-01-14 11:39:11'),
(55, 'thisisshri', 'Be There Moon Layered Chain Necklace', 1, 'https://media.nastygal.com/i/nastygal/agg49217_silver_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp', '280', '2022-01-14 11:39:11');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `sno` int(11) NOT NULL,
  `category` varchar(100) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `price` varchar(10) NOT NULL,
  `quantity_avail` int(11) NOT NULL,
  `img_url` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`sno`, `category`, `title`, `description`, `price`, `quantity_avail`, `img_url`) VALUES
(1, 'accessories', 'Black Leather Tote Bag', 'Adds an elegant touch to your style. Synthetic Materials. One size.', '1999', 99, 'https://media.nastygal.com/i/nastygal/agg55547_black_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(2, 'accessories', 'Structured Croc Cross Body Mini Bag', 'This beautiful Croc Cross Body Mini Bag by Robert Matthew allows you to bring everything with you whenever you need to, but fashionably of course! Keep yourself organized with the interior and exterior pockets while getting compliments from everyone on the gorgeous gold hardware on this stunning bag. Synthetic Materials. One size.', '2499', 98, 'https://media.nastygal.com/i/nastygal/agg68992_white_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(3, 'accessories', '\'Til Eye Found You Cat-Eye Tinted Sunglasses', 'Add these to your collection cause they are all you need for a complete chic look.', '800', 99, 'https://media.nastygal.com/i/nastygal/agg51457_black_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(4, 'accessories', 'Hoop Earrings', 'These hoop earrings can be paired up with any kind of style, be it casual or work!', '350', 100, 'https://media.nastygal.com/i/nastygal/agg46018_gold_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(5, 'accessories', 'Be There Moon Layered Chain Necklace', 'The party don\'t start till you walk in. This necklace features a layered design, four curb chains, lobster clasp closure, and moon, elephant and ornate pendants at drop.', '280', 99, 'https://media.nastygal.com/i/nastygal/agg49217_silver_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(6, 'accessories', 'Triangle Your Luck Faux Leather Belt', 'Give it your belt shot. This belt comes in faux leather and features a medium band and double, triangle buckle closure.', '400', 100, 'https://media.nastygal.com/i/nastygal/agg00487_white_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(7, 'summer', 'Oversized Shirt', 'A lil something for the days you feel like getting dressed. This shirt features an oversized silhouette, V-neckline, pointed collar, button-down closure at front, curved hem, and drop, puff sleeves with fitted cuffs.', '799', 91, 'https://media.nastygal.com/i/nastygal/agg40722_blue_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(8, 'summer', 'Crop Ribbed Tank Top', 'Catch ya later. This top comes ribbed and features a crew neckline and fitted, cropped silhouette.', '799', 94, 'https://media.nastygal.com/i/nastygal/agg56519_rose_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(9, 'summer', 'Denim Shorts', 'These shorts come in medium wash denim and feature a high-waisted silhouette, zip fly closure, 5-pocket design, fading throughout, and distressed detailing.', '599', 95, 'https://media.nastygal.com/i/nastygal/agg73500_mid%20blue_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(10, 'summer', 'Tie back mini smock dress', 'Perfect dress for a casual outing on a sunny day.', '800', 98, 'https://media.nastygal.com/i/nastygal/agg54384_white_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(11, 'summer', 'Pleated Skirt', 'This skirt features a high-waisted, mini silhouette, pleats throughout, button at front, and check print throughout.', '599', 100, 'https://media.nastygal.com/i/nastygal/agg42879_beige_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp%20alt='),
(12, 'summer', 'Plunging Tie Back Blouse', 'Pleasant colour and a decent style.', '599', 100, 'https://media.nastygal.com/i/nastygal/agg51821_pink_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(13, 'winter', 'Winter Padded Jacket', 'This Winter Jacket comes in corduroy and features a padded design, zip closure, funnel neck, and pockets and slits at sides.', '999', 99, 'https://media.nastygal.com/i/nastygal/agg77417_beige_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(14, 'winter', 'Faux Wool Longline Coat\r\n', 'It\'s all about the layers. This coat comes in faux wool and features a relaxed, longline silhouette, double breasted, button-down closure, notched lapels, and flap pockets at front.\r\n\r\n', '1499', 99, 'https://media.nastygal.com/i/nastygal/agg55481_black_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(15, 'winter', 'Belted Trench Coat\r\n', 'This coat features a relaxed, longline silhouette, belt with buckle closure at waist, oversized, curved notched lapels, double breasted closures, drop sleeves, and straps with button closures at cuffs.\r\n\r\n', '1599', 99, 'https://media.nastygal.com/i/nastygal/agg54677_white_xl?$product_image_tile_tablet_landscape_pro_2x$&fmt=webp'),
(16, 'winter', 'Knit Cardigan', 'This cardigan comes in a chunky knit and features a relaxed, cropped silhouette, V-neckline, drop sleeves, and button-down closure with pearlized finish.\r\n\r\n', '1199', 100, 'https://media.nastygal.com/i/nastygal/agg62642_ecru_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(17, 'winter', 'Leather Jacket\r\n', 'This Jacket comes in faux leather and features a moto design, asymmetric zip closure, quilting at shoulders and back, zip pockets at sides, snap collar, zip detailing at sleeves, and belt at waist.\r\n\r\n', '1999', 100, 'https://media.nastygal.com/i/nastygal/agg94252_black_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(18, 'winter', 'Woven Scarf\r\n', 'This scarf comes in knit and features a woven, longline design and fringe detailing.\r\n\r\n', '599', 100, 'https://media.nastygal.com/i/nastygal/agg41498_chocolate_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(19, 'sports', 'Relaxed Workout Tank Top', 'Your very own hangover-functioning superhero costume. This tank top comes in a breathable fabric and features a scoop neckline, racerback, relaxed silhouette, and \'NG LA\' graphic at front and back.\r\n\r\n', '599', 99, 'https://media.nastygal.com/i/nastygal/agg57646_apricot_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(20, 'sports', 'Workout Leggings', 'These leggings come in a breathable fabric and feature a high-waisted, bodycon silhouette, contrasting, two-tone design, elasticized waist, and contrasting stitching throughout.\r\n\r\n', '699', 99, 'https://media.nastygal.com/i/nastygal/agg49066_black_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(21, 'sports', 'Relaxed Mesh Workout Tee\r\n', 'This tee comes in mesh and features a crew neckline and relaxed, cropped silhouette.\r\n\r\n', '450', 100, 'https://media.nastygal.com/i/nastygal/agg39125_black_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(22, 'sports', 'Scoop Neck Workout Crop Top\r\n', 'This crop top comes in a breathable fabric and features a scoop neckline at the front and back, fitted, cropped silhouette, stretch fit, elasticized underbust, and \'NG LA\' graphic at front and back.\r\n\r\n', '799', 100, 'https://media.nastygal.com/i/nastygal/agg56656_light%20blue_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(23, 'sports', 'Relaxed Tank Top', 'This workout top comes in a breathable fabric and features a scoop neckline, and racerback, relaxed silhouette.\r\n\r\n', '499', 100, 'https://media.nastygal.com/i/nastygal/agg47959_black_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp'),
(24, 'sports', 'Work out Trainers', 'These sneakers come in faux leather and feature a round toe, contrast stitching, mesh panels, lace-up closure at top, padded ankle, and tread sole.\r\n\r\n', '999', 100, 'https://media.nastygal.com/i/nastygal/agg41790_fuchsia_xl?$product_image_category_page_horizontal_filters_landscape_pro_2x$&fmt=webp');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `sno` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`sno`, `name`, `phone`, `username`, `password`) VALUES
(1, 'Pragya Awasthi', '8840079618', 'thisisprags', '123456'),
(2, 'Aditya Jha', '1234567890', 'thisisadi', '123456'),
(3, 'Shriram Alagarasan', '1234567891', 'thisisshri', '123456'),
(5, 'Seetha Dedeepya', '1234567890', 'thisisseetha', '123456'),
(6, 'Dipanshi Banerjee', '8840079618', 'thisisdipy', '123456'),
(8, 'shrihari', '443', 'thisisshrihari', '123456'),
(14, 'Aarushi Krishna', '08765246915', 'thisisaarushi', '123456');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
