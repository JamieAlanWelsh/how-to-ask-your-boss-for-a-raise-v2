extends Camera2D
class_name RoomTransitionCamera


const HORIZONTAL_OFFSET : int = -64
const VERTICAL_OFFSET : int = 0


@onready var m_CameraHorizontalMovement : int = (get_viewport_rect().size.x - HORIZONTAL_OFFSET) / 4


# initialise the current room the camera is pointing at
var m_CurrentRoom : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("m_CameraHorizontalMovement: ", m_CameraHorizontalMovement)


# update camera position when player collides with edges
func _updateCameraPosition(direction : Vector2) -> void:
	m_CurrentRoom += direction
	set_position(m_CurrentRoom * Vector2(m_CameraHorizontalMovement, 0))


# NOT BEING USED
func _pauseCollisions() -> void:
	#$CollisionAreaRight.monitoring = false
	#$CollisionAreaLeft.monitoring = false
	$CollisionAreaRight.set_deferred('monitoring',false)
	$CollisionAreaLeft.set_deferred('monitoring',false)
	await get_tree().create_timer(2).timeout
	#$CollisionAreaRight.monitoring = true
	#$CollisionAreaLeft.monitoring = true
	$CollisionAreaRight.set_deferred('monitoring',true)
	$CollisionAreaLeft.set_deferred('monitoring',true)


func _onBodyEnteredRight(body: Node2D) -> void:
	_updateCameraPosition(Vector2.RIGHT)
	#_pauseCollisions()


func _OnBodyEnteredLeft(body: Node2D) -> void:
	_updateCameraPosition(Vector2.LEFT)
	#_pauseCollisions()
