extends Control


@onready var inv: Inv = preload("res://inventory/player_inv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false


func _ready():
	# whenever inventory emits the upadte signal we will update slots
	inv.update.connect(update_slots)
	update_slots()
	close()


func update_slots():
	for i in range(min(inv.items.size(), slots.size())):
		slots[i].update(inv.items[i])


func _process(delta):
	if Input.is_action_just_pressed("open_inventory"):
		if is_open:
			close()
		else:
			open()


func open():
	visible = true
	is_open = true
	
	
func close():
	visible = false
	is_open = false
