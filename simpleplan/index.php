<?php

$title = "Simpleplan";

// yunait
define('YUNAIT_KEY', '');

// get deals
function getDeal($category_id){
	$url = 'http://www.yunait.com/rest/deals/in?lat=40.416691&lng=-3.700345&format=json&key=' . YUNAIT_KEY . '&categories=' . $category_id;
	$data = json_decode( file_get_contents( $url ) );
	$items = array_splice( $data->data, 0, 5 );
	shuffle( $items );
	$items = array_splice( $items, 0, 1 );
	return $items[0];
}

$deal_copas = getDeal( 3 );
$deal_fun = getDeal( 50,52 );
$deal_restaurante = getDeal( 2 );


?>
<!DOCTYPE html>
<html>
<head>
	<title><?=$title?></title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<style>
	*{font-family: Arial;font-size:20px}
	a{color:blue;text-decoration:none;color:#08C}
	h1{text-align:center;font-size:35px}
	img{height:100px}
	</style>
</head>
<body>

<div style="width:600px;margin:auto">

<h1><?=$title?></h1>

<img src="img/copa.png" style="float:left;margin-right:15px;"/>
toma una copa...<br/>
<a href="<?=$deal_copas->url?>" target="_blank"><?=$deal_copas->title?></a>

<br style="clear:both"/><br/>

<img src="img/cine.png" style="float:left;margin-right:15px;"/>
vete al cine...<br/>
<a href="<?=$deal_cine->url?>" target="_blank"><?=$deal_fun->title?></a>

<br style="clear:both"/><br/>

<img src="img/restaurante.png" style="float:left;margin-right:15px;"/>
come por alli...<br/>
<a href="<?=$deal_restaurante->url?>" target="_blank"><?=$deal_restaurante->title?></a>

</div>

</body>
</html>