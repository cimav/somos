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
    url = '/g/' + res['group_id'] + '/page_list'
    $.get(url, {}, (html) ->
      $("#pages-list").html(html)
      $("#page_link_" + res['id']).click()
    )
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

$('#page-delete-link-a') 
  .live('ajax:success', (evt, data, status, xhr) ->
    res = $.parseJSON(xhr.responseText)
    url = '/g/' + res['group_id'] + '/page_list'
    $.get(url, {}, (html) ->
      $("#group_link_" + res['group_id']).click()
    )
  )

$('.delete-post')
  .live('ajax:success', (data, status, xhr) ->
    $("#" + $(this).attr('post_entry_id')).fadeOut('fast', () ->
      $(this).empty().remove()
    )
  )

$('.delete-pfs')
  .live('ajax:success', (data, status, xhr) ->
    $("#group-page-section-" + $(this).attr('pfs_id')).fadeOut('fast', () ->
      $(this).empty().remove()
    )
  )

$('.delete-file')
  .live('ajax:success', (data, status, xhr) ->
    $("#file-" + $(this).attr('f_id')).fadeOut('fast', () ->
      $(this).empty().remove()
    )
  )

$('.edit-section-a') 
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
    $('.file-list').sortable()
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

$('.edit-file-description') 
  .live('click', () ->
    f_id = $(this).attr('f_id')
    fs_id = $(this).attr('fs_id')
    url = '/page_files/' + f_id + '/edit_details/' 
    $.get(url, {}, (html) ->
      $('#order-files-form-' + fs_id).hide()
      $('#file-edit-item').html(html)
      $('#page_file_title').focus()
    )
  )

$('#edit_pf_form')
  .live("ajax:beforeSend", (evt, xhr, settings) ->
    # TODO: Display saving spinner
  )
  .live("ajax:success", (evt, data, status, xhr) ->
    res = $.parseJSON(xhr.responseText)
    $('#edit_pf_form').remove()
    $('#order-files-form-' + res['fs_id']).show()
    $('#file-item-' + res['id'] + ' .file-title').html(res['newtitle'])
    $('#file-item-' + res['id'] + ' .file-description').html(res['newdesc'])
  )
  .live('ajax:complete', (evt, xhr, status) ->
    # Complete
  )
  .live("ajax:error", (evt, xhr, status, error) ->
    # TODO: Display errors
  )

