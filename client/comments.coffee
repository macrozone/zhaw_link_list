

Template.comments.comments = ->
	Comments.find {linkID: @_id, userID: @userID }

Template.addComment.events
	"click .btn-add-comment": (event, template)->
		text = $(template.find "textarea").val()
		if text?.length > 0
			Comments.insert 
				userID: @userID
				linkID: @_id
				itime: new Date().getTime()
				comment: text,


Template.comments.user = ->
	Meteor.users.findOne _id: @userID
