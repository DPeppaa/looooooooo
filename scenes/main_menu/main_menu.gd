extends Control

@onready var cup_root: Node3D = $"3d_environment/cup_root"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _physics_process(_delta: float) -> void:
	cup_root.rotate_y(0.01)

func _on_new_game_pressed() -> void:
	animation_player.play("transition")
	await animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/game/bedroom/bedroom.tscn")
func _on_quit_pressed() -> void:
	get_tree().quit()
