Rooms = new Meteor.Collection "rooms"
Messages = new Meteor.Collection "messages"
Users = new Meteor.Collection "users"

Meteor.subscribe "rooms"
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
    Session.set "room_id", this._id
    Router.setRoom this._id

  'click .remove': ->
    Rooms.remove
      _id: this._id
    # log "Removed room #{this.name}"

Template.add_room.events =
  'submit form': (e) ->
    form = $(e.target)
    data = form.serializeArray()
    params = {}
    _.each data, (field) ->
      params[field.name] = field.value;
    console.log(params);
    Rooms.insert _.extend {open: true}, params
    e.target.reset()
    form.parents('.modal').modal('hide')
    false

Template.chatroom.events =
  'click .btn': (e) ->
    form = $(e.target).parents('form')
    alert "aaa"
    message = form.find('[name="message"]').val()
    alert "#{message}"
    console.log "Inserted message #{message}"
    alert "log"
    Messages.insert
      room_id: Session.get "room_id"
      message: message
      created_at: (newmo Date()).getTime()
    false

$('.modal').modal
  show: true
