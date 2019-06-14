<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <link href='https://fonts.googleapis.com/css?family=Ubuntu&subset=cyrillic,latin' rel='stylesheet' type='text/css' />


  <meta name="author" content="">
  <title><?=$title?></title>
  <link href="<?=base_url('storage/');?>vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
  <link href="<?=base_url('storage/');?>css/custom.css" rel="stylesheet">
  <link href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css" rel="stylesheet">
  <link href="https://cdn.datatables.net/1.10.19/css/dataTables.bootstrap.min.css" rel="stylesheet">
  <link href="<?=base_url('storage/');?>css/sb-admin-2.min.css" rel="stylesheet">

</head>
<?php if(!$this->session->logged_in): ?>
<body class="bg-gradient-primary">
<?php else: ?>
<body class="page-top">
<?php endif;?>
