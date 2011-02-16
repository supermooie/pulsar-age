$(document).ready(function() {
    $('#plot').click(function(e) {
      var relativeX = e.pageX - this.offsetLeft;
      var relativeY = e.pageY - this.offsetTop;

      // Get ID and pulsar name.
      var id = jQuery.url.param("id");
      var pulsarName = jQuery.url.param("pulsar");

      $.get("plot.php", { "shh":1, "id":jQuery.url.param("id"), "pulsar":jQuery.url.param("pulsar"), "x":relativeX },
        function(data){
        var timestamp = new Date().getTime(); 
        $('#plot').attr('src', 'http://pulseatparkes.atnf.csiro.au/age/session/period_vs_mjd_' + id + '.png?' + timestamp);
        });
      });

    $('#plot_submit').click(function(e) {
      var m = $("#m").val();
      var b = $("#b").val();
      var id = jQuery.url.param("id");

      $.get("plot.php", { "shh":1, "id":jQuery.url.param("id"), "pulsar":jQuery.url.param("pulsar"), "m":m, "b":b },
        function(data){
        var timestamp = new Date().getTime(); 
        $('#plot').attr('src', 'http://pulseatparkes.atnf.csiro.au/age/session/period_vs_mjd_' + id + '.png?' + timestamp);
        });

      return false;
    });


    });


