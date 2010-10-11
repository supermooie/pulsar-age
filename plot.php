<?php

require_once('Config.php');
require_once('Classes/DataFile.php');
require_once('Classes/Identifier.php');

require_once('jpgraph/jpgraph.php');
require_once('jpgraph/jpgraph_scatter.php');
require_once('jpgraph/jpgraph_line.php');
require_once('jpgraph/jpgraph_error.php');

$smarty = new Smarty();
$smarty->template_dir = SMARTY_TEMPLATE_DIR;
$smarty->compile_dir = SMARTY_COMPILE_DIR;

$pulsar_name = $_REQUEST['pulsar'];
// TODO: verify pulsar name

CreatePeriodVsPlot($pulsar_name);

$smarty->assign('pulsar_name', $_REQUEST['pulsar']);
$smarty->assign('id', Identifier::GetId());
$smarty->display('plot.tpl');

/**
 * Reads Observations/<$pulsar name>/*.dat to extract period, period error, and MJD.
 * Creates a plot as sessions/period_vs_mjd_id.blah
 *
 * Throws any error encountered???
 */
function CreatePeriodVsPlot($pulsar_name)
{
  // Use an array of stdClass to store period, period error, and MJD.
  // glob(directory)

  $directory = OBSERVATIONS_DIR . $pulsar_name . '/';
  $data_filenames = glob($directory . '*.dat');

  $data_files_contents = array();

  foreach ($data_filenames as $filename) {
    $data_files_contents[] = 
      DataFile::GetValues($filename);
  }

  /*echo '<pre>';
  print_r($data_files_contents);
echo '</pre>';*/

$count = count($data_files_contents);

for ($i = 0; $i < $count; $i++) {
  $periods[] = $data_files_contents[$i]->period;
  $MJDs[] = $data_files_contents[$i]->MJD;
  $period_errors[] = $data_files_contents[$i]->period_error;
}

$period_and_errors = array();

for ($i = 0; $i < $count; $i++) {
  $period_and_errors[] = $periods[$i];
  $period_and_errors[] = sprintf('%f',(float)$period_errors[$i] + $periods[$i]);
}

$graph = new Graph(900,500);
$graph->SetScale("linlin");

$graph->img->SetMargin(70,70,40,40);
$graph->SetShadow();

$errplot=new ErrorLinePlot($period_and_errors, $MJDs);
$errplot->SetColor("red");
$errplot->SetWeight(2);
$errplot->SetCenter();
$errplot->line->SetWeight(2);
$errplot->line->SetColor("blue");

// Setup the legends
$errplot->SetLegend("Period Error");

$graph->title->Set("Period vs MJD");
$graph->title->SetFont(FF_FONT1,FS_BOLD);

$graph->xaxis->SetTickLabels($MJDs);

$graph->Add($errplot);

$id = Identifier::GetId();
$graph->Stroke("session/period_vs_mjd_$id.png");

}

?>
