Router.configure layoutTemplate: 'layout'


@Links = new Meteor.Collection "links"
@Comments = new Meteor.Collection "comments"

Router.map ->
  @route 'home',
    path: "/"

Router.map ->
  @route 'user',
    path: "/user/:_id"
    data: ->
      user: Meteor.users.findOne {_id: @params._id}
      linkTableConfig:
      	links: Links.find {userID: @params._id}, sort: topic: 1
      	showUser: false
      	showComments: true