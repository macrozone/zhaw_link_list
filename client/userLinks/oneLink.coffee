

Template.oneLink.events
	"click .btn-remove": ->
		Links.remove _id: @._id

Template.oneLink.user = ->
	user = Meteor.users.findOne _id: @userID
	if user?
		user.username = getUsername user
		user


