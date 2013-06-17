(function() {
  var Orientation, PerspectiveBackground;

  Orientation = (function() {

    function Orientation(orientationEvent) {
      this.x = orientationEvent.beta;
      this.y = orientationEvent.gamma;
      this.z = orientationEvent.alpha;
    }

    Orientation.prototype.interpret = function(initialOrientation) {
      var bgTranslateX, bgTranslateY, diffHorizontal, diffVertical;
      diffVertical = this.x - initialOrientation.x;
      diffHorizontal = this.y - initialOrientation.y;
      bgTranslateY = diffVertical / 180 * -25;
      bgTranslateX = diffHorizontal / 180 * -25;
      return "scale(2) translateX(" + bgTranslateX + "%) translateY(" + bgTranslateY + "%)";
    };

    return Orientation;

  })();

  PerspectiveBackground = (function() {

    function PerspectiveBackground() {
      var _this = this;
      $(window).on('deviceorientation.pb.init', function(event) {
        _this.initialOrientation = new Orientation(event.originalEvent);
        _this.init();
        return $(window).off('.pb.init');
      });
    }

    PerspectiveBackground.prototype.init = function() {
      var _this = this;
      return $(window).on('deviceorientation.pb', function(event) {
        var currentOrientation, interpretation;
        currentOrientation = new Orientation(event.originalEvent);
        interpretation = currentOrientation.interpret(_this.initialOrientation);
        return $('.perspective-background').css('transform', interpretation);
      });
    };

    return PerspectiveBackground;

  })();

  $(function() {
    var pb;
    return pb = new PerspectiveBackground();
  });

}).call(this);
