extends Node2D

@onready var interaction_area: InteractionArea = $interactionArea

# prevent player from initiating dialogue during dialogue
var dialogRunning = false


# example on how to receive dialogic signal
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	Dialogic.signal_event.connect(_DialogicSignalReceiver)


# gets signals from dialogic timelines
func _DialogicSignalReceiver(arg: String):
	if arg == "start":
		dialogRunning = true
	elif arg == "end":
		dialogRunning = false


func _on_interact():
	if !dialogRunning:
		Dialogic.start("mrX_door")
