extends Sprite2D


@onready var interaction_area: InteractionArea = $InteractionArea
@export var item: InvItem
@onready var playerInv = preload("res://inventory/player_inv.tres")


func _ready():
	visible = true
	interaction_area.interact = Callable(self, "_on_interact")


func _on_interact():
	# add item to inventory and make it invisible
	playerInv.insert(item,2)
	visible = false
