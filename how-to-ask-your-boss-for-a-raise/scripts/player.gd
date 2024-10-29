extends CharacterBody2D

@export var inv: Inv


const SPEED = 150.0
const JUMP_VELOCITY = -300.0
const RoomShift = 63


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var direction := Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _onRightEntered(body: Node2D) -> void:
	position.x += RoomShift
	print('firing right')


func _onLeftEntered(body: Node2D) -> void:
	position.x -= RoomShift
	print('firing right')
