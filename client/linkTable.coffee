
Template.linkTable.links = ->
	query = {}
	if @showOnlyUser?
		query.userID = @showOnlyUser
	links = Links.find query, sort: topic: 1
	links = links.map (link) => 
		link.showUser = @showUser
		link.showComments = @showComments
		
		link
	return links