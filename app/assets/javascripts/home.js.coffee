currentGroup = 0
currentPost = 0
currentUser = 0

$('#nav-title-span').live('click', (e) ->
  $('#groups-area').toggle()
)

$('html').click( (e) ->
  if e.target.id != 'nav-title-span'
    $('#groups-area').hide()
)


$('#post_post_type_id')
  .live('change', () ->
    if $(this).val() > 1
      url = "/posts/ui/#{$(this).val()}"
      $.get(url, {}, (html) ->
        $('#share-add-ui').html(html)
      )
    else
      $('#share-add-ui').html('')
  )

$('#share-message')
  .live('click touchstart', () ->
    $('#share-message').hide()
    $('#share-active').slideDown('fast', ->
      $('#share-type').show()
      $('#share-as').show()
      $('#share-to').show()
      $('#share-button').show()
      $('#share-close').show()
      $('#post_content').autogrow()
      $('#to_groups').tokenInput("/g/search")
      $('#post_content').focus()
    )
  )

@resetShareArea = resetShareArea = () ->
  $('#share-message').show()
  $('#share-active').hide()
  $('#share-type').hide()
  $('#share-as').hide()
  $('#share-button').hide()
  $('#share-close').hide()
  $('#post_content').val('')
  $('#share-add-ui').html('')
  $('#post_post_type_id').val(1)

$('#share-close')
  .live('click', () ->
    resetShareArea()
  )

$('#new_post')
    .live("ajax:beforeSend", (evt, xhr, settings) ->
      # TODO: Display geting spinner
      clearInterval(recentTimer)
    )
    .live("ajax:success", (evt, data, status, xhr) ->
      res = $.parseJSON(xhr.responseText);
      resetShareArea()
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
    $(html).prependTo('#posts-area')
    $("#post-" + id).delay(200).fadeIn('slow')
  )

getShareForm = () ->
  url = '/posts/share_form'
  $.get(url, {}, (html) ->
    $('<div id="share-area"></div>').prependTo("#container")
    $('#share-area').prepend(html)
  )

getGroupList = () ->
  url = '/g/list'
  $.get(url, {}, (html) ->
    $('#nav').html(html)
  )

getPosts = () -> 
  url = '/posts/recent'
  if currentGroup > 0
    url = url + '/g/' + currentGroup
  $.get(url, {}, (html) ->
    #$('<div id="posts-area"></div>').appendTo("#container")
    $('#posts-area').html(html)
    $container = $('#posts')
    $container.imagesLoaded( () ->
      $container.masonry({ itemSelector: '.post', columnWidth: $('.post').width() + 20 })
    )
  )

getComments = (post_id) ->
  url = "/posts/#{post_id}/comments/#{$("#post-#{post_id}").attr('last_comment')}"
  $.get(url, {}, (html) ->
    $(html).appendTo("#post-#{post_id}-comments")
  )


$('.comment-textarea')
  .live('click', () ->
    $(this).height('48px')
    $('#posts').masonry('reload')
    $(this).autogrow()
    $("#comment_button_#{$(this).attr('post_id')}").show()
    $("#comment-cancel-#{$(this).attr('post_id')}").show()
  )

$('.comment-form')
  .live("ajax:beforeSend", (evt, xhr, settings) ->
    # TODO: Display geting spinner
  )
  .live("ajax:success", (evt, data, status, xhr) ->
    res = $.parseJSON(xhr.responseText);
    getComments(res['post_id'], res['id'])
    resetCommentArea(res['post_id'])
  )
  .live('ajax:complete', (evt, xhr, status) ->
    # Complete
  )
  .live("ajax:error", (evt, xhr, status, error) ->
    # TODO: Display errors
  )

resetCommentArea = (post_id) ->
  $("#comment_content_#{post_id}").height('24px')
  $("#comment_content_#{post_id}").val('')
  $("#comment_button_#{post_id}").hide()
  $("#comment-cancel-#{post_id}").hide()

$('.comment-cancel')
  .live("click", () ->
    resetCommentArea($(this).attr('post_id'))
  )


@getRecentPosts = getRecentPosts = () ->
  url = '/posts/recent/'
  if currentGroup > 0
    url = url + 'g/' + currentGroup + '/'
  if latestPostId?
    url = url + latestPostId
  $.get(url, {}, (html) ->
    $('#new-posts-message').remove()
    $container = $('#posts')
    #$(html).prependTo('#posts-area')
    $container.prepend(html).masonry('reload')
    $('.hide-me.post').fadeIn()
  )


getRecentPostsCounter = () ->
  url = '/posts/recent/counter/'
  if (currentGroup > 0)
    url = url + 'g/' + currentGroup + '/'
  url = url + latestPostId
  $.get(url, {}, (html) ->
    $('<div id="new-posts-message"></div>').prependTo("#posts-area") if $('#new-posts-message').length == 0
    $('#new-posts-message').html(html).show() if (html != '0')
  )

$('#new-posts-message')
  .live('click touchstart', () ->
    getRecentPosts()
  )

$('.get-group')
  .live('ajax:success', (data, status, xhr) ->
    window.location.hash = '#!/g/' + $(this).attr('short_name')
    $("#li_group_#{currentGroup}").removeClass('selected')
    currentGroup = $(this).attr('group_id')
    $('#container').html(status);
    $("#li_group_#{currentGroup}").addClass('selected')
    title = $("#group_link_#{currentGroup}").html()
    $('#nav-title-span').html(title)
    $('#nav-title-span').removeClass('font-20')
    $('#nav-title-span').removeClass('font-22')
    if (title.length > 20) 
      $('#nav-title-span').addClass('font-16')
    else
      $('#nav-title-span').addClass('font-22')
    getPosts()
    getGroupBrick(currentGroup)
  )

$('.get-page')
  .live('ajax:success', (data, status, xhr) ->
    window.location.hash = '#!/g/' + $(this).attr('group_name') + '/' + $(this).attr('short_name')
    $('.page-title').removeClass('selected')
    $('#posts-area').html(status);
    $('#li_page_' + $(this).attr('page_id')).addClass('selected')
  )

$('#add_page')
    .live("ajax:beforeSend", (evt, xhr, settings) ->
      # TODO: Display spinner
    )
    .live("ajax:success", (evt, data, status, xhr) ->
      res = $.parseJSON(xhr.responseText)
      url = '/g/' + currentGroup + '/page_list'
      $.get(url, {}, (html) ->
        $("#pages-list").html(html)
        $("#page_link_" + res['id']).click()
      )
      $('#edit-page').hide()
      $('#group-page').show()
      $('#page-toolbar').show()
    )
    .live('ajax:complete', (evt, xhr, status) ->
      # Complete
    )
    .live("ajax:error", (evt, xhr, status, error) ->
      # TODO: Display errors
    )



getGroupBrick = (group) ->
  #$("#right-sidebar-content").html('')
  #url = '/g/' + group + '/members'
  #$.get(url, {}, (html) ->
  #  $("#right-sidebar-content").append(html)
  #  url = '/g/' + group + '/page_list'
  #  $.get(url, {}, (html) ->
  #    $("#right-sidebar-content").append(html)
  #  )
  #)

$('.get-post') 
  .live('ajax:success', (data, status, xhr) ->
    window.location.hash = '#!/p/' + $(this).attr('post_id')
    currentPost = $(this).attr('post_id')
    $('#container').html(status);
  )

$('.get-user')
  .live('ajax:success', (data, status, xhr) ->
    username =  $(this).attr('username')
    window.location.hash = '#!/' + username
    currentUsername = username
    $('#container').html(status)
  )

$('#get-home')
  .live('click', () ->
    getHome(true)  
  )

$('#brand')
  .live('click', () ->
    getHome(true)  
  )

getUpcomingEvents = () ->
  url = '/events/upcoming'
  $.get(url, {}, (html) ->
    $('#upcoming-events').append(html)
  )

getUpcomingBirthdays = () ->
  url = '/users/upcoming_birthdays'
  $.get(url, {}, (html) ->
    $('#upcoming-birthdays').append(html)
  )



$('#share-block')
  .live('click', () ->
    getShareForm()
  )


populateHome = () ->
  $('.group-title').removeClass('selected')
  $('.home-link').addClass('selected')
  $('#nav-title-span').html($('#get-home').html())
  getPosts()
  getUpcomingEvents()
  getUpcomingBirthdays()

getHome = (reload) ->
  #window.history.pushState('', document.title, window.location.pathname)
  currentGroup = 0
  currentPost = 0
  currentUser = 0
  if (reload) 
    url = '/home/index'
    $.get(url, {}, (html) ->
      $("#container").html(html)
      populateHome()
    )
  else
    populateHome()

$ ->
  getGroupList()
  getHome(false)

recentTimer = setInterval(getRecentPostsCounter, 10000)


