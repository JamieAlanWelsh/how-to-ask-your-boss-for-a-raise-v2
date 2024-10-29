extends Area2D
class_name InteractionArea

# If a variable is exported it means we can edit the value in the inspector
@export var action_name: String = "interact"

# A callable is a type of variable that holds a function
# Any object we make with an interaction can overwrite this function and provide a new interaction
var interact: Callable = func():
	pass


func _on_body_entered(body: Node2D) -> void:
	InteractionManager.register_area(self)


func _on_body_exited(body: Node2D) -> void:
	InteractionManager.unregister_area(self)
