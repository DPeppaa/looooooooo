extends Node3D

@onready var blink: ColorRect = $player_controller/view/blink
@onready var todo: Label = $player_controller/view/todo
@onready var parkour_points: Label = $player_controller/view/parkour_points

func _ready() -> void:
	blink.visible = false
	todo.visible = false
	parkour_points.visible = true
	PlayerStats.movable = true
	
	PlayerStats.in_parkour = true
	
func _exit_tree() -> void:
	PlayerStats.in_parkour = false

func _on_return_body_entered(body: Node3D) -> void:
	if body is player_controller:
		get_tree().change_scene_to_file(PlayerStats.current_scene)
		
