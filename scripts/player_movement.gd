extends CharacterBody2D

# base speed in units/second
@export var base_speed = 4000
@export var run_modifier = 1.5
enum PlayerState {
	LOCKED,
	UNLOCKED,
}
var state = PlayerState.UNLOCKED

func _process(delta: float) -> void:
	$Eyes.position = 0.004 * ( 
		get_viewport().get_mouse_position().clamp(Vector2.ZERO, Vector2(1920, 1080)) - (Vector2(1920, 1080) / 2)
	)
	if Globals.interacting:
		state = PlayerState.LOCKED
	else:
		state = PlayerState.UNLOCKED

func _physics_process(delta: float) -> void:
	# MOVE the player
	player_move(delta)
	move_and_slide()


func player_move(delta: float) -> void:
	# Return if the player is locked
	if state == PlayerState.LOCKED:
		velocity = Vector2.ZERO
		return
	# Get the direction the player is moving as a Vector2
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction.normalized() * base_speed * delta
	if Input.is_action_pressed("run"):
		velocity *= run_modifier
