extends Sprite2D


@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sfxPickup = $sfxPickup
@export var item: InvItem
@onready var playerInv = preload("res://inventory/player_inv.tres")

var inv_insert = 0

signal coffeePicked


func _ready():
	visible = false
	interaction_area.interact = Callable(self, "_on_interact")
	Dialogic.signal_event.connect(_DialogicSignalReceiver)
	interaction_area.monitoring = false


# gets signals from dialogic timelines
func _DialogicSignalReceiver(arg: String):
	if arg == "coffeewin":
		visible = true
		interaction_area.monitoring = true


func _on_interact():
	# add item to inventory, make it invisible & switch off interactions
	playerInv.insert(item,inv_insert)
	visible = false
	interaction_area.monitoring = false
	sfxPickup.play()
	emit_signal("coffeePicked")
