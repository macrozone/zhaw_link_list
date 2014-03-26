@getUsername = (user) ->
	if user.profile? and user.profile.name?
		user.profile.name
	else if user.username?
		user.username
	else if user.services.github.username?
		user.services.github.username
	else
		user._id