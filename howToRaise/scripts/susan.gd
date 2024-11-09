extends AnimatedSprite2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var playerInv = preload("res://inventory/player_inv.tres")

# prevent player from initiating dialogue during dialogue
var dialogRunning = false
var spoken = false
# item that NPC can use from player inventory
var item_idx = 0


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
	elif arg == "coffeewin":
		spoken = true
		interaction_area.monitoring = false
	elif arg == "susanblush":
		self.play("blush")
	elif arg == "susansus":
		self.play("sus")
		#await get_tree().create_timer(3).timeout
		#interaction_area.monitoring = true
		#interaction_area.action_name = "Are you good...?"
		## wait 5 seconds
		#await get_tree().create_timer(3).timeout
		#interaction_area.monitoring = false
		#await get_tree().create_timer(3).timeout
		#interaction_area.monitoring = true
		#interaction_area.action_name = "Whatever..."


func _on_interact():
	if !dialogRunning && !spoken:
		Dialogic.start("susan_timeline")
