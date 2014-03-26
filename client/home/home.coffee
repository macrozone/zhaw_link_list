
Template.home_userList.users = ->
	Meteor.users.find {}, sort: username: 1

Template.home_links.config = ->
	showUser: true, showComments: false
	
