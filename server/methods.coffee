Meteor.methods
  createRoom: (params) ->
    params.permalink = Chatroom.preparePermalink params.name
    id = Rooms.insert _.extend {open: true}, params
    room = Rooms.findOne({_id: id})
    Router.showRoom room.permalink

  addMessage: (room_permalink, message) ->
    ts = new Date()
    Messages.insert
      room_permalink: room_permalink
      message: message
      timestamp: ts.getTime()
      created_at: dateformat(ts, "mmmm dd, HH:MM")

  loginUser: (login, password) ->
    l = ChatroomConfig.ldap.username_prefix + login
    # logged_in = false
    console.log 1
    ldap_client.bind l, password, (err) ->
      console.log 2
      if err?
        console.log "Ldap Bind Error: #{err}; Login #{l}"
      else
        console.log 3
        console.log "Ldap Bind Success; login: #{login}"
        ldap_client.unbind (unbind_err) ->
          if unbind_err?
            console.log "Ldap Unbind Error: #{unbind_err}"
          else
            console.log 4
        logged_in = login
    console.log 5
    # logged_in
