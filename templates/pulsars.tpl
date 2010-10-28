{* Display pulse profiles for all PULSE@Parkes pulsars *}

{include file="header.tpl" title="Pulsars"}

{* Table of pulse profiles for each PULSE@Parkes pulsar *}

<p> Information...

{section name=mysec loop=$pulsars}
{strip}

<div id="pulsar_box">
<table class="gridtable">
<tr><th>{$pulsars[mysec].name}</th><tr>
<tr><td><a href="observation.php?id={$id}&pulsar={$pulsars[mysec].name_url}"><img src="{$pulsars[mysec].profile}" /></a></td></tr>

<tr><td align="center">
<table class="inner_gridtable">
<tr><td>Total Observations<td>{$pulsars[mysec].n_observations}</th><td>
</table>
</td></tr>
</table>

</div>

{/strip}
{/section}

{include file="footer.tpl"}
