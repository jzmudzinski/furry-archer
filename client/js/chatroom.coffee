$ ->
  $('.modal').modal
    show: true
  key 'f', ->
    $('#search-query').focus()
    false
  key 'c', ->
    $('#search-query').focus()
    false
