extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.interacting = true
	Globals.start_dialogue($Interactable/MrBreadly/DialogueComponent.current_object, 0)
