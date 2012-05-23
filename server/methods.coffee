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
    console.log login

