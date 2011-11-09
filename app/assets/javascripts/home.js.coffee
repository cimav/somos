$('#share-message')
  .live('click', () ->
    $('#share-active').show();
    $('#share-message').hide();
  )

loadGroupList = () ->
  url = '/groups/list'
  $.get(url, {}, (html) ->
    $('#left-sidebar-inner').html(html);
  )

$('.get-group')
  .live('ajax:success', (data, status, xhr) ->
    window.location.hash = '#!/group/' + $(this).attr('short_name')
    $('#main-inner').html(status);
  )

$ ->
  loadGroupList()
