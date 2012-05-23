Meteor.methods
  createRoom: (params) ->
    params.permalink = Chatroom.preparePermalink params.name
    id = Rooms.insert _.extend {open: true}, params
    room = Rooms.findOne({_id: id})
    Router.showRoom room.permalink

  addMessage: (room_permalink, message) ->
    Messages.insert
      room_permalink: room_permalink
      message: message
      created_at: (new Date()).getTime()


