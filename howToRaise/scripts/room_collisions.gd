extends Node2D

@onready var missY_collisions = $CollisionMissYOffice


signal fireInteractControls


func _onMissYOffficeEntered(body: Node2D) -> void:
	Dialogic.start("enter_missY_office")
	$CollisionMissYOffice.set_deferred('monitoring',false)


func _onKitchenEntered(body: Node2D) -> void:
	Dialogic.start("enter_kitchen")
	$CollisionKitchen.set_deferred('monitoring',false)


func _showInteractControl(body: Node2D) -> void:
	print('hello')
	emit_signal("fireInteractControls")
	$InteractCollisions.set_deferred('monitoring',false)
