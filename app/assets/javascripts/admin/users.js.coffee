# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).on 'click', '.admin-user-link', ->
  window.location = '/admin/users/' + $(this).data('id') + '/edit'

$(document).on 'change', '.required-group', -> 
  id = $(this).data('id')
  el = $(this)
  if (id == undefined) 
    # New group
    $.ajax({
      type: "POST",
      url: '/admin/memberships',
      data: { _method:'POST', membership : { user_id: $(this).data('user_id'), group_id: $(this).val()} },
      dataType: 'json',
      success: (msg) ->
        el.attr('data-id', msg.id);
        el.effect('highlight')
    })
  else
    # Update group
    $.ajax({
      type: "POST",
      url: '/admin/memberships/' + id,
      data: { _method:'PUT', membership : { group_id: $(this).val()} },
      dataType: 'json',
      success: (msg) ->
        el.effect('highlight')
    })

$(document).on 'change', '.other-group-checkbox', -> 
  id = $(this).data('id')
  el = $(this)
  if (id == undefined) 
    # New group
    $.ajax({
      type: "POST",
      url: '/admin/memberships',
      data: { _method:'POST', membership : { user_id: $(this).data('user_id'), group_id: $(this).val()} },
      dataType: 'json',
      success: (msg) ->
        el.attr('data-id', msg.id);
        el.effect('highlight')
    })
  else
    # Remove group
    $.ajax({
      type: "POST",
      url: '/admin/memberships/' + id,
      data: { _method:'DELETE' },
      dataType: 'json',
      success: (msg) ->
        el.effect('highlight')
    })

$(document).on 'change', '.user-app-checkbox', -> 
  id = $(this).data('id')
  el = $(this)
  if (id == undefined) 
    # New group
    $.ajax({
      type: "POST",
      url: '/admin/user_applications',
      data: { _method:'POST', user_application : { user_id: $(this).data('user_id'), application_id: $(this).val()} },
      dataType: 'json',
      success: (msg) ->
        el.attr('data-id', msg.id);
        el.effect('highlight')
    })
  else
    # Remove group
    $.ajax({
      type: "POST",
      url: '/admin/user_applications/' + id,
      data: { _method:'DELETE' },
      dataType: 'json',
      success: (msg) ->
        el.effect('highlight')
    })
