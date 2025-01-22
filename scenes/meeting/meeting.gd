extends Control

@export var dialogue_objects: Array[Node]
var step = 0


func _ready() -> void:
	Globals.dialogue_end.connect(dialogue_end)
	sequence(step)

# I was a little short on time so instead of doing the logical choice and learning godot's animation editor I instead spent 25 minutes writing my own rudimentary alternative.
func sequence(step: int):
	if step == 0:
		%Salehbread.visible = false
		%Omarbread.visible = false
		Globals.start_dialogue(dialogue_objects[0].current_object, 0)
	elif step == 1:
		%Salehbread.visible = true
		%Omarbread.visible = true
		Globals.start_dialogue(dialogue_objects[1].current_object, 0)
	elif step == 2:
		print(Globals.score)
		if Globals.score > 5:
			Globals.start_dialogue(dialogue_objects[2].current_object, 0)
			%Evaluation.text = "Perfect!"
		elif Globals.score > 0:
			Globals.start_dialogue(dialogue_objects[2].current_object, 1)
			%Evaluation.text = "Eh."
		else:
			Globals.start_dialogue(dialogue_objects[2].current_object, 2)
			%Evaluation.text = "Bad >:("
	else:
		%EndCard.visible = true

func dialogue_end(condition):
	if condition:
		pass
	step += 1
	sequence(step)
