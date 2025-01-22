extends Camera2D

@export var target: Node2D
@export var following:= true :
	set(value):
		if value == true:
			position_smoothing_enabled = true
		else:
			position_smoothing_enabled = false
		following = value


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if following:
		global_position = target.global_position
		global_position += 0.02 * ( get_viewport().get_mouse_position() - get_viewport_rect().size / 2 )
	else:
		global_position = Vector2.ZERO
