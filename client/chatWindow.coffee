Template.chatWindow.events
	"click .header": (event, template)->
		$(template.find(".content")).toggle()