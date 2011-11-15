currentGroup = 0

$('#post_post_type_id')
  .live('change', () ->
    url = '/posts/ui/' + $(this).val()
    $.get(url, {}, (html) ->
      $('#share-add-ui').html(html)
    )
  )

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

@hideShareArea = hideShareArea = () ->
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
      # TODO: Display geting spinner
      clearInterval(recentTimer)
    )
    .live("ajax:success", (evt, data, status, xhr) ->
      res = $.parseJSON(xhr.responseText);
      hideShareArea()
      getRecentPosts()
      recentTimer = setInterval(getRecentPostsCounter, 10000)
    )
    .live('ajax:complete', (evt, xhr, status) ->
      # Complete
    )
    .live("ajax:error", (evt, xhr, status, error) ->
      # TODO: Display errors
    )

getPost = (id) ->
  url = '/posts/' + id
  $.get(url, {}, (html) ->
    $(html).hide().prependTo('#posts-area')
    $("#post-" + id).delay(200).fadeIn('slow')
  )

getShareForm = () ->
  url = '/posts/share_form'
  $.get(url, {}, (html) ->
    $('#share-area').html(html)
  )

getGroupList = () ->
  url = '/groups/list'
  $.get(url, {}, (html) ->
    $('#left-sidebar-inner').html(html)
  )

getPosts = () -> 
  url = '/posts/recent'
  if (currentGroup > 0)
    url = url + '/g/' + currentGroup
  $.get(url, {}, (html) ->
    $('#posts-area').html(html)
  )

@getRecentPosts = getRecentPosts = () ->
  url = '/posts/recent/'
  if (currentGroup > 0)
    url = url + 'g/' + currentGroup + '/'
  url = url + latestPostId
  $.get(url, {}, (html) ->
    $('#new-posts-message').hide()
    $(html).prependTo('#posts-area')
    $('.hide-me.post').fadeIn()
  )


getRecentPostsCounter = () ->
  url = '/posts/recent/counter/'
  if (currentGroup > 0)
    url = url + 'g/' + currentGroup + '/'
  url = url + latestPostId
  $.get(url, {}, (html) ->
    $('#new-posts-message').html(html).show() if (html != '0')
  )

$('#new-posts-message')
  .live('click touchstart', () ->
    getRecentPosts()
  )

$('.get-group')
  .live('ajax:success', (data, status, xhr) ->
    window.location.hash = '#!/g/' + $(this).attr('short_name')
    currentGroup = $(this).attr('group_id')
    $('#main-inner').html(status);
    getPosts()
  )

getHome = () ->
  getGroupList()
  getShareForm()
  getPosts()

$ ->
  getHome()

recentTimer = setInterval(getRecentPostsCounter, 10000)


