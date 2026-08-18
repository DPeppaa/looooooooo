extends Area3D

@onready var fallen_down_end: Control = $fallen_down_end

func _on_body_entered(body: Node3D) -> void:
	if body is player_controller:
		fallen_down_end.visible = true
		fallen_down_end.play_animation()
