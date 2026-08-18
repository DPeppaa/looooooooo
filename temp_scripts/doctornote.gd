extends Area3D
class_name doctornote

var player_looking := false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("e") && player_looking && Dialogic.current_timeline == null:
		Dialogic.start("doctornote")

func _on_area_entered(area: Area3D) -> void:
	player_looking = true
	PlayerStats.beam_colliding = true
func _on_area_exited(area: Area3D) -> void:
	player_looking = false
	PlayerStats.beam_colliding = false
