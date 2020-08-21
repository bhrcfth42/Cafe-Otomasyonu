<?php
require 'vendor/autoload.php'; // include Composer's autoloader

$collection = (new MongoDB\Client)->cafe->kullanicilar;

$deleteResult = $collection->deleteOne(['kullanici_adi' => $_GET["kadi"],'parola'=>$_GET['sifre']]);

printf("Deleted %d document(s)", $deleteResult->getDeletedCount());
?>