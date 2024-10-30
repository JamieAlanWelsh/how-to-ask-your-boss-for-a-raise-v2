extends AnimatedSprite2D


@onready var interaction_area: InteractionArea = $InteractionArea


# example on how to receive dialogic signal
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	Dialogic.start("susan_timeline")
