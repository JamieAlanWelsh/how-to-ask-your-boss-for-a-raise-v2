extends Node2D


@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite = $AnimatedSprite2D
@onready var playerInv = preload("res://inventory/player_inv.tres")

# item that NPC can use from player inventory
var item_idx = 2
# prevent player from initiating dialogue during dialogue
var dialogRunning = false


# if the line isn't enough characters then the code will break
const lines: Array[String] = [
	"Hey there!",
	"Ya like jazz?",
	"I sure as heck do!"
	]


const lines_with_item: Array[String] = [
	"I can see your apple"
	]


# example on how to receive dialogic signal
func _ready():
	interaction_area.interact = Callable(self, "_on_interact")
	Dialogic.signal_event.connect(_DialogicSignalReceiver)


# gets signals from dialogic timelines
func _DialogicSignalReceiver(arg: String):
	if arg == "start":
		dialogRunning = true
		print('miss Y dialog running: ', dialogRunning)
	elif arg == "end":
		dialogRunning = false
		print('miss Y dialog running: ', dialogRunning)


func _on_interact():
	if !dialogRunning:
		if playerInv.check_for_item(item_idx):
			Dialogic.VAR.has_apple = true
			# communicates with Dialogic to say that item is present
			DialogManager.start_dialog(global_position, lines_with_item)
			#await DialogManager.dialog_finished
			playerInv.use(item_idx)
		else:
			DialogManager.start_dialog(global_position, lines)
			#await DialogManager.dialog_finished
		Dialogic.start("missY_timeline")
