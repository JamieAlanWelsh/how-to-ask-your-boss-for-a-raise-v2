extends Node2D

@onready var red_overlay = $CanvasLayer/ColorOverlay
@onready var restart_button = $CanvasLayer/RestartButton
#@onready var coffee_object = $Coffee
@onready var mrX = $mrXOffice


# example on how to receive dialogic signal
func _ready():
	red_overlay.visible = false
	restart_button.visible = false
	
	Dialogic.signal_event.connect(_DialogicSignalReceiver)
	
	# preloading styles for performance
	load("res://dialogicCustomLayer/base_style.tres").prepare()
	Dialogic.preload_timeline("res://dialog/timelines/enter_missY_office.dtl")
	Dialogic.preload_timeline("res://dialog/timelines/missY_timeline.dtl")


# gets signals from dialogic timelines
func _DialogicSignalReceiver(arg: String):
	if arg == "gameover":
		print('sucker')
		gameover_screen()
	elif arg == "gamewin":
		print('congrats')
		gamewin_screen()


# to pass to camera
func _get_mr_x_pos() -> Vector2:
	return mrX.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func gameover_screen():
	red_overlay.color = Color(1, 0, 0, 0.5) # RGB
	restart_button.text = 'You Failed!\n\nPress R to Restart'
	red_overlay.visible = true  
	restart_button.visible = true


func gamewin_screen():
	red_overlay.color = Color(0, 0.8, 0, 0.5)  # RGB
	restart_button.text = 'You Won!!!\n\nPress R to Restart'
	red_overlay.visible = true 
	restart_button.visible = true


# allows player to restart the game on gameover screen
func _input(event):
	if event.is_action_pressed("restart") and red_overlay.visible:
		restart_game()


func restart_game():
	# Logic to restart the game
	get_tree().reload_current_scene()  # Reloads the current scene
