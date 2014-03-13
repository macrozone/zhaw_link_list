Router.map ->
  @route 'user',
    path: "/user/:_id"
    data: ->
      user: Meteor.users.findOne {_id: @params._id}
      links: Links.find userID: @params._id

Template.user.isOwner = ->
	@user._id == Meteor.user()._id

Template.oneLink.isOwner = ->
	@userID == Meteor.user()._id

Template.oneLink.events
	"click .btn-remove": ->
		Links.remove _id: @._id


Template.addNewLink.events
	"click .btn-save": (event, template) ->
		url = $(template.find ".link-url").val()
		label = $(template.find ".link-label").val()
		if url?.length > 0 and label?.length > 0
			Links.insert 
				url: url
				label: label
				userID: Meteor.user()._id
		else
			alert "please fill in url and label"