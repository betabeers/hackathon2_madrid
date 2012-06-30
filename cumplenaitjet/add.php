<?php

require 'setup.php';

$_SESSION['friends'][$_GET['id']] = $_GET['name'];

header('location: friends.php?updated');