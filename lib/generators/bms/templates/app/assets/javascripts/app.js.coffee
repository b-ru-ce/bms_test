ready = ->
  $('.gallery').fancybox()

$(document).ready(ready)
$(document).on('page:load', ready)