$('#share-message')
  .live('click touchstart', () ->
    $('#share-message').hide()
    $('#share-active').slideDown('fast', ->
      $('#share-type').show()
      $('#share-as').show()
      $('#share-button').show()
      $('#share-close').show()
      $('#post_content').autogrow()
      $('#post_content').focus()
    )
  )


hideShareArea = () ->
  $('#share-message').show()
  $('#share-active').hide()
  $('#share-type').hide()
  $('#share-as').hide()
  $('#share-button').hide()
  $('#share-close').hide()
  $('#post_content').val('')

$('#share-close')
  .live('click', () ->
    hideShareArea()
  )

$('#new_post')
    .live("ajax:beforeSend", (evt, xhr, settings) ->
      # TODO: Display loading spinner
    )
    .live("ajax:success", (evt, data, status, xhr) ->
      hideShareArea()
    )
    .live('ajax:complete', (evt, xhr, status) ->
      # Complete
    )
    .live("ajax:error", (evt, xhr, status, error) ->
      # TODO: Display errors
    )


loadGroupList = () ->
  url = '/groups/list'
  $.get(url, {}, (html) ->
    $('#left-sidebar-inner').html(html)
  )

loadRecentPosts = () -> 
  url = '/posts/recent'
  $.get(url, {}, (html) ->
    $('#posts-area').html(html)
  )

$('.get-group')
  .live('ajax:success', (data, status, xhr) ->
    window.location.hash = '#!/g/' + $(this).attr('short_name')
    $('#main-inner').html(status);
  )

getHome = () ->
  loadGroupList()
  loadRecentPosts()

$ ->
  getHome()
