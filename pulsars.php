<?php

require_once('Config.php');
require_once('Classes/Identifier.php');

define('THIS_PAGE', 'pulsars.php');

Identifier::Init(THIS_PAGE);

$smarty = new Smarty();

// Defined in 'Config.php'
$smarty->template_dir = SMARTY_TEMPLATE_DIR;
$smarty->compile_dir = SMARTY_COMPILE_DIR;

$smarty->display('pulsars.tpl');

?>
