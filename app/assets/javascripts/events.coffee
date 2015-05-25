# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

showCalendar = (e) ->
  $('#calendar').fullCalendar({
    events: '/events.json'
  })

$(document).ready showCalendar
