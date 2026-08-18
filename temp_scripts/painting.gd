extends Area3D

@onready var holding_point: Node3D = $"../../player_controller/pivot/camera/holding_point"
@export var painting_model : PackedScene

var player_looking := false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("e") && player_looking && TempVar.spoken_to_sofa == true:
		var painting_instance = painting_model.instantiate()
		holding_point.add_child(painting_instance)
		PlayerStats.holding = "painting"
		Dialogic.start("painting")
		queue_free()

func _on_area_entered(_area: Area3D) -> void:
	if TempVar.spoken_to_sofa:
		player_looking = true
		PlayerStats.beam_colliding = true
func _on_area_exited(_area: Area3D) -> void:
	if TempVar.spoken_to_sofa:
		player_looking = false
		PlayerStats.beam_colliding = false
