extends Node2D


@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite = $AnimatedSprite2D
@onready var playerInv = preload("res://inventory/player_inv.tres")

# item that NPC can use from player inventory
var item_idx = 0
# prevent player from initiating dialogue during dialogue
var dialogRunning = false
var spoken = false


# NO LONGER USED
#const lines: Array[String] = [
	#"Hey there!",
	#"Ya like jazz?",
	#"I sure as heck do!"
	#]


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
		if !spoken:
			interaction_area.monitoring = true
	elif arg == "miss_y_down":
		sprite.play("death")
		dialogRunning = false
		spoken = true
		interaction_area.monitoring = false
		playerInv.use(item_idx)


func _on_interact():
	if !dialogRunning && !spoken:
		if playerInv.check_for_item(item_idx):
			Dialogic.VAR.has_apple = true
		Dialogic.start("missY_timeline")
