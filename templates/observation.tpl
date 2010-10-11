{* Display pulse profiles for all observations of a pulsar *}

{include file="header.tpl" title=${pulsar_name}}

<div id="box">
<p> Information...
</div>

<div id="box">
{section name=mysec loop=$observations}
{strip}

<div id="pulsar_box">
<table class="gridtable">
<tr><th>{$observations[mysec].filename}</th><tr>
<tr><td><img src="{$observations[mysec].profile}" /></td></tr>

<tr><td align="center">
<table class="inner_gridtable">
<tr><td>MJD</td><td>{$observations[mysec].MJD}</td></tr>
<tr><td>Period</td><td>{$observations[mysec].period}</td></tr>
<tr><td>Period Error</td><td>{$observations[mysec].period_error}</td></tr>
</table>
</td></tr>

</table>
</div>

{/strip}
{/section}
</div>

<div id="box">
<p><a href="plot.php?id={$id}&pulsar={$pulsar_name}">Plot</a>

</div>

{include file="footer.tpl"}
