<?php

require 'setup.php';

unset( $_SESSION['friends'][$_GET['id']] );

header('location: friends.php?updated');