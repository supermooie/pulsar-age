{* Display pulse profiles for all observations of a pulsar *}

{include file="header.tpl" title=${pulsar_name}}

<div id="box">
<p> Displayed below are the individual pulse profiles of previous {$pulsar_name} observations. Let's take a moment to understand what these parameters are.

<ul>
<li><b>MJD (days)</b>: The Modified Julian Date (LINK HERE) is what astronomers use to count days. Basically, it's the number of days since 17 November, 1858. </li>
<li><b>Period (ms)</b>: The amount of time taken for {$pulsar_name} to make one complete rotation. <i>(Change this to seconds.)</i></li>
<li><b>Period Error (ms)</b>: How accurate the actual period value is. (Smaller is better.)</li>
</ul>

<p> The next stage of the module is a plot XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 

<p> It is important to note that the MJD values here&mdash;and in the upcoming plot&mdash;are in units of days. You may recall that one of the parameters required, pDot(s), needs to be in seconds, so we'll need to do a quick conversion to make this correct.
</div>

<div id="box">
{section name=mysec loop=$observations}
{strip}

<div id="pulsar_box">
<table class="gridtable">
<tr><th>{$observations[mysec].filename}</th><tr>
<tr><td align="center"><img src="{$observations[mysec].profile}" /></td></tr>

<tr><td align="center">
<table class="inner_gridtable">
<tr><td>MJD (days)</td><td>{$observations[mysec].MJD}</td></tr>
<tr><td>Period (ms)</td><td>{$observations[mysec].period}</td></tr>
<tr><td>Period Error (ms)</td><td>{$observations[mysec].period_error}</td></tr>
</table>
</td></tr>

</table>
</div>

{/strip}
{/section}
</div>

<div id="box">
<p><a class="button" href="plot.php?id={$id}&pulsar={$pulsar_name_url}"><span>Plot</span></a>

</div>

{include file="footer.tpl"}
