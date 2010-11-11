{* Display pulse profiles for all PULSE@Parkes pulsars *}

{include file="header.tpl" title="Pulsars"}

{* Table of pulse profiles for each PULSE@Parkes pulsar *}

<div id="box">
<p> What you're looking at is the pulse profile for every PULSE@Parkes pulsar. The pulse profile is simply the shape of the pulsar's bean as it swings by Earth. To make things easier, we want to look for a pulsar that has a single sharp spike&mdash;not a pulsar that is weak (LINK HERE) and/or contains a lot of radio-frequency interference.
</div>

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
