extends Node2D

@onready var interaction_area: InteractionArea = $interactionArea
@onready var playerInv = preload("res://inventory/player_inv.tres")

# item that NPC can use from player inventory
var item_idx = 1
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
		interaction_area.monitoring = false
	elif arg == "end":
		dialogRunning = false
		interaction_area.monitoring = true


func _on_interact():
	if !dialogRunning:
		if playerInv.check_for_item(item_idx):
			Dialogic.VAR.has_photos = true
		Dialogic.start("mrX_door")
