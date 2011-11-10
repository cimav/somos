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

$('#share-close')
  .live('click', () ->
    $('#share-message').show()
    $('#share-active').hide()
    $('#share-type').hide()
    $('#share-as').hide()
    $('#share-button').hide()
    $('#share-close').hide()
  )
    

loadGroupList = () ->
  url = '/groups/list'
  $.get(url, {}, (html) ->
    $('#left-sidebar-inner').html(html)
  )

$('.get-group')
  .live('ajax:success', (data, status, xhr) ->
    window.location.hash = '#!/group/' + $(this).attr('short_name')
    $('#main-inner').html(status);
  )

$ ->
  loadGroupList()
