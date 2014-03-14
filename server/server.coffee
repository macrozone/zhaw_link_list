Meteor.startup ->
	process.env.MAIL_URL = 'smtp://postmaster%40sandbox74845.mailgun.org:987c0segtxh4@smtp.mailgun.org:587';

getFullUrlFor = (userID) ->
	Meteor.absoluteUrl().replace(/\/$/, "")+Router.routes['user'].path _id: userID

getEmailFrom = (user) ->
	
	if user.emails?[0]?
		user.emails[0].address
	else if user.services?.google?.email?
		user.services.google.email


Meteor.methods
	addLink: (link) ->
		Links.insert link
		authorUser = Meteor.users.findOne _id: link.userID
		users = Meteor.users.find _id: $ne: link.userID

		users.forEach (user) ->
			email = getEmailFrom user
			authorEmail = getEmailFrom authorUser
			url = getFullUrlFor link.userID
			message = 
				to: email
				from: authorEmail
				subject: "ZHAW List, new Link added"
				html: "<p><strong>#{authorEmail}</strong> added a new link for the topic <em>#{link.topic}</em>:<br/><br/><a href='#{link.url}'>#{link.label}</a><br/></p><p>Click <a href='#{url}'>here</a> to see all his links</p>"
	
			if email
				Email.send message


		
	