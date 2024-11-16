extends Entity

@export var DialogueComponent: Node

# State machine template
enum MrBreadlyState {
	IDLE,
	YAP,
}

# Create the state machine
var state = MrBreadlyState.IDLE:
	set(value):
		# When the state is changed, perform some tasks
		if value == MrBreadlyState.YAP:
			%Sprite.play("yap")
		else:
			%Sprite.play("idle")
		return value


func _on_interactable_component_interacted() -> void:
	# Make sure that there's a dialogue object to use.
	if not DialogueComponent:
		return
	state = MrBreadlyState.YAP
	# Start dialogue
	await Globals.start_dialogue(DialogueComponent.current_object, 0)
	state = MrBreadlyState.IDLE
