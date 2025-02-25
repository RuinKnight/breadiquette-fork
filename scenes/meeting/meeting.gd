extends Control

@export var dialogue_objects: Array[Node]
var step = 0
var exit_code = 0
@export var level: int = 0

func _ready() -> void:
	Globals.dialogue_end.connect(dialogue_end)
	sequence(step, level)

# I was a little short on time so instead of doing the logical choice and learning godot's animation editor I instead spent 25 minutes writing my own rudimentary alternative.
func sequence(step: int, level):
	if level == 0:
		if step == 0:
			%Khubz.visible = false
			Globals.start_dialogue(dialogue_objects[0].current_object, 0)
		elif step == 1:
			%Khubz.visible = true
			Globals.start_dialogue(dialogue_objects[1].current_object, 0)
		elif step == 2:
			if Globals.score == 10:
				Globals.start_dialogue(dialogue_objects[2].current_object, 0)
				%Evaluation.text = "Perfect!"
			elif Globals.score > 5:
				Globals.start_dialogue(dialogue_objects[2].current_object, 4)
				%Evaluation.text = "Eh."
			else:
				Globals.start_dialogue(dialogue_objects[2].current_object, 3)
				%Evaluation.text = "Bad >:("
		else:
			%EndCard.visible = true
	if level == 1:
		print("how the heck did you get here?")

func dialogue_end(condition):
	exit_code = condition
	step += 1
	sequence(step, level)
