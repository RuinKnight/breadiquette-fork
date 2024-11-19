extends CharacterBody2D

# base speed in units/second
@export var base_speed = 16000
@export var run_modifier = 1.5
enum PlayerState {
	LOCKED,
	UNLOCKED,
}
var state = PlayerState.UNLOCKED

func _process(delta: float) -> void:
	$Eyes.position = 0.01 * (get_viewport().get_mouse_position() - Vector2(512, 328))

func _physics_process(delta: float) -> void:
	# MOVE the player
	player_move(delta)
	move_and_slide()


func player_move(delta: float) -> void:
	# Return if the player is locked
	if state == PlayerState.LOCKED:
		return
	# Get the direction the player is moving as a Vector2
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction.normalized() * base_speed * delta
	if Input.is_action_pressed("run"):
		velocity *= run_modifier
