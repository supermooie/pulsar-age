{* Display pulse profiles for all PULSE@Parkes pulsars *}

{include file="header.tpl" title="Pulsars"}

{* Table of pulse profiles for each PULSE@Parkes pulsar *}

{section name=mysec loop=$pulsars}
{strip}

<div id="pulsar_box">
<table class="gridtable">
<tr><th>{$pulsars[mysec].name}</th><tr>
<tr><td><a href="{$next_page}?id={$id}&pulsar={$pulsars[mysec].name}"><img src="{$pulsars[mysec].profile}" /></a></td></tr>
</table>
</div>

{/strip}
{/section}

{include file="footer.tpl"}
