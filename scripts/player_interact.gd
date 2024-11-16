extends Area2D

## Interaction Engine

func _input(event):
	# Check for input
	if event.is_action_pressed("interact"):
		# Collect all interactable areas, or stop if there are none.
		var areas = get_overlapping_areas()
		if not areas:
			return
		# Find which area is closest
		var closest = areas[0]
		for area in areas:
			var distance = area.global_position.distance_to(global_position)
			if distance < closest.global_position.distance_to(global_position):
				closest = area
		# Begin interaction
		closest.interacted.emit()
