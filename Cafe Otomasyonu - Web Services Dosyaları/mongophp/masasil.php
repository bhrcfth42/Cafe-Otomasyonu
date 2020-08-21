<?php
require 'vendor/autoload.php'; // include Composer's autoloader

$collection = (new MongoDB\Client)->cafe->masalar;

$deleteResult = $collection->deleteOne(['masa_adi' => $_GET["masaadi"]]);

printf("Deleted %d document(s)", $deleteResult->getDeletedCount());
?>