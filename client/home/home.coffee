
Template.home_userList.users = ->
	Meteor.users.find {}, sort: username: 1

Template.home_links.config = ->

	links = Links.find {}, sort: topic: 1

	links: links, showUser: true, showComments: false
	
