extends StaticBody3D

var next_platform_scene = preload("res://scenes/game/idle_parkour/platform/platform.tscn")
@onready var point_1: Node3D = $point1
@onready var point_2: Node3D = $point2

var already_jumped := false

func _on_jump_area_body_entered(body: Node3D) -> void:
	if body is player_controller:
		if !already_jumped:
			PlayerStats.parkour_point += 1
			
			var next_platform = next_platform_scene.instantiate()
			var spawn_point_x = randf_range(point_1.global_position.x, point_2.global_position.x)
			next_platform.global_position = Vector3(spawn_point_x, global_position.y, global_position.z)
			get_parent().add_child(next_platform)
			
			already_jumped = true
