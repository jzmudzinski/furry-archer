class ChatroomRouter extends Backbone.Router
  routes:
    "": "goHome"
    ":room_permalink": "showRoom"

  goHome: ->
    ChatroomSession.setSelectedRoomPermalink null
    this.navigate "", true

  showRoom: (room_permalink) ->
    this.navigate room_permalink, true
    ChatroomSession.setSelectedRoomPermalink room_permalink

Router = new ChatroomRouter
