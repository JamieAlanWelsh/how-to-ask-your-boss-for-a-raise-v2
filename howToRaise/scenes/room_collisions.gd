extends Node2D


# to prevent narration repeating each time you enter the room
var missY_seen = false


func _onMissYOffficeEntered(body: Node2D) -> void:
	if !missY_seen:
		Dialogic.start("enter_missY_office")
		missY_seen = true
	else:
		pass


func _onKitchenEntered(body: Node2D) -> void:
	print('welcome to the kitchen')
