currentGroup = 0
currentPost = 0
currentUser = 0

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
      $('#share-button').show()
      $('#share-close').show()
      $('#post_content').autogrow()
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
    $('<div id="share-area"></div>').prependTo("#main-content")
    $('#share-area').prepend(html)
  )

getGroupList = () ->
  url = '/groups/list'
  $.get(url, {}, (html) ->
    $('#ls-left').html(html)
    $lsb = $("#left-sidebar-content")
    #if parseInt($lsb.css('left'),10) == 0
    $lsb.animate({
      left: 0
    })
    #end
    adjustLeftSidebarHeight()
  )

getPosts = () -> 
  url = '/posts/recent'
  if currentGroup > 0
    url = url + '/g/' + currentGroup
  $.get(url, {}, (html) ->
    $('<div id="posts-area"></div>').appendTo("#main-content")
    $('#posts-area').html(html)
  )

getComments = (post_id) ->
  url = "/posts/#{post_id}/comments/#{$("#post-#{post_id}").attr('last_comment')}"
  $.get(url, {}, (html) ->
    $(html).appendTo("#post-#{post_id}-comments")
  )


$('.comment-textarea')
  .live('click', () ->
    $(this).height('4em')
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
    $(html).prependTo('#posts-area')
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
    $('#main-content').html(status);
    $("#li_group_#{currentGroup}").addClass('selected')
    getPosts()
    getGroupSidebar(currentGroup)
  )

$('.get-page')
  .live('ajax:success', (data, status, xhr) ->
    window.location.hash = '#!/g/' + $(this).attr('group_name') + '/' + $(this).attr('short_name')
    #$("#li_group_#{currentGroup}").removeClass('selected')
    #currentGroup = $(this).attr('group_id')
    $('#main-content').html(status);
    #$("#li_group_#{currentGroup}").addClass('selected')
  )


getGroupSidebar = (group) ->
  $("#right-sidebar-content").html('')
  url = '/groups/' + group + '/members'
  $.get(url, {}, (html) ->
    $("#right-sidebar-content").append(html)
    url = '/groups/' + group + '/page_list'
    $.get(url, {}, (html) ->
      $("#right-sidebar-content").append(html)
    )
  )

$('.get-post') 
  .live('ajax:success', (data, status, xhr) ->
    window.location.hash = '#!/p/' + $(this).attr('post_id')
    currentPost = $(this).attr('post_id')
    $('#main-content').html(status);
  )

$('.get-user')
  .live('ajax:success', (data, status, xhr) ->
    username =  $(this).attr('username')
    window.location.hash = '#!/' + username
    currentUsername = username
    $('#main-content').html(status)
    url = '/' + username + '/sidebar'
    $.get(url, {}, (html) ->
      hideRightSidebar()
      $('#ls-right').html(html)
      $lsb = $("#left-sidebar-content")
      if parseInt($lsb.css('left'),10) == 0
        $lsb.animate({
          #left: if parseInt($lsb.css('left'),10) == 0 then -($lsb.outerWidth()/2) else 0
          left: -($lsb.outerWidth()/2)
        })
      end
    )
  )

$('#get-home')
  .live('click', () ->
    getHome()  
  )

$('#brand')
  .live('click', () ->
    getHome()  
  )

getUpcomingEvents = () ->
  url = '/events/upcoming'
  $.get(url, {}, (html) ->
    $('#right-sidebar-content').append(html)
  )

adjustLeftSidebarHeight = () ->
  $('#left-sidebar').height($('#ls-left').height() + 50)

hideRightSidebar = () ->
  $('#main').addClass('superwide')
  $('#main-content').addClass('superwide')
  $('#right-sidebar').hide()

showRightSidebar = () ->
  $('#main').removeClass('superwide')
  $('#main-content').removeClass('superwide')
  $('#right-sidebar').show()


getHome = () ->
  window.history.pushState('', document.title, window.location.pathname)
  currentGroup = 0
  currentPost = 0
  currentUser = 0
  $("#main-content").html('')
  $("#right-sidebar-content").html('')
  showRightSidebar()
  getGroupList()
  getShareForm()
  getPosts()
  getUpcomingEvents()

$ ->
  getHome()

recentTimer = setInterval(getRecentPostsCounter, 10000)


