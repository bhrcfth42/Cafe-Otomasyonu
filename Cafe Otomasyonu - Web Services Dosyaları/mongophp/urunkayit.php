<?php

require 'vendor/autoload.php'; // include Composer's autoloader

$collection = (new MongoDB\Client)->cafe->urunler;
if($_GET["ktadi"]!=NULL&&$_GET["uadi"]!=NULL&&$_GET["ufyt"]!=NULL)
$updateOneResult = $collection->updateOne(
    ['kategori_adi' => $_GET["ktadi"]],
    ['$push' => ['urunList' => ['urun_adi' => $_GET["uadi"], 'urun_fiyat' => floatval($_GET["ufyt"])]]]
);

printf("Modified %d document(s)", $updateOneResult->getModifiedCount());

?>