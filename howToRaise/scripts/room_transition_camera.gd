extends Camera2D
class_name RoomTransitionCamera


const HORIZONTAL_OFFSET : int = -64
const VERTICAL_OFFSET : int = 0
const RoomShift = 63

@onready var m_CameraHorizontalMovement : int = (get_viewport_rect().size.x - HORIZONTAL_OFFSET) / 4
@onready var player = get_tree().get_first_node_in_group("player")
# to get mr X pos
@onready var root = get_tree().root.get_node("Game")

# initialise the current room the camera is pointing at
var m_CurrentRoom : Vector2 = Vector2(0,8)
# prevent warping off map
var roomShiftCount = 0
var rightMost = 1
var leftMost = -2

signal roomMoved


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("m_CameraHorizontalMovement: ", m_CameraHorizontalMovement)
	Dialogic.signal_event.connect(_DialogicSignalReceiver)


# gets signals from dialogic timelines
func _DialogicSignalReceiver(arg: String):
	# reposition if mrX door entered
	if arg == "enterMrX":
		var mr_x_pos = root._get_mr_x_pos()
		player.position = mr_x_pos + Vector2(-23,+30)
		position = mr_x_pos


# update camera position when player collides with edges
func _updateCameraPosition(direction : Vector2) -> void:
	m_CurrentRoom += direction
	set_position(m_CurrentRoom * Vector2(m_CameraHorizontalMovement, 1))


# NOT BEING USED
#func _pauseCollisions() -> void:
	##$CollisionAreaRight.monitoring = false
	##$CollisionAreaLeft.monitoring = false
	#$CollisionAreaRight.set_deferred('monitoring',false)
	#$CollisionAreaLeft.set_deferred('monitoring',false)
	#await get_tree().create_timer(2).timeout
	##$CollisionAreaRight.monitoring = true
	##$CollisionAreaLeft.monitoring = true
	#$CollisionAreaRight.set_deferred('monitoring',true)
	#$CollisionAreaLeft.set_deferred('monitoring',true)


func _onBodyEnteredRight(body: Node2D) -> void:
	if roomShiftCount < rightMost:
		emit_signal("roomMoved")
		roomShiftCount += 1
		_updateCameraPosition(Vector2.RIGHT)
		player.position.x += RoomShift
		#_pauseCollisions()


func _OnBodyEnteredLeft(body: Node2D) -> void:
	if roomShiftCount > leftMost:
		emit_signal("roomMoved")
		roomShiftCount -= 1
		_updateCameraPosition(Vector2.LEFT)
		player.position.x -= RoomShift
		#_pauseCollisions()
