extends Area3D
class_name phone

var player_looking := false
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("e") and player_looking:
		TempVar.phone_interacted = true
		PlayerStats.beam_colliding = false
		PlayerStats.todo = "找到飞机杯（应该在衣柜里？）"
		Dialogic.start("phone")
		queue_free()


func _on_area_entered(area: Area3D) -> void:
	player_looking = true
	PlayerStats.beam_colliding = true
func _on_area_exited(area: Area3D) -> void:
	player_looking = false
	PlayerStats.beam_colliding = false
