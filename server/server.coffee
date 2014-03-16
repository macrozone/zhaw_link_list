Meteor.startup ->
	process.env.MAIL_URL = 'smtp://postmaster%40sandbox74845.mailgun.org:987c0segtxh4@smtp.mailgun.org:587';

getFullUrlFor = (userID) ->
	Meteor.absoluteUrl().replace(/\/$/, "")+Router.routes['user'].path _id: userID

getEmailFrom = (user) ->
	
	if user.emails?[0]?
		user.emails[0].address
	else if user.services?.google?.email?
		user.services.google.email

sendMessageToUsers = (message, users) ->
	users.forEach (user) ->
		message.to = getEmailFrom user	
		if message.to then Email.send message
			
			

notifyAllUsersAboutLink = (link) ->
	authorUser = Meteor.users.findOne _id: link.userID
	authorEmail = getEmailFrom authorUser
	users = Meteor.users.find _id: $ne: link.userID
	url = getFullUrlFor link.userID
	message = 
			from: authorEmail
			subject: "ZHAW List, new Link added"
			html: "<p><strong>#{authorEmail}</strong> added a new link for the topic <em>#{link.topic}</em>:<br/><br/><a href='#{link.url}'>#{link.label}</a><br/></p><p>Click <a href='#{url}'>here</a> to see all his links</p>"

	sendMessageToUsers message, users

notifyAllUsersAboutComment = (comment) ->
	authorUser = Meteor.users.findOne _id: comment.userID
	link = Links.findOne _id: comment.linkID
	users = Meteor.users.find _id: $ne: comment.userID
	url = getFullUrlFor link.userID
	authorEmail = getEmailFrom authorUser
	message = 
			from: authorEmail
			subject: "ZHAW List, new Comment added"
			html: "<p><strong>#{authorEmail}</strong> added a Comment for the link <a href='#{link.url}'>#{link.label}</a>:<br/></p><p><em>#{comment.comment}</em></p><p>Click <a href='#{url}'>here</a> to see all his links</p>"

	sendMessageToUsers message, users
		

Meteor.methods
	addComment: (comment) ->
		Comments.insert comment
		notifyAllUsersAboutComment comment
	addLink: (link) ->
		Links.insert link
		notifyAllUsersAboutLink link



		
	