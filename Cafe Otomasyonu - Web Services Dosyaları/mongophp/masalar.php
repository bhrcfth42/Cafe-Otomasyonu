<?php
require 'vendor/autoload.php'; // include Composer's autoloader

$collection = (new MongoDB\Client)->cafe->masalar;

$document = $collection->find();
$array = iterator_to_array($document);

echo json_encode($array);
?>