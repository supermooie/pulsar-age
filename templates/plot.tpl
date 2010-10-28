{* Display various plots for observations of a pulsar *}

{include file="header.tpl" title={$pulsar_name}}

{* Information *}
<div id="box">
<p> As displayed in the previous page <i>(make this a link???)</i>, each observation <i>(define observation???)</i> of {$pulsar_name} has two parameters associated with the obseration:
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

{* Detail the process of how to calculate the pulsar's age *}
<div id="text-box">
<h3>Calculating the Age of {$pulsar_name}</h3>

<p>The method we're going to use in order to calculate the distance to {$pulsar_name} is:

<pre> age(s) = P(s) / 2 * pDot(s) </pre>

<p> Your job will be to reach the stage where we can plug in the appropriate numbers to the aforementioned formula and find out the age of {$pulsar_name}.

<p>The plot above displays all observations of {$pulsar_name} taken by various schools that have participated in the PULSE@Parkes program. Each vertical red line corresponds to an observation. The line denotes the period of {$pulsar_name} and period error at the time directly below on the x-axis. The time and date of the plotted observations are recorded as a MJD&mdash;basically, a unit for time (mousehover for further info???).

<p>From school, you may have heard of how to calculate a gradient of a straight line. 

<pre> rise / run = (y2 - y1) / (x2 - x1) </pre>

<p>The gradient of the straight blue line is {$period_derivative_days}. Paying attention to the units of the x- and y-axis, you'll see that the units for the x-axis is in seconds (I KNOW IT'S NOT YET, BUT IT WILL BE) and the units for the y-axis is in days (THIS REALLY IS IN DAYS, BUT IT'S NOT OBVIOUS).

<p>Also from school, you may have also heard of the equation of a straight line

<pre> y = mx + b </pre>

<p>We can use this equation calcalate the value of pDot(s). Recall that we have the periods of {$pulsar_name} plotted along the y-axis (the red lines) and how we have MJD (time) along the x-axis. We can substitute these variables to get:

<pre> P(s) = mt + c </pre>

<p>And notice that (NEED MORE WORDS HERE!):

<pre>pDot(s) = m </pre>

<p>Notice that in the initial formula pDot needs to be in seconds. So far, we have our gradient of {$period_derivative_days} in seconds per day. Convert this value such that the gradient is in seconds per second (pDot(s)). (Hint: how many seconds are there in a day?)

<p><i>Students to multiply original number by 86400. Add text field entry in here - calculate how close they were. Only allow them to continue (hide the following text?) if they're within a certain threshold.</i>

<p>Well done on successfully converting from seconds per day to seconds per seconds and determining the value of pDot(s)!

<p>In the initial formula to calculate a pulsar's age, we can substitude any observed period (in seconds) and determine the age to {$pulsar_name}.

<pre> age(s) = A random period(s) / 2 * {$period_derivative_seconds} </pre>

Once again, having a length amount of time in seconds isn't such a great unit. Let's convert our age (in seconds) into an age in megayears. (Hint: how many seconds are there in a year?)

<p><i>Students to multiply original number by 86400 * 365.24 * 10^6. Add text field entry in here - calculate how close they were.</i>

</div>


<div id="box">
<img src="session/period_vs_mjd_line_removed_{$id}.png"/>
</div>

{include file="footer.tpl"}
