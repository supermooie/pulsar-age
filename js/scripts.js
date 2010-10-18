$(document).ready(function() {

    //$('#position').text(jQuery.url.param("id"));

    $('#plot').click(function(e) {
      var relativeX = e.pageX - this.offsetLeft;
      var relativeY = e.pageY - this.offsetTop;

      // Get ID and pulsar name.
      var id = jQuery.url.param("id");
      var pulsarName = jQuery.url.param("pulsar");

      //$.get("plot.php", { pulsar: jQuery.url.param("pulsar"), id: jQuery.url.param("id")},
      $.get("plot.php", { "shh":1, "id":jQuery.url.param("id"), "pulsar":jQuery.url.param("pulsar"), "x":relativeX },
        function(data){
        //alert("Data Loaded: " + data);
        var timestamp = new Date().getTime(); 
        $('#plot').attr('src', 'http://pulseatparkes.atnf.csiro.au/age/session/period_vs_mjd_' + id + '.png?' + timestamp);
        });

      //$('#position').text("X: " + relativeX + " Y: " + relativeY);
      // e.pageX - gives you X position
      // e.pageY - gives you Y position
      });

    });
