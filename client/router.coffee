class ChatroomRouter extends Backbone.Router
  routes:
    "/": "goHome"
    ":room_id": "setRoom"

  goHome: ->
    Session.set "room_id", null
    this.navigate "", true
    console.log "showing home page"

  setRoom: (room_id) ->
    Session.set "room_id", room_id
    this.navigate room_id, true
    console.log "showing room ##{room_id}"

Router = new ChatroomRouter

Meteor.startup ->
  Backbone.history.start
    pushState: true
