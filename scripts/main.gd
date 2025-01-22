extends Node

var current_level: Node


func _ready() -> void:
	Globals.switch_level.connect(switch_level)
	# Load office
	load_level("res://scenes/levels/office.tscn", true, true)
	# Load meeting
	#load_level("res://scenes/meeting/meeting.tscn", false, false)


func switch_level(level: String, use_player: bool, use_cam: bool):
	remove_current_level()
	load_level(level, use_player, use_cam)


func load_level(level: String, use_player: bool, use_cam: bool):
	%Camera.enabled = use_cam
	%Player.visible = use_player
	
	var staged_level_resource = load(level)
	var staged_level = staged_level_resource.instantiate()
	add_child(staged_level)
	
	current_level = get_child(get_children().size() - 1)
	move_child(current_level, 0)
	%LoadingScreen.color = Color(0,0,0,0)


func remove_current_level():
	remove_child(current_level)
	current_level.call_deferred("free")
	%LoadingScreen.color = Color(0,0,0,1)
