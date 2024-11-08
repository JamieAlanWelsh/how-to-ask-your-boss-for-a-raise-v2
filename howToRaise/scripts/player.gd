extends CharacterBody2D

@export var inv: Inv
@onready var animated_sprite = $AnimatedSprite2D


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
		animated_sprite.play("idle")
	elif arg == "end":
		is_paused = false
	#elif arg == "enterMrX":
		#var target_position = Vector2(-21, -25)
		#position = target_position


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if is_paused:
		return # skip movement if paused

	var direction := Input.get_axis("move_left", "move_right")
	
	#Flip sprite based on movement direction only when changing direction
	if direction > 0:
		animated_sprite.flip_h = false  # Face right
	elif direction < 0:
		animated_sprite.flip_h = true   # Face left
	
	# add move animation
	if direction == 0:
		animated_sprite.play("idle")
	else:
		animated_sprite.play("run")
	
	# apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
