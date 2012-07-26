# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('.like-post')
  .live("ajax:beforeSend", (evt, xhr, settings) ->
  )
  .live("ajax:success", (evt, data, status, xhr) ->
    res = $.parseJSON(xhr.responseText)
    post_id = $(this).attr('post_id')
    $("#post-like-message-span-" + post_id).html(res['like_msg'])

    if res['like_msg'] == ''
      $("#post-like-message-" + post_id).hide()
    else
      $("#post-like-message-" + post_id).show()

    $("#post-like-" + post_id).html(res['link_like'])
  )
  .live('ajax:complete', (evt, xhr, status) ->
  )
  .live("ajax:error", (evt, xhr, status, error) ->
    alert('Error')
  )
