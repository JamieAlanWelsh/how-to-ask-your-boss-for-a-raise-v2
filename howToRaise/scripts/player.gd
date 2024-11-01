extends CharacterBody2D

@export var inv: Inv


const SPEED = 150.0
const JUMP_VELOCITY = -300.0
const RoomShift = 63
var is_paused = false


func _ready():
	Dialogic.signal_event.connect(_DialogicSignalReceiver)


# gets signals from dialogic timelines
func _DialogicSignalReceiver(arg: String):
	if arg == "start":
		is_paused = true
	elif arg == "end":
		is_paused = false


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_paused:
		return # skip movement if paused

	var direction := Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
