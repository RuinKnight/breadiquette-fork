extends Node

# Initialize the dialogue object for this node
var current_object = Dialogue.DialogueObject.new()

@export_group("Character Data")
# The name to be displayed
@export var character_name: String:
	get:
		return current_object.char_name
	set(value):
		current_object.char_name = value
# Speed of the text as a delay in seconds
@export var character_base_speed: float:
	get:
		return current_object.char_base_speed
	set(value):
		current_object.char_base_speed = value
# Noise to play (TODO: Make it variable)
@export var speech_noise: AudioStream:
	get:
		return current_object.speech_noise
	set(value):
		current_object.speech_noise = value
@export_group("Dialogue Items")
# Everything the character says, in a big list
@export_multiline var text: Array[String]
# Responses corresponding to the text array
@export var options: Array[Dictionary]
@export var metadata: Array[Dictionary]


func _ready() -> void:
	for i in text.size():
		var working_item = Dialogue.DialogueItem.new()
		working_item.text = text[i]
		working_item.options = options[i]
		working_item.metadata = metadata[i]
		current_object.item_array.append(working_item)
