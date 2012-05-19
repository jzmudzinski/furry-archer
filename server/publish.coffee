Rooms = new Meteor.Collection "rooms"

Meteor.publish "rooms", (user_id = null) ->
  Rooms.find
    open: true
    user_id: user_id if user_id

Messages = new Meteor.Collection "messages"
Meteor.publish "messages", (room_id) ->
  Messages.find
    room_id: room_id

Users = new Meteor.Collection "users"
