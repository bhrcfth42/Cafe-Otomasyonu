<?php
require 'vendor/autoload.php'; // include Composer's autoloader


$collection = (new MongoDB\Client)->cafe->urunler;
if($_GET["kategoriadi"]!=NULL)
	$insertOneResult = $collection->insertOne([
		'kategori_adi' => $_GET["kategoriadi"],
		'urunList' => [],
	]);

printf("Inserted %d document(s)", $insertOneResult->getInsertedCount());

var_dump($insertOneResult->getInsertedId());
?>