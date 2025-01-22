extends Control

enum DialogueState {
	ACTIVE, # Displays the UI
	INACTIVE, # Does not the UI
}
# Loads in the current dialogue object (explained in dialogue.gd)
var working_dialogue: Dialogue.DialogueObject
# The current text that's being display
var working_text: int
# This is a simple manager for whether the dialogue is active
var state = DialogueState.INACTIVE:
	set(value):
		if state != value:
			if value == DialogueState.ACTIVE:
				visible = true
			else:
				visible = false
		state = value


func _ready() -> void:
	# Connects the "set_dialogue" signal to the "set_dialogue()" function
	Globals.set_dialogue.connect(set_dialogue)
	visible = false


func set_dialogue(dialogue_object: Dialogue.DialogueObject, text: int):
	# Load in the dialogue object and set the starting text
	working_dialogue = dialogue_object
	working_text = text
	
	# update the dialogue
	update_dialogue()


func update_dialogue():
	if not working_dialogue:
		return
	if not working_dialogue.item_array.size():
		return
	
	if working_text == -1:
		state = DialogueState.INACTIVE
		Globals.interacting = false
		Globals.dialogue_end.emit(0)
		return 
	
	elif working_dialogue.item_array[working_text].metadata.has("end"):
		state = DialogueState.INACTIVE
		Globals.interacting = false
		Globals.dialogue_end.emit(working_dialogue.item_array[working_text].metadata["end"])
		return
	
	if working_dialogue.item_array[working_text].metadata.has("charname"):
		working_dialogue.char_name = working_dialogue.item_array[working_text].metadata["charname"]
	%Title.text = working_dialogue.char_name
	
	if working_dialogue.item_array[working_text].metadata.has("score"):
		Globals.score += working_dialogue.item_array[working_text].metadata["score"]
	
	%SpeechNoise.stream = working_dialogue.speech_noise
	
	state = DialogueState.ACTIVE
	%Speech.text = working_dialogue.item_array[working_text].text
	
	%Options.visible = false
	for i in %Options.get_children():
		i.visible = false
	
	var working_options = working_dialogue.item_array[working_text].options
	if working_options.size() == 0:
		var working_button = %Options.get_child(0)
		working_button.text = "End"
		working_button.value = -1
		working_button.visible = true
	else:
		for i in working_options.keys().size():
			var working_buttons = %Options.get_children()
			working_buttons[i].text = working_options.keys()[i]
			working_buttons[i].value = working_options.values()[i]
			working_buttons[i].visible = true
	%Options.visible = true
	
	# Animates the text, so it appears more smooth
	await speak(working_text, working_dialogue.char_base_speed)
	


func speak(start_text: int, speed: float):
	if speed == 0.0:
		%Speech.visible_characters = -1

	for i in %Speech.text.length() + 1:
		if working_text != start_text:
			return
		%Speech.visible_characters = i
		%SpeechNoise.pitch_scale = randf_range(0.75,1.25); %SpeechNoise.play()
		await get_tree().create_timer(speed).timeout


func action_select(button: int):
	if state != DialogueState.ACTIVE:
		return
	
	working_text = %Options.get_child(button).value
	
	update_dialogue()
