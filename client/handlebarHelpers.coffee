
Handlebars.registerHelper "isUser",->
	Meteor.user()? && @?._id == Meteor?.user()?._id
	
Handlebars.registerHelper "isOwner",->
	Meteor.user()? && @userID == Meteor.user()._id
	
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

DateFormats = 
       short: "DD.MM.YYYY",
       medium: "DD.MM.YYYY HH:mm"
       long: "dddd DD.MM.YYYY HH:mm"

Handlebars.registerHelper "formatDate", (datetime, format) ->
  if moment
    f = DateFormats[format]
    moment(datetime).format f
  else
    datetime