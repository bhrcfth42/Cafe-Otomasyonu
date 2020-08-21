<?php
require 'vendor/autoload.php'; // include Composer's autoloader


$collection = (new MongoDB\Client)->cafe->kullanicilar;
if($_GET["kadi"]!=NULL&&$_GET["sifre"]!=NULL)
	$insertOneResult = $collection->insertOne([
		'kullanici_adi' => $_GET["kadi"],
		'parola' => $_GET["sifre"],
	]);

printf("Inserted %d document(s)", $insertOneResult->getInsertedCount());

var_dump($insertOneResult->getInsertedId());
?>