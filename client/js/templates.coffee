Template.main.selected_room = ->
  ChatroomSession.getSelectedRoomPermalink()

Template.search_rooms.events =
  'submit form': ->
    false
  'keyup input': (e) ->
    str = $(e.currentTarget).val()
    if str.length > 1
      ChatroomSession.set 'rooms_filter', str
    else
      ChatroomSession.set 'rooms_filter', null

Template.roomboard.rooms = ->
  query = ChatroomSession.get 'rooms_filter'
  if query?
    Rooms.find {name: new RegExp(".*#{query}.*", "i") }, {sort: {name: 1}}
  else
    Rooms.find {}, {sort: {name: 1}}

Template.room.events =
  'click .enter': ->
    Router.showRoom this.permalink

  'click .remove': ->
    Rooms.remove
      _id: this._id

Template.add_room.events =
  'submit form': (e) ->
    form = $(e.currentTarget)
    data = form.serializeArray()
    params = {}
    _.each data, (field) ->
      params[field.name] = field.value;
    Meteor.call 'createRoom', params
    e.target.reset()
    form.parents('.modal').modal('hide')
    false

Template.chatroom.messages = ->
  Chatroom.messagesForRoom this
Template.chatroom.room_name = ->
  r = Rooms.findOne({permalink: ChatroomSession.getSelectedRoomPermalink()})
  r.name if r?
Template.chatroom.room_description = ->
  r = Rooms.findOne({permalink: ChatroomSession.getSelectedRoomPermalink()})
  r.description if r?

Template.chatroom.events =
  'click [type=submit], keyup textarea': (e) ->
    if e.type == 'keyup' && e.which == 13 && e.shiftKey == false || e.type == 'click'
      input = $('[name="message"]')
      message = input.val()
      Meteor.call 'addMessage', ChatroomSession.getSelectedRoomPermalink(), message
      input.val("").focus()
    false

  'click .leave': ->
    Router.goHome()
    false

Template.login_links.user_logged_in = ->
  ChatroomSession.currentUser()?
Template.login_links.user = ->
  ChatroomSession.currentUser()

Template.login_links.events =
  'click #loginUser': (e) ->
    $('#loginModal').modal 'show'
    false
  'click #logoutUser': (e) ->
    ChatroomSession.logoutUser()
    false

Template.login_modal.events =
  'submit form': (e) ->
    form = $(e.currentTarget)
    data = form.serializeArray()
    params = {}
    _.each data, (field) ->
      params[field.name] = field.value;
    Meteor.call 'loginUser', params.login, params.password, (err, res) ->
      if err?
        console.log "Meteor#loginUser error: #{err}"
      else
        console.log "loginUser res: " + res
        ChatroomSession.loginUser res
    e.target.reset()
    form.parents('.modal').modal('hide')
    false
