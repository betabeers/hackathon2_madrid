<?php

require 'setup.php';

$friends = $facebook->api('/me/friends');

$title = 'Buscar amigos';

require 'templates/header.php';

?>

<br/><br/><br/>

<?php if( isset($_GET['updated']) ): ?><div class="alert alert-block">amigo añadido</div><?php endif ?>

Nombre amigo: <input type="text" id="quickfind"/>

<table border="1" cellpadding="5" cellspacing="0" id="table">

<?php foreach( $friends['data'] as $id => $friend ): extract($friend) ?>
<tr>
	<td><img src="http://graph.facebook.com/<?=$id?>/picture" align="absmiddle" width="24" height="24"/> <?=$name?></td>
	<td>
	<?php if( isset( $_SESSION['friends'][$id] ) ): ?>
		<a href="mail.php?id=<?=$id?>" class="btn" target="_blank">mail</a>
		<a href="delete.php?id=<?=$id?>" class="btn btn-danger">quitar</a>
	<?php else: ?>
		<a href="add.php?id=<?=$id?>&name=<?=$name?>" class="btn btn-success">recordar</a>
	<?php endif ?>

	</td>
</tr>
<?php endforeach ?>

</table>

</style>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>    
<script type="text/javascript" src="js/scripts-pack.js"></script>

<script>
$().ready(function() {
	//http://www.picnet.com.au/blogs/guido/post/2009/06/29/jquery-table-filter-plugin/
    var options = {
        additionalFilterTriggers: [$('#quickfind')]
    };
    $('#table').tableFilter(options);
});
</script>

<?php

require 'templates/footer.php'

?>