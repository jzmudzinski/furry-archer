Meteor.startup ->
  if Rooms.find().count() == 0
    Rooms.insert
      name: "Chatroom",
      description: "I jego wlasny opis"
      open: true
