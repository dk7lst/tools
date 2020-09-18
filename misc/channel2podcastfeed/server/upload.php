<?php
// http://php.net/manual/de/features.file-upload.post-method.php

//print_r($_FILES);
//print_r($_GET);

// Access-Token prüfen:
if($_GET['token'] != "CHANGEME") die("error 1\n");

$upload = $_FILES['file'];
if($upload['error'] != UPLOAD_ERR_OK) die("error 2\n");
if($upload['size'] > 10 * 1024 * 1024) die("error 3\n");

$fn = $upload['name'];
if(strlen($fn) > 32 || substr($fn, 0, 4) != "rec-" || substr($fn, -4) != ".mp3") die("error 4\n");

if(!move_uploaded_file($upload['tmp_name'], "mp3/" . $fn)) die("error 10\n");

echo "ok\n";
?>
