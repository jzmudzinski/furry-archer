ChatroomSession =
  KEYS: ['order', 'selectedRoomPermalink', 'rooms_filter'],
  KEYS_WITH_EXPLICIT_ACCESSORS: ['order', 'room_name'],

  get: (key) ->
    if _.include(ChatroomSession.KEYS_WITH_EXPLICIT_ACCESSORS, key)
      throw new Error "Please use an explicit getter method"
    else if _.include(ChatroomSession.KEYS, key)
      return Session.get(key);
    else
      throw new Error "Unexpected session key: #{key}"

  set: (key, value) ->
    if _.include(ChatroomSession.KEYS_WITH_EXPLICIT_ACCESSORS, key)
      throw new Error "Please use an explicit setter method"
    else if _.include(ChatroomSession.KEYS, key)
      Session.set(key, value);
    else
      throw new Error "Unexpected session key: #{key}"

  equals: (key, value) ->
    if _.include(ChatroomSession.KEYS, key)
      return Session.equals(key, value);
    else
      throw new Error "Unexpected session key: #{key}"

  setSelectedRoomPermalink: (room_permalink) ->
    if room_permalink?
      Session.set 'selectedRoomPermalink', room_permalink
    else
      Session.set 'selectedRoomPermalink', null

  getSelectedRoomPermalink: ->
    Session.get 'selectedRoomPermalink'

  getSelectedDisplayRoomName: ->
    Chatroom.displayRoomName ChatroomSession.getSelectedNormalizedRoomName()

  setOrder: (order) ->
    if _.include(['popular', 'recent'], order)
      Session.set 'order', order
    else
      throw new Error "Unexpected order: #{order}"

  getOrder: ->
    Session.get 'order'
