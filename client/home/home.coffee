
Template.home_userList.users = ->
	Meteor.users.find {}, sort: username: 1