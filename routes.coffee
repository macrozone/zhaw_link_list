Router.map ->
  @route 'user',
    path: "/user/:_id"
    data: ->
      user: Meteor.users.findOne {_id: @params._id}
      links: Links.find {userID: @params._id}, sort: topic: 1