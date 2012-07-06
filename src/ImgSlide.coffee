class ImgSlide

  constructor: (@slideContainer) ->
    @preloadedSlides = []

  changeSlide: (slide) ->
    if $("#{@slideContainer} img").length == 0
      slideContainer = $(@slideContainer)
      slideContainer.empty()
      slideContainer.append("<table height=\"100%\"><tr><td valign=\"middle\"><img width=\"100%\" height=\"100%\" src=\"#{slide.url}\"></td></tr></table>")
    else
      $("#{@slideContainer} img")[0].setAttribute("src", slide.url)
    return

  preload: (slides) ->
    images = []
    for slide in slides when !(slide.url in @preloadedSlides)
      image = new Image()
      image.src = slide.url
      images.push image
      @preloadedSlides.push slide.url
    return images
