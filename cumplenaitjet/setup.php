<?php

require 'facebook_sdk/src/facebook.php'; // facebook sdk https://github.com/facebook/php-sdk
require 'config.php';


session_start();

// get facebook user
$user = $facebook->getUser();
if ($user) {
  try {
    $user = $facebook->api('/me');
  } catch (FacebookApiException $e) {
    error_log($e);
    $user = null;
  }
}

