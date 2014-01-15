window.feedback = ->
  rules =
    rules:
      'feedback[name]': 'required'
      'feedback[phone]': 'required'
      'feedback[email]': 'email'
    messages:
      'feedback[name]': 'Введите свое имя'
      'feedback[phone]': 'Введите свой телефон'
      'feedback[email]': 'Введите свой e-mail в правильном формате'

  $('#new_feedback').validate(rules)

  options =
    beforeSubmit:  -> $('#new_feedback').valid()
    success: ->
      $( "#dialog_load" ).dialog( "close" )
      $( "#dialog_ready" ).dialog( "open" )
    error: ->
      $( "#dialog_load" ).dialog( "close" )
      $( "#dialog_error" ).dialog( "open" )
    clearForm: true
    resetForm: true

  $('#new_feedback').submit ->
    $( "#dialog_load" ).dialog( "open" ) if $('#new_feedback').valid()
    $(this).ajaxSubmit(options)
    false

  $('#new_feedback').ajaxForm(options)

  $( "#dialog_load" ).dialog({ modal: true, autoOpen: false, width: 500 })
  $( "#dialog_ready, #dialog_error" ).dialog({ modal: true, autoOpen: false, buttons: { OK: -> $( this ).dialog( "close" )  }, width: 500 })