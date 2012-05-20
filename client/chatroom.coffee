Meteor.subscribe "allRooms"
Meteor.autosubscribe ->
  user_id = Session.get 'user_id'
  Meteor.subscribe 'userRooms', user_id

Meteor.autosubscribe ->
  room_id = Session.get 'room_id'
  Meteor.subscribe 'roomMessages', room_id

Session.set 'room_id', null

Template.main.selected_room = ->
  Session.get 'room_id'

Template.page_header.title = ->
  "Example page header"
Template.page_header.description = ->
  "description"

Template.roomboard.rooms = ->
  Rooms.find {}, {sort: {name: 1}}

Template.room.events =
  'click .enter': ->
    Router.setRoom this._id

  'click .remove': ->
    Rooms.remove
      _id: this._id
    # log "Removed room #{this.name}"

Template.add_room.events =
  'submit form': (e) ->
    form = $(e.currentTarget)
    data = form.serializeArray()
    params = {}
    _.each data, (field) ->
      params[field.name] = field.value;
    console.log(params);
    Rooms.insert _.extend {open: true}, params
    e.target.reset()
    form.parents('.modal').modal('hide')
    false

Template.chatroom.messages = ->
  Messages.find {room_id: Session.get("room_id")}, {sort: {created_at: -1}}

Template.chatroom.events =
  'click [type=submit]': (e) ->
    form = $(e.target).parents('form')
    input = form.find('[name="message"]')
    message = input.val()
    console.log "Inserted message #{message}"
    Messages.insert
      room_id: Session.get "room_id"
      message: message
      created_at: (new Date()).getTime()
    input.val ""
    false

  'click .leave': ->
    Router.goHome()
    false

$('.modal').modal
  show: true
