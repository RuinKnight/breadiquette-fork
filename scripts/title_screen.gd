extends CanvasLayer


func _on_button_pressed() -> void:
	Globals.switch_level.emit("res://scenes/levels/office.tscn", true, true)
