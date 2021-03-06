Router.configure layoutTemplate: 'layout'


@Links = new Meteor.Collection "links"
@Comments = new Meteor.Collection "comments"

Router.map ->
  @route 'debug'
  
Router.map ->
  @route 'home',
    path: "/"

Router.map ->
  @route 'user',
    path: "/user/:_id"
    data: ->
      user: Meteor.users.findOne {_id: @params._id}
      linkTableConfig:
      	showOnlyUser: @params._id
      	showUser: false
      	showComments: true