currentGroup = 0
currentPost = 0
currentUser = 0
postContentHeight = 0

$('#nav-title-span').live('click', (e) ->
  $('#groups-area').toggle()
)

$('html').click( (e) ->
  if e.target.id != 'nav-title-span'
    $('#groups-area').hide()
)

$('.post-type')
  .live('click', () ->
    $('#post_post_type_id').val($(this).attr('post_type'))
    $('#post-types').hide()
    $('#share-form').dialog('option', 'title', $("#post-type-message-" + $(this).attr('post_type')).html())
    $('#share-content').show()
    url = "/posts/ui/#{$(this).attr('post_type')}"
    $.get(url, {}, (html) ->
      $('#share-add-ui').html(html)
      $('#share-form').dialog('option', 'height', $('#dialog-height').val())
      
      $('#post_content').autogrow()
      postContentHeight = parseInt($('#post_content').css('height'))
      $('#post_group_id').selectmenu()
      $('#to_groups').tokenInput("/g/search", {theme: "somos", zindex: 2000})
      $('#post_content').focus()
    )
  )

$('#post_content')
  .live('resized', () ->
    grow = parseInt($('#post_content').css('height')) - postContentHeight
    $('#share-form').dialog('option', 'height', parseInt($('#dialog-height').val()) + grow)
  )

$('#token-everyone span')
  .live('click', () ->
    $('#token-everyone').hide()
    $('#share-tokens').show()
    $('#token-input-to_groups').focus()
  )

$('#new_post')
    .live("ajax:beforeSend", (evt, xhr, settings) ->
      # TODO: Display geting spinner
      clearInterval(recentTimer)
    )
    .live("ajax:success", (evt, data, status, xhr) ->
      res = $.parseJSON(xhr.responseText);
      getRecentPosts()
      $("#share-form").dialog('close')
      $("#share-form").remove()
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
    $('#container').append(html)
    $("#share-form").dialog({ 
      autoOpen: false, 
      width: 500, 
      height: 300, 
      modal: true, 
      close: (ev, ui) -> 
                $(this).remove()
    })
    $("#share-form").dialog('open')
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
    $('#posts').masonry('reload')
  )


$('.comment-textarea')
  .live('click', () ->
    $(this).height('48px')
    $(this).autogrow()
    $("#comment_button_#{$(this).attr('post_id')}").show()
    $("#comment-cancel-#{$(this).attr('post_id')}").show()
    $('#posts').masonry('reload')
  )

$('.comment-textarea')
  .live('resized', () ->
    $('#posts').masonry('reload')
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
  $('#posts').masonry('reload')

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
