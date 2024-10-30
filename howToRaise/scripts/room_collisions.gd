extends Node2D


# to prevent narration repeating each time you enter the room
var missY_entered = false
var kitchen_entered = false


func _onMissYOffficeEntered(body: Node2D) -> void:
	if !missY_entered:
		Dialogic.start("enter_missY_office")
		missY_entered = true
	else:
		pass


func _onKitchenEntered(body: Node2D) -> void:
	if !kitchen_entered:
		Dialogic.start("enter_kitchen")
		kitchen_entered = true
	else:
		pass
