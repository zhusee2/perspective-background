class Orientation
  constructor: (orientationEvent) ->
    @x = orientationEvent.beta # -90 ~ 90
    @y = orientationEvent.gamma # -180 ~ 180
    @z = orientationEvent.alpha # 0 ~ 360

  interpret: (initialOrientation) ->
    diffX = @x - initialOrientation.x  # positive => go up
    diffY = @y - initialOrientation.y  # positive => go left

    bgDeltaX = diffX / 180 * 50 + 50
    bgDeltaY = (diffY / 180 * 50) + 50

    return "#{bgDeltaY}% #{bgDeltaX}%"

class PerspectiveBackground
  constructor: ->
    $(window).on 'deviceorientation.pb.init', (event) =>
      @initialOrientation = new Orientation(event.originalEvent)
      @init()
      $(window).off '.pb.init'

  init: ->
    $(window).on 'deviceorientation.pb', (event) =>
      currentOrientation = new Orientation(event.originalEvent)
      console.log interpretation = currentOrientation.interpret(@initialOrientation)
      $('body').css('background-position', interpretation)

$ ->
  pb = new PerspectiveBackground()
