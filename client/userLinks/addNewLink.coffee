

fields = [
	(key: "topic", label: "Topic")
	(key: "label", label: "Label")
	(key: "url", label: "Url")
]

getFormID = (key) -> "add_new_link_#{key}"
		

Template.addNewLink.fields = fields

Template.addNewLink.formID = ->
	getFormID @key

isValid = (field, value) ->
	if value? and value.length > 0
		return true
	else
		return false

$getInputFor = (field) ->
	$ "#"+getFormID field.key

Template.addNewLink.events
	"click .btn-save": (event, template) ->
		doc = 
			userID: Meteor.user()._id

		for field in fields
			$input = $getInputFor field
			value = $input.val()
			unless isValid field, value
				alert "please fill in #{field.label}"
				return false
			doc[field.key] = value

		# empty form
		for field in fields
			$input = $getInputFor field
			$input.val ""
			
		Meteor.call "addLink", doc

		
		return false;
		