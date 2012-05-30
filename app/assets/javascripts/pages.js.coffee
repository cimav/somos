# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$('#edit-page-button')
  .live('click', () ->
    $('#group-page-contents').hide()
    $('#group-page-files').hide()
    $('#page-toolbar').hide()
    $('#edit-page').fadeIn()
  )

$('#edit_page_form')
  .live("ajax:beforeSend", (evt, xhr, settings) ->
    # TODO: Display saving spinner
  )
  .live("ajax:success", (evt, data, status, xhr) ->
    res = $.parseJSON(xhr.responseText)
    $("#page_link_" + res['id']).html(res['title'])
    $("#page_link_" + res['id']).attr('short_name', res['short_name'])
    $("#page_link_" + res['id']).click();
    $('#edit-page').hide()
    $('#group-page').fadeIn()
    $('#page-toolbar').show()
  )
  .live('ajax:complete', (evt, xhr, status) ->
    # Complete
  )
  .live("ajax:error", (evt, xhr, status, error) ->
    # TODO: Display errors
  )

$('.edit-section') 
  .live('click', () ->
    pid = $(this).attr('page_id')
    pfs = $(this).attr('fs_id')
    url = '/pages/' + pid + '/edit_section/' + pfs
    $.get(url, {}, (html) ->
      $('#fs_header_' + pfs).hide()
      $('#fs_edit_' + pfs).html(html)
    ) 
  )

@getFilesSection = getFilesSection = (pid) ->
  url = '/pages/' + pid + '/files_section'
  $.get(url, {}, (html) ->
    $("#group-page-files").html(html)
  )
  

$('#edit_pfs_form')
  .live("ajax:beforeSend", (evt, xhr, settings) ->
    # TODO: Display saving spinner
  )
  .live("ajax:success", (evt, data, status, xhr) ->
    res = $.parseJSON(xhr.responseText)
    $('#edit_pfs_form').remove()
    getFilesSection(res['page_id'])
  )
  .live('ajax:complete', (evt, xhr, status) ->
    # Complete
  )
  .live("ajax:error", (evt, xhr, status, error) ->
    # TODO: Display errors
  )

$('.pfs-file-input')
  .live('change', () ->
    $("#add-files-form-" + $(this).attr('pfs_id')).submit()
  )
