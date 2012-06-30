<?php

require 'setup.php';
require 'Mail.php';

// get friend info
$friend = json_decode( file_get_contents( 'https://graph.facebook.com/' . $_GET['id'] ) );


// categorias yunait http://www.yunait.com/rest/categories?key=484f3ccc716c2d25069b416ce0cabedd6fc54572
if( $friend->gender == 'male' ){

	/*

	26 - Ordenadores
	30 - Videojuegos
	34 - Aventura	
	48 - Conciertos
	50 - Cine
	51 - Entradas discoteca
	52 - Espectaculos
	
	*/

	$categories = '26,30,34,48,50,51,52';
	
}else{
	
	/*
	
	7 - Tratamientos de belleza
	8 - SPAs
	9 - Masajes
	10- Peluqueria, manicura, pedicura
	11 - Depilación
	12 - Bronceado
	13 - Maquillaje
	14 - Cosmetica
	
	*/
	
	$categories = '7,8,9,10,11,12,13,14';
	
}

// get deals
$url = 'http://www.yunait.com/rest/deals/in?lat=40.416691&lng=-3.700345&format=json&key=' . $yunait_key . '&categories=' . $categories;
$data = json_decode( file_get_contents( $url ) );
$items = array_splice( $data->data, 0, 5 );
shuffle( $items );


// generate mail html template
$title = $subject = 'Mañana es el cumpleaños de ' . $friend->name;

ob_start();

require 'templates/header.php';

?>

<style>H1{color:black;font-family:Arial;font-size:2em}</style>

<br/>

<p align="center"><img src="http://graph.facebook.com/<?=$friend->id?>/picture?type=large"/></p>

<ul>
<?php foreach( $items as $item ): extract((array)$item) ?>

	<li><img src="<?=$image?>" style="float:left;margin-right:15px" height="100"/> <a href="<?=$url?>" style="font-size:20px;text-decoration:none"><?=$title?></a><br style="clear:both"/><br/></li>

<?php endforeach ?>

</ul>

<?php

require 'templates/footer.php';


// get cache
$html = ob_get_contents();
ob_end_clean();

// send mail
$headers = array ('From' => 'Betabeers <contacto@betabeers.com>',
   		  'Subject' => $subject,'Content-type' => 'text/html; charset=UTF-8');
 
$smtp = Mail::factory('smtp',
	array ('host' => 'ssl://in.mailjet.com',
  		'port' => 465,
        'auth' => true,
        'username' => $apiKey,
        'password' => $secretKey));
$mail = $smtp->send($user['email'], $headers, $html );
	

// print cache
echo $html;