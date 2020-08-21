<?php

require 'vendor/autoload.php'; // include Composer's autoloader

$collection = (new MongoDB\Client)->cafe->masalar;

$deleteOneResult = $collection->updateOne(
    ['masa_adi' => $_GET['ad']],
    ['$pull' => ['siparisList' => ['urun_adi' => $_GET["uadi"], 'urun_adet' => floatval($_GET["uadet"])]]]
);

$document = $collection->findOne(array('masa_adi'=>$_GET["ad"]),array('siparisList'));
$deger=$document['siparisList'];
if(count($deger)==0)
	$collection->updateOne(
    ['masa_adi' => $_GET['ad']],
    ['$set' => ['masa_durumu'=>'Boş']]
);

printf("Deleted %d document(s)", $deleteOneResult->getModifiedCount());

?>