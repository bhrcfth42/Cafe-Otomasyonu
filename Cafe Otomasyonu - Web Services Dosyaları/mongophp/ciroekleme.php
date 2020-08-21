<?php

require 'vendor/autoload.php'; // include Composer's autoloader

$collection = (new MongoDB\Client)->cafe->ciro;
$collection2 = (new MongoDB\Client)->cafe->masalar;

$findOneResult = $collection->find(
    ['masa_adi' => $_GET['masaadi']]
);

$findOneResult2 = $collection->find(
    ['masa_adi' => $_GET['masaadi'],'CiroList' => ['$elemMatch' => ['date' => date("Y-m-d")]]]
);

if(count(iterator_to_array($findOneResult))==0){
	$insertOneResult = $collection->insertOne([
    'masa_adi' => $_GET["masaadi"],
    'CiroList'=>[['date' => date("Y-m-d"), 'gelir' => floatval($_GET["gelir"])]],
	]);
	printf("Modified %d document(s)", $insertOneResult->getInsertedCount());
}elseif(count(iterator_to_array($findOneResult2))==0){
	$updateOneResult = $collection->updateOne(
    ['masa_adi' => $_GET['masaadi']],
    ['$push' => ['CiroList' => ['date' => date("Y-m-d"), 'gelir' => floatval($_GET["gelir"])]]]
);
printf("Modified %d document(s)", $updateOneResult->getModifiedCount());
}else{
	$updateOneResult = $collection->updateOne(
	['masa_adi'=>$_GET['masaadi'],'CiroList' => ['$elemMatch' => ['date' => date("Y-m-d")]]],
	['$inc'=>['CiroList.$.gelir'=>floatval($_GET["gelir"])]]
	);
	if(intval($_GET["komut"])==1){
		$deleteResult = $collection2->updateOne(
    ['masa_adi' => $_GET['masaadi']],
    ['$set' => ['siparisList'=>[]]]
	);}
printf("Modified %d document(s)", $updateOneResult->getModifiedCount());
}
?>