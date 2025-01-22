extends Node2D


func _on_interactable_component_interacted() -> void:
	Globals.switch_level.emit("res://scenes/meeting/meeting.tscn", false, false)
