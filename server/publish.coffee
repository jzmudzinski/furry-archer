Meteor.publish "allRooms", ->
  Rooms.find
    open: true
Meteor.publish "userRooms", (user_id) ->
  Rooms.find
    user_id: user_id
Meteor.publish "roomMessages", (room_permalink) ->
  Messages.find
    room_permalink: room_permalink

Rooms.restrict_client_access "remove"
Messages.restrict_client_access "remove"
Users.restrict_client_access()
