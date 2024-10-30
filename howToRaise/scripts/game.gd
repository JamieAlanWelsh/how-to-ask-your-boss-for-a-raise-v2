extends Node2D

@onready var red_overlay = $CanvasLayer/RedOverlay
@onready var restart_button = $CanvasLayer/RedOverlay/RestartButton


# example on how to receive dialogic signal
func _ready():
	red_overlay.visible = false
	restart_button.visible = false
	Dialogic.signal_event.connect(_DialogicGameover)
	load("res://dialogicCustomLayer/base_style.tres").prepare()
	Dialogic.preload_timeline("res://dialog/timelines/enter_missY_office.dtl")
	Dialogic.preload_timeline("res://dialog/timelines/missY_timeline.dtl")


# Gets a gameover signal from dialogic conversation
func _DialogicGameover(arg: String):
	if arg == "gameover":
		print('sucker')
		gameover_screen()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func gameover_screen():
	red_overlay.visible = true  # Make the red overlay visible
	restart_button.visible = true


func _input(event):
	if event.is_action_pressed("restart") and red_overlay.visible:
		restart_game()


func restart_game():
	# Logic to restart the game
	get_tree().reload_current_scene()  # Reloads the current scene
