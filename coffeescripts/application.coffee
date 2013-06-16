class Orientation
  constructor: (orientationEvent) ->
    @x = event.originalEvent.beta # -90 ~ 90
    @y = event.originalEvent.gamma # -180 ~ 180
    @z = event.originalEvent.alpha # 0 ~ 360

class PerspectiveBackground
  constructor: ->
    $(window).on 'deviceorientation.pb.init', (event) =>
      @initialOrientation = new Orientation(event.originalEvent)
      @init()
      $(window).off '.pb.init'

  init: ->
    $(window).on 'deviceorientation.pb', (event) =>
      currentOrientation = new Orientation(event.originalEvent)

