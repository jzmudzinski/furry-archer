Meteor.publish "allRooms", ->
  Rooms.find
    open: true
Meteor.publish "userRooms", (user_login) ->
  Rooms.find
    user_login: user_login
Meteor.publish "userSessions", (user_login) ->
  Sessions.find
    login: user_login
Meteor.publish "roomMessages", (room_permalink) ->
  Messages.find
    room_permalink: room_permalink

Rooms.restrict_client_access "remove"
Messages.restrict_client_access "remove"
Users.restrict_client_access()
# Sessions.restrict_client_access()
