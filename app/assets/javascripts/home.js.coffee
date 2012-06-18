# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
currentGroup = 0
currentPost = 0
currentUser = 0
postContentHeight = 0
hash = false
lastBlockTop = 0

$('#nav-title-span').live('click', (e) ->
  $('#groups-area').toggle()
)

$('#user-info').live('click', (e) ->
  $('#user-nav').toggle()
)

$('html').click( (e) ->
  if e.target.id != 'user-info'
    $('#user-nav').hide()
  if e.target.id != 'search-results'
    $('#search-input').val('')
    $('#search-results').hide()
)

$('.post-type')
  .live('click', () ->
    $('#post_post_type_id').val($(this).attr('post_type'))
    url = "/p/ui/#{$(this).attr('post_type')}"
    $.get(url, {}, (html) ->
      $('#share-add-ui').html(html)
      $('#post_content').autogrow()
      $('#post-types').hide()
      $('#share-content').fadeIn()
      postContentHeight = parseInt($('#post_content').css('height'))
      $('#post_group_id').selectmenu()
      $('#to_groups').tokenInput("/g/search", {theme: "somos", zindex: 2000, hintText: $('#to_groups').attr('hintMessage'), noResultsText: $('#to_groups').attr('noResultsMessage'), searchingText: $('#to_groups').attr('searchingMessage')})
      $('#post_content').focus()
    )
  )

$('#token-everyone span')
  .live('click', () ->
    $('#token-everyone').hide()
    $('#share-tokens').show()
    $('#token-input-to_groups').focus()
  )

@hideShareForm = hideShareForm = () ->
  getRecentPosts()
  $("#share-form").fadeOut('fast', () ->
    $("#share-form").remove()
  )

$('#new_post')
  .live("ajax:beforeSend", (evt, xhr, settings) ->
    # TODO: Display geting spinner
    clearInterval(recentTimer)
  )
  .live("ajax:success", (evt, data, status, xhr) ->
    res = $.parseJSON(xhr.responseText)
    hideShareForm()
    recentTimer = setInterval(getRecentPostsCounter, 10000)
  )
  .live('ajax:complete', (evt, xhr, status) ->
    # Complete
  )
  .live("ajax:error", (evt, xhr, status, error) ->
    # TODO: Display errors
  )

getPost = (id) ->
  url = '/p/' + id
  $.get(url, {}, (html) ->
    $(html).prependTo('#posts-area')
    $("#post-" + id).delay(200).fadeIn('slow')
    clearInterval(recentTimer)
  )

getShareForm = () ->
  url = '/p/share_form'
  $.get(url, {}, (html) ->
    $('#share-workarea').html(html)
  )

getGroupList = () ->
  url = '/g/list'
  $.get(url, {}, (html) ->
    $('#nav').html(html)
  )

getUserMenu = () ->
  url = '/u/menu'
  $.get(url, {}, (html) ->
    $('#user-area').html(html)
  )



getPosts = () -> 
  url = '/p/recent'
  if currentGroup > 0
    url = url + '/g/' + currentGroup
  $.get(url, {}, (html) ->
    $('#posts-area').html(html)
  )

buildWall = () ->
  $container = $('#posts')
  $container.imagesLoaded( () ->
    $container.masonry({ itemSelector: '.post', columnWidth: $('.post').width() + 20 })
    $('<div class="clearfix"></div>').appendTo("#container")
  )


getComments = (post_id) ->
  url = "/p/#{post_id}/comments/#{$("#post-#{post_id}").attr('last_comment')}"
  $.get(url, {}, (html) ->
    $(html).appendTo("#post-#{post_id}-comments")
    #$('#posts').masonry('reload')
  )


$('.comment-textarea')
  .live('click', () ->
    $(this).height('48px')
    $(this).autogrow()
    $("#comment_button_#{$(this).attr('post_id')}").show()
    $("#comment-cancel-#{$(this).attr('post_id')}").show()
    #$('#posts').masonry('reload')
  )

$('.comment-textarea')
  .live('resized', () ->
    #$('#posts').masonry('reload')
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
  #$('#posts').masonry('reload')

$('.comment-cancel')
  .live("click", () ->
    resetCommentArea($(this).attr('post_id'))
  )

getPastPosts = () ->
  url = '/p/past/'
  if currentGroup > 0
    url = url + 'g/' + currentGroup + '/'
  if firstBlockPostId?
    url = url + firstBlockPostId
  $.get(url, {}, (html) ->
    $('#new-posts-message').remove()
    $container = $('#posts')
    $container.append(html)
    $('.hide-me.post').fadeIn()
  )


@getRecentPosts = getRecentPosts = () ->
  url = '/p/recent/'
  if currentGroup > 0
    url = url + 'g/' + currentGroup + '/'
  if latestPostId?
    url = url + latestPostId
  $.get(url, {}, (html) ->
    $('#new-posts-message').remove()
    $container = $('#posts')
    $container.prepend(html)
    $('.hide-me.post').fadeIn()
  )

$('.delete-post')
  .live('ajax:success', (data, status, xhr) ->
    $("#" + $(this).attr('post_entry_id')).fadeOut('fast', () -> 
      $(this).empty().remove()
    )
  )


getRecentPostsCounter = () ->
  url = '/p/recent/counter/'
  if (currentGroup > 0)
    url = url + 'g/' + currentGroup + '/'
  url = url + latestPostId
  $.get(url, {}, (html) ->
    if (parseInt(html) != 0)
      if $('#new-posts-message').length == 0
        $('<div id="new-posts-message" class="post"></div>').prependTo("#posts") 
      $('#new-posts-message').html('<div id="new-posts-message-inner">' + html + '</div>').show()
      #$('#posts').masonry('reload')
  )

$('#new-posts-message')
  .live('click touchstart', () ->
    getRecentPosts()
  )

$('.get-group')
  .live('ajax:success', (data, status, xhr) ->
    setHash('#!/g/' + $(this).attr('short_name'))
    $('#container').html(status);
    afterGetGroup($(this).attr('group_id'))
  )

@afterGetGroup = afterGetGroup = (g) ->
  $("#li_group_#{currentGroup}").removeClass('selected')
  currentGroup = g
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

$('.get-page')
  .live('ajax:success', (data, status, xhr) ->
    setHash('#!/g/' + $(this).attr('group_name') + '/' + $(this).attr('short_name'))
    clearInterval(recentTimer)
    $('#group-page').remove()
    if ($('#posts-area').length == 0) 
      $('#container').prepend('<div id="posts-area"></div>')
    $('#posts-area').html(status);
    afterGetPage($(this).attr('page_id'), $(this).attr('group_id'))
  )

@afterGetPage = afterGetPage = (p, g) -> 
  currentGroup = g
  $('.page-title').removeClass('selected')
  $('#li_page_' + p).addClass('selected')
  $('.file-list').sortable()

$('.file-list')
  .live('sortupdate', () ->
    fs_id = $(this).attr('fs_id')
    $('#order-files-form-' + fs_id).submit()
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

$('#add-file-section')
    .live("ajax:beforeSend", (evt, xhr, settings) ->
      # TODO: Display spinner
    )
    .live("ajax:success", (evt, data, status, xhr) ->
      res = $.parseJSON(xhr.responseText)
      url = '/pages/' + res['page_id'] + '/files_section'
      $.get(url, {}, (html) ->
        $('#group-page-files').html(html)
        $('#edit_section_' + res['id']).click()
      )
    )
    .live('ajax:complete', (evt, xhr, status) ->
      # Complete
    )
    .live("ajax:error", (evt, xhr, status, error) ->
      # TODO: Display errors
    )


$('.get-post') 
  .live('ajax:success', (data, status, xhr) ->
    window.location.hash = '#!/p/' + $(this).attr('post_id')
    currentPost = $(this).attr('post_id')
    $('.group-title').removeClass('selected')
    $('#container').html(status);
  )

$('.get-user')
  .live('ajax:success', (data, status, xhr) ->
    username =  $(this).attr('username')
    $('.group-title').removeClass('selected')
    setHash('#!/' + username)
    $('#container').html(status)
    afterGetUser(username)
  )

@afterGetUser = afterGetUser = (username) ->
  currentUsername = username
  $container = $('#posts-wide')
  #$container.imagesLoaded( () ->
  #  $container.masonry({ itemSelector: '.post', columnWidth: $('.post').width() + 20 })
  #)

$('.delete-comment')
  .live('ajax:success', (data, status, xhr) ->
    $("#" + $(this).attr('comment_entry_id')).fadeOut('fast', () -> 
      $(this).empty().remove()
    )
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

getHome = (reload) ->
  currentGroup = 0
  currentPost = 0
  currentUser = 0
  if (reload) 
    window.history.pushState('', document.title, window.location.pathname)
    url = '/home/index'
    $.get(url, {}, (html) ->
      $("#container").html(html)
      populateHome()
    )
  else
    populateHome()

setHash = (h) ->
  hash = h
  window.location.hash = hash

checkHash = () ->
  if window.location.hash != hash
    hash = window.location.hash
    if (hash.slice(0, 2) == '#!' && hash.length > 3) 
      url = hash.slice(2 - hash.length) + '?__from__=url'
      $.get(url, {}, (html) ->
        $('#container').html(html)
      )



$ ->
  getGroupList()
  getUserMenu()
  if window.location.hash.length <= 2 || window.location.hash.slice(0, 2) != '#!' 
    getHome(false)

$(window).scroll( (e) ->
  h = $('#topbar')
  if h.offset().top != 0
    if !h.hasClass('shadow')
      h.addClass('shadow')
  else
    h.removeClass('shadow')

  last_block = $('.sidebar-block:last-child')
  if lastBlockTop == 0
    lastBlockTop = $('.sidebar-block:last-child').position().top - h.height() - 10
 
  if $(window).scrollTop() > lastBlockTop
    last_block.attr('style', 'position: fixed; top: ' + (h.height() + 10) + 'px;')
  else 
    last_block.attr('style', 'position: relative;')

  if $(window).scrollTop() == $(document).height() - $(window).height()
    getPastPosts()


)

recentTimer = setInterval(getRecentPostsCounter, 10000)
hashTimer = setInterval(checkHash, 1000)
