extends Node

var interacting = false
var score: int = 10

signal set_dialogue(dialogue_object: Dialogue.DialogueObject, start_text: int)
signal dialogue_end(condition: int)
signal switch_level(level: String, use_player: bool, use_cam: bool)

func start_dialogue(dialogue_object: Dialogue.DialogueObject, start_text: int):
	set_dialogue.emit(dialogue_object, start_text)
