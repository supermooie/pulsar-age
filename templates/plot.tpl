{* Display various plots for observations of a pulsar *}

{include file="header.tpl" title={$pulsar_name}}

{* Information *}
<div id="box">
<p> As displayed in the previous page <i>(make this a link???)</i>, each observation <i>(define observation???)</i> of {$pulsar_name} have two parameters associated with the obseration:
<ol>
<li> MJD
<li> Period
</ol>
</div>

<div id="box">
<div id="pulsar_box">
<img id="plot" src="session/period_vs_mjd_{$id}.png"/>
</div>

<div id="pulsar_box">
<table class="gridtable">
<tr><td>Period Derivative (s/day)</td><td>{$period_derivative_days}</td></tr>
<tr><td>Period Derivative (s/s)</td><td>{$period_derivative_seconds}</td></tr>
<tr><td>Pulsar Age(s)</td><td>{$pulsar_age_seconds}</td></tr>
<tr><td>Pulsar Age(Myr)</td><td>{$pulsar_age_megayear}</td></tr>
</table>
</div>

</div>

<div id="box">
<img src="session/period_vs_mjd_line_removed_{$id}.png"/>
</div>

{include file="footer.tpl"}
