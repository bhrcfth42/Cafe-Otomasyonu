<?php

require 'vendor/autoload.php'; // include Composer's autoloader

$collection = (new MongoDB\Client)->cafe->masalar;

$updateOneResult = $collection->updateOne(
    ['_id' => new MongoDB\BSON\ObjectID($_GET['id'])],
    ['$set' => ['masa_durumu'=>'Onaylandı']]
);

printf("Modified %d document(s)", $updateOneResult->getModifiedCount());
?>