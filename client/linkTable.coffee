
Template.linkTable.links = ->

	links = @links.map (link) => 
		link.showUser = @showUser
		link.showComments = @showComments
		
		link
	return links