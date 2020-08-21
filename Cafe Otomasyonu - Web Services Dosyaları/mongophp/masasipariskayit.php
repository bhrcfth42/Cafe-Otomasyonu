<?php

require 'vendor/autoload.php'; // include Composer's autoloader

$collection = (new MongoDB\Client)->cafe->masalar;

$updateOneResult = $collection->updateOne(
    ['_id' => new MongoDB\BSON\ObjectID($_GET['id'])],
    ['$push' => ['siparisList' => ['urun_adi' => $_GET["uadi"], 'urun_adet' => floatval($_GET["uadet"]),'urun_fiyat' => floatval($_GET["ufyt"])]]]
);
$collection->updateOne(
    ['_id' => new MongoDB\BSON\ObjectID($_GET['id'])],
    ['$set' => ['masa_durumu'=>'Onay Bekliyor']]
);

printf("Modified %d document(s)", $updateOneResult->getModifiedCount());

?>