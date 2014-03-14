Meteor.startup ->
	process.env.MAIL_URL = 'smtp://postmaster%40sandbox74845.mailgun.org:987c0segtxh4@smtp.mailgun.org:587';


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
			message = 
				to: email
				from: authorEmail
				subject: "ZHAW List, new Link added"
				text: "#{authorEmail} added a new link. Goto http://zhaw-list.macrozone.ch"
			if email
				Email.send message


		
	