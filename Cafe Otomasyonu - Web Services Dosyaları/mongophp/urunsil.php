<?php

require 'vendor/autoload.php'; // include Composer's autoloader

$collection = (new MongoDB\Client)->cafe->urunler;

$deleteOneResult = $collection->updateOne(
    ['kategori_adi' => $_GET["ktadi"]],
    ['$pull' => ['urunList' => ['urun_adi' => $_GET["uadi"], 'urun_fiyat' => doubleval($_GET["ufyt"])]]]
);

printf("Modified %d document(s)", $deleteOneResult->getModifiedCount());

?>