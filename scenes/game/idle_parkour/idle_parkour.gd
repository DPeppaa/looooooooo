extends Node3D

@onready var blink: ColorRect = $player_controller/view/blink
@onready var todo: Label = $player_controller/view/todo
@onready var parkour_points: Label = $player_controller/view/parkour_points
@onready var player: player_controller = $player_controller
@onready var spawn_point: Node3D = $start_platform/spawn_point

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
		if PlayerStats.current_scene != "":
			get_tree().change_scene_to_file(PlayerStats.current_scene)
		else:
			player.global_position = spawn_point.global_position
		
