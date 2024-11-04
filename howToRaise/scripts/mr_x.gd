extends AnimatedSprite2D


@onready var interaction_area: InteractionArea = $InteractionArea


# prevent player from initiating dialogue during dialogue
var dialogRunning
var spoken


# example on how to receive dialogic signal
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	Dialogic.signal_event.connect(_DialogicSignalReceiver)
	dialogRunning = false
	spoken = false


# gets signals from dialogic timelines
func _DialogicSignalReceiver(arg: String):
	if arg == "start":
		dialogRunning = true
	elif arg == "end":
		dialogRunning = false


func _on_interact():
	if !dialogRunning && !spoken:
		Dialogic.start("mrX_timeline")
	else:
		print(dialogRunning, spoken)
