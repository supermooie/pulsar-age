<?php

require_once('Config.php');
require_once('Classes/Identifier.php');

define('THIS_PAGE', ROOT_DIR . 'index.php');

Identifier::Init('index.php');

$smarty = new Smarty();

// Defined in 'Config.php'
$smarty->template_dir = SMARTY_TEMPLATE_DIR;
$smarty->compile_dir = SMARTY_COMPILE_DIR;

$smarty->assign('name', 'Jono');
$smarty->display('index.tpl');

?>
