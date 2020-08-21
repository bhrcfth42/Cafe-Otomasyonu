<?php
require 'vendor/autoload.php'; // include Composer's autoloader

$collection = (new MongoDB\Client)->cafe->masalar;
if($_GET["masaadi"]!=NULL)
$insertOneResult = $collection->insertOne([
    'masa_adi' => $_GET["masaadi"],
	'masa_durumu'=>'Boş',
    'siparisList'=>[],
]);

printf("Inserted %d document(s)", $insertOneResult->getInsertedCount());

?>