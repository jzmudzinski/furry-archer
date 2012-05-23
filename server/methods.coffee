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
    ldap_client.bind l, password, (err) ->
      if err?
        console.log "Ldap Bind Error: #{err}; Login #{l}"
      else
        console.log "Ldap Bind Success; login: #{login}"
        ChatroomSession.loginUser login
        ldap_client.unbind (unbind_err) ->
          if unbind_err?
            console.log "Ldap Unbind Error: #{unbind_err}"

