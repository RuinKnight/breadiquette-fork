extends Node

class_name Dialogue

# An individual character's profile, containing their dialogue
class DialogueObject:
	var char_name: String
	var char_base_speed: float
	var speech_noise: AudioStream
	var item_array: Array[DialogueItem]

# One page of dialogue
class DialogueItem:
	var text: String
	var options: Dictionary
	var metadata: Dictionary
