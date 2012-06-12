class Html5Video

  constructor: (@presentz, @videoContainer, @width, @height) ->
    @video = new Video "play", "pause", "ended", @presentz

  changeVideo: (videoData, @wouldPlay) ->
    $(@videoContainer).empty()
    #availableWidth = $(@videoContainer).width()
    videoHtml = "<video id=\"html5player\" controls preload=\"none\" src=\"#{ videoData.url }\" width=\"#{@width}\" height=\"#{@height}\"></video>"
    $(@videoContainer).append(videoHtml)

    playerOptions =
      enableAutosize: false
      timerRate: 500
      success: (me) =>
        this.onPlayerLoaded me
        return

    new MediaElementPlayer("#html5player", playerOptions)
    return

  onPlayerLoaded: (@player) ->
    eventHandler = (event) =>
      this.video.handleEvent event.type
      return
    player.addEventListener("play", eventHandler, false)
    player.addEventListener("pause", eventHandler, false)
    player.addEventListener("ended", eventHandler, false)

    @player.load()

    if @wouldPlay
      if !@presentz.intervalSet
        @presentz.startTimeChecker()
      @player.play()

  adjustSize: () ->
    if @player.height != $("#html5player").height()
      newHeight = $("#html5player").height()
      $(@videoContainer).height(newHeight)
      $(".mejs-container").height(newHeight)
      @player.height = newHeight
    return

  currentTime: () ->
    return @player.currentTime

  skipTo: (time) ->
    if @player and @player.currentTime
      @player.setCurrentTime(time)
      return true
    return false