Accounts.ui.config passwordSignupFields: 'USERNAME_AND_EMAIL'

Template.userList.users = ->
	Meteor.users.find()
	
Handlebars.registerHelper 'numberOfLinks', ->
	Links.find userID: @_id
	.count()

Handlebars.registerHelper 'username', ->

	if @profile? and @profile.name?
		@profile.name
	else if @username?
		@username
	else if @services.github.username?
		@services.github.username
	else
		@_id