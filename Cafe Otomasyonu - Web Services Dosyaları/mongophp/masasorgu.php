<?php
require 'vendor/autoload.php'; // include Composer's autoloader

$collection = (new MongoDB\Client)->cafe->masalar;

$document = $collection->findOne(['_id' => new MongoDB\BSON\ObjectID($_GET['id']),]);

echo json_encode($document);
?>