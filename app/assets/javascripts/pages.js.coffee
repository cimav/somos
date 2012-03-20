# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$('#edit-page-button')
  .live('click', () ->
    $('#group-page-contents').hide()
    $('#page-toolbar').hide()
    $('#edit-page').fadeIn()
  )

$('#edit_page_form')
    .live("ajax:beforeSend", (evt, xhr, settings) ->
      # TODO: Display saving spinner
    )
    .live("ajax:success", (evt, data, status, xhr) ->
      res = $.parseJSON(xhr.responseText)
      $("#page_link_" + res['id']).html(res['title'])
      $("#page_link_" + res['id']).attr('short_name', res['short_name'])
      $("#page_link_" + res['id']).click();
      $('#edit-page').hide()
      $('#group-page').fadeIn()
      $('#page-toolbar').show()
    )
    .live('ajax:complete', (evt, xhr, status) ->
      # Complete
    )
    .live("ajax:error", (evt, xhr, status, error) ->
      # TODO: Display errors
    )
