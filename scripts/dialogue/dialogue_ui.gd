extends Control

@export_group("Node Paths")
@export var button_array: Array[Button]

enum DialogueState {
	ACTIVE,
	INACTIVE,
}
var working_dialogue: Dialogue.DialogueObject
var working_text: int
var state = DialogueState.INACTIVE:
	set(value):
		if state != value:
			if value == DialogueState.ACTIVE:
				visible = true
			else:
				visible = false
		state = value


func _ready() -> void:
	Globals.set_dialogue.connect(set_dialogue)
	visible = false

func set_dialogue(dialogue_object: Dialogue.DialogueObject, text: int):
	working_dialogue = dialogue_object
	working_text = text
	update_dialogue()


func update_dialogue():
	if not working_dialogue:
		return
	if not working_dialogue.item_array.size():
		return
	%Options.visible = false
	%Label.text = working_dialogue.char_name
	state = DialogueState.ACTIVE
	%Speech.text = working_dialogue.item_array[working_text].text
	
	var working_options = working_dialogue.item_array[working_text].options.keys()
	for i in button_array:
		i.visible = false
	for i in working_options.size():
		button_array[i].text = working_options[i]
		button_array[i].visible = true
	%Options.visible = true
	
	# Animates the text, so it appears more smooth
	await speak(working_text, working_dialogue.char_base_speed)
	if working_options.size() == 0:
		state = DialogueState.INACTIVE
	


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
	# Your guess is as good as mine.
	working_text = (
		working_dialogue.item_array[working_text].options[working_dialogue.item_array[working_text].options.keys()[button]]
	)
	print()
	if working_dialogue.item_array[working_text].metadata.get("strike") or %Speech.visible_ratio != 1:
		working_text = working_dialogue.annoy_text
		Globals.etiquette_strikes += 1
	update_dialogue()
