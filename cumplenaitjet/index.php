<?php

require 'setup.php';

// get user login
if ($user) {
	 $logoutUrl = $facebook->getLogoutUrl();
} else {

	// documentación http://developers.facebook.com/docs/reference/api/permissions/
	$par['scope'] = "email, user_birthday, user_likes, user_about_me, user_location";
	$loginUrl = $facebook->getLoginUrl($par);
}

$title = 'CumpleNaitJet';

require 'templates/header.php';

?>

<p align="center">

<img src="img/cake.png" height="400"/>

<br/>

<?php if ($user): ?>
	<a href="friends.php" class="btn btn-large btn-primary">Añadir amigo</a> 
	<a href="logout.php" class="btn btn-large">Salir</a>
<?php else: ?>
	<a href="<?=$loginUrl?>" class="btn btn-large btn-primary">Facebook connect</a>
<?php endif ?>

<br/><br/>

<a href="http://www.yunait.com"><img alt="Yunait" src="http://www.yunait.com/img/powered-by-yunait.png" width="70"/></a> 
<a href="http://bit.ly/L7KQOs"><img alt="Mailjet" src="img/mailjet.jpg" width="70"/></a>


</p>

    
<?php

require 'templates/footer.php'

?>