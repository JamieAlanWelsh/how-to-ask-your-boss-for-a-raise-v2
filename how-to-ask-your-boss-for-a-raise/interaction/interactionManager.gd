extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $Label


const base_text = "[SPACE] "

# holds all interaction areas that can be interated with
# an array is necessary because the player may be in multiple interaction areas at once
var active_areas = []
# indicates whether player is allowed to interact, set to false during interactions to prevent multiple interactions at the same time
var can_interact = true


# adds an interaction area to the active_areas list when player enters the area
func register_area(area: InteractionArea):
	active_areas.push_back(area)


# removes an interaction area from the list if player leaves the interaction area
func unregister_area(area: InteractionArea):
	# find index of area that the player is leaving
	var index = active_areas.find(area)
	# checks that the area exists in the array (an index of -1 is not possible if it does)
	if index != -1:
		# use the specified index to remove the active area
		active_areas.remove_at(index)


# check if there are any active areas and whether the player is allowed to interact
func _process(delta):
	if active_areas.size() > 0 && can_interact:
		# find closest interaction area
		active_areas.sort_custom(_sort_by_distance_to_player)
		# show text label for closest interaction area 
		label.text = base_text + active_areas[0].action_name
		label.global_position = active_areas[0].global_position
		label.global_position.y -= 36
		label.global_position.x -= label.size.x / 2
		label.show()
	else:
		# if there are no active areas or can interact is false, don't show label
		label.hide()
		

# Sorts interaction areas in a players vicinity by distance to player
func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player


func _input(event):
	# If the interact button is pressed and can_interact is true the following steps occur
	if event.is_action_pressed("interact") && can_interact:
		# interaction is disabled to prevent further interactions
		if active_areas.size() > 0:
			can_interact = false
			label.hide()
			# await interaction to complete before enabling interact again
			await active_areas[0].interact.call()
			can_interact = true
