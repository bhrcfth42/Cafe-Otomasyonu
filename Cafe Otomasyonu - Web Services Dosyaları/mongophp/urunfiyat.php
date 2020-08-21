<?php

require 'vendor/autoload.php'; // include Composer's autoloader

$collection = (new MongoDB\Client)->cafe->urunler;

$updateOneResult = $collection->updateOne(
    ['kategori_adi'=>$_GET['ktadi'],'urunList' => ['$elemMatch' => ['urun_adi' => $_GET["uadi"]]]],
    ['$set' => ['urunList.$.urun_fiyat' => floatval($_GET["ufyt"])]],
);

printf("Modified %d document(s)", $updateOneResult->getModifiedCount());
?>