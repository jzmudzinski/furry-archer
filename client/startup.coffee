Meteor.startup ->
  ChatroomSession.setOrder 'popular'

  Meteor.subscribe "allRooms"
  Meteor.autosubscribe ->
    user_id = Session.get 'user_id'
    Meteor.subscribe 'userRooms', user_id

  Meteor.autosubscribe ->
    room_permalink = ChatroomSession.getSelectedRoomPermalink()
    if room_permalink?
      room = Rooms.findOne({permalink: 'chatroom'})
      if room?
        Meteor.subscribe 'roomMessages', room_permalink

Meteor.startup ->
  Backbone.history.start
    pushState: true

