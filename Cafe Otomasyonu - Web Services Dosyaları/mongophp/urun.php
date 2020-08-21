<?php

require 'vendor/autoload.php'; // include Composer's autoloader

$collection = (new MongoDB\Client)->cafe->urunler;

$findoneresult = $collection->findOne(
    ['kategori_adi' =>  $_GET['ktadi']],
);

echo json_encode($findoneresult);

?>