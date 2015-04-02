# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
	$("#card").focus()

	$('#event_date').datepicker({
		dateFormat: "dd-mm-yy"
	})

$(document).ready ->
  oldVal = undefined

  checkLength = (val) ->
    if val.length >= 20
      alert 'Submit!'
    return

  $('#card').bind 'DOMAttrModified textInput input change keypress paste focus', ->
    val = @value
    if val != oldVal
      oldVal = val
      checkLength val
    return
  return

$(document).ready(ready)
$(document).on('page:load', ready)