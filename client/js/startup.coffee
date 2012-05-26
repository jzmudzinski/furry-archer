Meteor.startup ->
  ChatroomSession.setOrder 'popular'
  ChatroomSession.setSession $.cookies.get '_chatroom_session_id'

  Meteor.subscribe "allRooms"
  Meteor.autosubscribe ->
    user_login = ChatroomSession.currentUser
    Meteor.subscribe 'userRooms', user_login

  Meteor.autosubscribe ->
    user_login = ChatroomSession.currentUser
    Meteor.subscribe 'userSessions', user_login

  Meteor.autosubscribe ->
    room_permalink = ChatroomSession.getSelectedRoomPermalink()
    if room_permalink?
      room = Rooms.findOne({permalink: 'chatroom'})
      if room?
        Meteor.subscribe 'roomMessages', room_permalink

Meteor.startup ->
  Backbone.history.start
    pushState: true

