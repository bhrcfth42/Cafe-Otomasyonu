<?php
require 'vendor/autoload.php'; // include Composer's autoloader

$collection = (new MongoDB\Client)->cafe->masalar;

$document = $collection->findOne(array('masa_adi'=>$_GET["masaadi1"]),array('siparisList'));

$deger=$document['siparisList'];
$loop=count($deger);
$toplam=0;
while($loop>0){
	
	$collection = (new MongoDB\Client)->cafe->masalar;

	$document = $collection->findOne(array('masa_adi'=>$_GET["masaadi1"]),array('siparisList'));

	$deger=$document['siparisList'];
	$loop=count($deger);
	$deger1=$deger[0];

	$a= $deger1['urun_adi'];
	$b= $deger1['urun_adet'];
	$c= $deger1['urun_fiyat'];
	if($a!=NULL){
		$updateOneResult=$collection->updateOne(
		['masa_adi'=>$_GET["masaadi2"]],
		['$push' => ['siparisList' => ['urun_adi' => $a, 'urun_adet' => floatval($b),'urun_fiyat' => floatval($c)]]]
		);
		
		$collection->updateOne(
		['masa_adi'=>$_GET["masaadi1"]],
		['$pull' => ['siparisList' => ['urun_adi' => $a, 'urun_adet' => floatval($b),'urun_fiyat' => floatval($c)]]]
		);
		
		$toplam+=$updateOneResult->getModifiedCount();
	}
	else{
		$durum=$document['masa_durumu'];
		$collection->updateOne(
			['masa_adi'=>$_GET["masaadi2"]],
			['$set' => ['masa_durumu'=>$durum]]
		);
		$collection->updateOne(
			['masa_adi'=>$_GET["masaadi1"]],
			['$set' => ['masa_durumu'=>'Boş']]
		);
	}
}
printf("Modified %d document(s)",$toplam);

?>