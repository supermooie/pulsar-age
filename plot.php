<?php

require_once('Config.php');
require_once('Classes/DataFile.php');
require_once('Classes/Identifier.php');
require_once('Classes/CSV.php');

require_once('Classes/jpgraph/jpgraph.php');
require_once('Classes/jpgraph/jpgraph_line.php');
require_once('Classes/jpgraph/jpgraph_error.php');

define('NUMBER_OF_CSV_COLUMNS', 4);

$smarty = new Smarty();
$smarty->template_dir = SMARTY_TEMPLATE_DIR;
$smarty->compile_dir = SMARTY_COMPILE_DIR;

$pulsar_name = $_REQUEST['pulsar'];
// TODO: verify pulsar name

$id = Identifier::GetId();
// TODO: verify id 

CreatePlotCsvFile($pulsar_name, $id, TRUE);
CreatePlotSlopeRemovedCsvFile($id, TRUE);

$csv_filename = SESSION_DIR . "period_vs_mjd_$id.csv";
$plot_filename = SESSION_DIR . "period_vs_mjd_$id.png";
CreatePeriodVsPlot($pulsar_name, $csv_filename, $plot_filename);

$csv_filename = SESSION_DIR . "period_vs_mjd_line_removed_$id.csv";
$plot_filename = SESSION_DIR . "period_vs_mjd_line_removed_$id.png";
CreatePeriodVsPlot($pulsar_name, $csv_filename, $plot_filename);

$smarty->assign('pulsar_name', $pulsar_name);
$smarty->assign('id', $id);
$smarty->display('plot.tpl');

/**
 * Reads Observations/<$pulsar name>/*.dat to extract period, period error, and MJD.
 * Creates a plot as sessions/period_vs_mjd_id.blah
 *
 * Throws any error encountered???
 */
function CreatePeriodVsPlot($pulsar_name, $csv_filename, $plot_filename)
{
// Read session/period_vs_mjd_<id>.csv.
if (!file_exists($csv_filename)) {
  throw Error();
}

$fh = fopen($csv_filename, 'r');
while (($data = fgetcsv($fh, 1000, ',')) !== FALSE) {
  $num = count($data);
  if ($num !== NUMBER_OF_CSV_COLUMNS) {
    throw Error();
  }

  $period_and_errors[] = $data[CSV_INDEX::$PERIOD];
  $period_and_errors[] = $data[CSV_INDEX::$PERIOD_ERROR];
  $MJDs[]              = $data[CSV_INDEX::$MJD];
}

  $filename = "session/period_vs_mjd_$id.png";
  $title    = 'Period vs MJD';
  CreatePlot($period_and_errors, $MJDs, $title, $plot_filename);
}

/**
 * Creates a CSV file containing plot values (period, period error, MJD, toggle).
 * Saves the file as session/period_vs_mjd_<id>.csv.
 */
function CreatePlotCsvFile($pulsar_name, $id, $overwrite = FALSE)
{
  $csv_file = SESSION_DIR . "period_vs_mjd_$id.csv";

  if (file_exists($csv_file) && $overwrite == FALSE) {
    return;
  }

  // Extract data from each .dat file. - DataFile::GetValues(...)
  $directory = OBSERVATIONS_DIR . $pulsar_name . '/';
  $data_filenames = glob($directory . '*.dat');

  foreach ($data_filenames as $filename) {
    $data_files_contents[] = 
      DataFile::GetValues($filename);
  }

  // QUICK FIX: convert errors to the same unit as period
  // (Bug in pdmp.)
  $fp = fopen($csv_file, 'w');
  foreach ($data_files_contents as $data) {
    $fields = array(
      $data->period, 
      $data->period + ($data->period_error * 1000.0 / 2.0),
      $data->MJD, 
      '1' // toggle
    );
    fputcsv($fp, $fields);
  }
  fclose($fp);
}

/**
 * Creates a CSV file containing plot values (period, period error, MJD,
 * toggle). The slope of the line is removed.
 *
 * Saves the file as session/period_vs_mjd_line_removed_<id>.csv.
 */
function CreatePlotSlopeRemovedCsvFile($id, $overwrite = FALSE)
{
  $original_csv_file = SESSION_DIR . "period_vs_mjd_$id.csv";
  $csv_file = SESSION_DIR . "period_vs_mjd_line_removed_$id.csv";


  // TODO: check if original csv file exists.
  $fh = fopen($original_csv_file, 'r');
  // Read period, period error, and MJD for each observation.
  while (($data = fgetcsv($fh, 1000, ',')) !== FALSE) {
    $num = count($data);
    if ($num !== NUMBER_OF_CSV_COLUMNS) {
      throw Error();
    }

    $periods[]       = $data[CSV_INDEX::$PERIOD];
    $period_errors[] = ($data[CSV_INDEX::$PERIOD_ERROR] -
      $data[CSV_INDEX::$PERIOD]);
    $MJDs[]          = $data[CSV_INDEX::$MJD];
  }

  fclose($fh);

  $S = 0.0;
  $Sx = 0.0;
  $Sy = 0.0;
  $Sxx = 0.0;
  $Sxy = 0.0;

  $count = count($periods);
  for ($i = 0; $i < $count; $i++) {
    $period = $periods[$i];
    $error  = $period_errors[$i];
    $mjd    = $MJDs[$i];

    $S += 1/pow($error, 2);

    $Sx += $mjd/pow($error, 2);
    $Sy += $period/pow($error, 2);

    $Sxx += ($mjd * $mjd)/pow($error, 2);
    $Sxy += ($mjd * $period) / pow($error, 2);
  }

  $delta = ($S * $Sxx) - pow($Sx, 2);
  $a = (($Sxx * $Sy) - ($Sx * $Sxy)) / $delta;
  $b = (($S * $Sxy) - ($Sx * $Sy)) / $delta;

  // Subtract the slope from the period.
  for ($i = 0; $i < $count; $i++) {
    $y = $a + ($b * $MJDs[$i]);
    $periods[$i] -= $y;
  }

  // Write the new values into session/period_vs_mjd_line_removed_<id>.csv.
  $fp = fopen($csv_file, 'w');
  for ($i = 0; $i < $count; $i++) {
    $fields = array(
      $periods[$i],
      $periods[$i] + ($period_errors[$i] / 2.0), 
      $MJDs[$i],
      '1' // toggle
    );

    fputcsv($fp, $fields);
  }
  fclose($fp);
}

/**
 * Creates a png ($filename) using the arrays for x and y data passed.
 */
function CreatePlot($errdatay, $datax, $title, $filename)
{
  $graph = new Graph(900,500);
  $graph->SetScale("linlin");

  $graph->img->SetMargin(70,70,40,40);
  $graph->SetShadow();

  $errplot = new ErrorLinePlot($errdatay, $datax);
  $errplot->SetColor("red");
  $errplot->SetWeight(2);
  $errplot->SetCenter();
  $errplot->line->SetWeight(2);
  $errplot->line->SetColor("blue");

  // Setup the legends
  //$errplot->SetLegend("Period Error");

  $graph->title->Set($title);
  $graph->title->SetFont(FF_FONT1,FS_BOLD);

  $graph->xaxis->SetTickLabels($MJDs);

  $graph->Add($errplot);

  $graph->Stroke($filename);
}

?>
