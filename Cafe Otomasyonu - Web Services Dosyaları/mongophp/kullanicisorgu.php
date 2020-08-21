<?php
require 'vendor/autoload.php'; // include Composer's autoloader

$collection = (new MongoDB\Client)->cafe->kullanicilar;

$document = $collection->findOne(['kullanici_adi' => $_GET['kadi'],'parola'=>$_GET['sifre']]);

echo json_encode($document);
?>