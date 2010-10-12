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
<img src="session/period_vs_mjd_{$id}.png"/>
</div>

<div id="box">
<img src="session/period_vs_mjd_line_removed_{$id}.png"/>
</div>

{include file="footer.tpl"}
