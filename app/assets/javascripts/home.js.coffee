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
      # TODO: Display geting spinner
      clearInterval(recentTimer)
    )
    .live("ajax:success", (evt, data, status, xhr) ->
      res = $.parseJSON(xhr.responseText);
      hideShareArea()
      getRecentPosts()
      recentTimer = setInterval(getRecentPostsCounter, 5000)
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

getGroupList = () ->
  url = '/groups/list'
  $.get(url, {}, (html) ->
    $('#left-sidebar-inner').html(html)
  )

getPosts = () -> 
  url = '/posts/recent'
  $.get(url, {}, (html) ->
    $('#posts-area').html(html)
  )

getRecentPosts = () ->
  url = '/posts/recent/' + latestPostId 
  $.get(url, {}, (html) ->
    $('#new-posts-message').hide()
    $(html).prependTo('#posts-area')
    $('.hide-me.post').fadeIn()
  )


getRecentPostsCounter = () ->
  url = '/posts/recent/counter/' + latestPostId
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
    $('#main-inner').html(status);
  )

getHome = () ->
  getGroupList()
  getPosts()

$ ->
  getHome()

recentTimer = setInterval(getRecentPostsCounter, 5000)
