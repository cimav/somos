# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
liveSearch = () -> 
  return false if $("#search-input").val().length < 3
  form = $("#live-search")
  url = "/search"
  formData = form.serialize()
  $.get(url, formData, (html) ->
    $("#search-results").html(html)
    $("#search-results").show()
  )

$("#search-input")
  .live("keyup", () ->
    liveSearch() 
  )
  .live("click", () ->
    liveSearch() 
  )


