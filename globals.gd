extends Node

signal set_dialogue(dialogue_object: Dialogue.DialogueObject, start_text: int)

var etiquette_strikes = 0

func start_dialogue(dialogue_object: Dialogue.DialogueObject, start_text: int):
	set_dialogue.emit(dialogue_object, start_text)
