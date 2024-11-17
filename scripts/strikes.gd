extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Globals.etiquette_strikes == 0:
		text = "Strikes: [ ] [ ] [ ]"
	elif Globals.etiquette_strikes == 1:
		text = "Strikes: [x] [ ] [ ]"
	elif Globals.etiquette_strikes == 2:
		text = "Strikes: [x] [x] [ ]"
	elif Globals.etiquette_strikes == 3:
		text = "Strikes: [x] [x] [x]"
