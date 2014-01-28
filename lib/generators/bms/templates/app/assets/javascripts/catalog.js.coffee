setGetParameter= (array) ->
  url = window.location.href

  for el in array
    paramName = el.name
    paramValue = el.value

    unless paramName =='utf8' or paramName == 'authenticity_token'
      if url.indexOf(paramName + "=") >= 0
        prefix = url.substring(0, url.indexOf(paramName))
        suffix = url.substring(url.indexOf(paramName)).substring(url.indexOf("=") + 1)
        suffix = if suffix.indexOf("&") >= 0 then suffix.substring(suffix.indexOf("&")) else ""
        url = prefix + paramName + "=" + paramValue + suffix
      else
        if (url.indexOf("?") < 0)
          url += "?" + paramName + "=" + paramValue
        else
          url += "&" + paramName + "=" + paramValue

  window.location.href = url

window.catalog = ->
  $('#clear_filters').click ->
    window.location.href = location.pathname
    false

  $('#filters').submit ->
    array = $( this ).serializeArray()
    setGetParameter(array)
    false