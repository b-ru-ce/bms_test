$(document).bind 'page:change', ->
  $.fancybox.init()

ready = ->
  $('.gallery').fancybox()

$(document).ready(ready)
$(document).on('page:load', ready)