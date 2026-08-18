extends Node3D

@onready var player_controller: player_controller = $player_controller
@onready var animation_player: AnimationPlayer = $player_controller/animation_player
@onready var bed_position: Node3D = $room/bed/bed_position

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	UniversalControls.mouse_captured = true
	
	player_controller.global_position = bed_position.global_position
	animation_player.play("eye_open")
	await animation_player.animation_finished
	Dialogic.start("getting_off_bed")
