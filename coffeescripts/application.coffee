class Orientation
  constructor: (orientationEvent) ->
    @x = orientationEvent.beta # -90 ~ 90
    @y = orientationEvent.gamma # -180 ~ 180
    @z = orientationEvent.alpha # 0 ~ 360

  interpret: (initialOrientation) ->
    diffVertical = @x - initialOrientation.x  # positive => go up
    diffHorizontal = @y - initialOrientation.y  # positive => go left

    bgTranslateY = diffVertical / 180 * -15
    bgTranslateX = diffHorizontal / 180 * -15

    return "translateX(#{bgTranslateX}%) translateY(#{bgTranslateY}%)"

class PerspectiveBackground
  constructor: ->
    $(window).on 'deviceorientation.pb.init', (event) =>
      @initialOrientation = new Orientation(event.originalEvent)
      @init()
      $(window).off '.pb.init'

  init: ->
    $(window).on 'deviceorientation.pb', (event) =>
      currentOrientation = new Orientation(event.originalEvent)
      interpretation = currentOrientation.interpret(@initialOrientation)
      $('.perspective-background').css('transform', interpretation)

$ ->
  pb = new PerspectiveBackground()
