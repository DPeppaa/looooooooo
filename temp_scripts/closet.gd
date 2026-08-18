extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cooldown: Timer = $cooldown
@onready var left_collision: CollisionShape3D = $left_door_point/left_door/left_collision
@onready var right_collision: CollisionShape3D = $right_door_point/right_door/right_collision
@onready var bedroom_animations: AnimationPlayer = $"../../bedroom_animations"
@onready var look_at_camera: Camera3D = $"../../player_controller/pivot/look_at_camera"
@onready var camera: Camera3D = $"../../player_controller/pivot/camera"
@onready var the_cup: MeshInstance3D = $"../TheCup"
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D

var player_looking := false
var door_opened := false
var interactive := true

func _physics_process(_delta: float) -> void:
	look_at_camera.look_at(the_cup.global_position)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("e") && player_looking && interactive:
		cooldown.start()
		left_collision.disabled = true
		right_collision.disabled = true
		interactive = false
		
		if !TempVar.closet_first_time:
			audio_stream_player_3d.play()
			PlayerStats.movable = false
			look_at_camera.make_current()
			animation_player.play("open_door")
			door_opened = true
			bedroom_animations.play("cup_escaping")
			await bedroom_animations.animation_finished
			PlayerStats.movable = true
			camera.make_current()
			TempVar.closet_first_time = true
			PlayerStats.todo = "？寻找飞机杯的下落"
		
		if door_opened:
			door_opened = false
			animation_player.play_backwards("open_door")
		else:
			door_opened = true
			animation_player.play("open_door")

func _on_closet_area_entered(_area: Area3D) -> void:
	if TempVar.phone_interacted:
		player_looking = true
		PlayerStats.beam_colliding = true
func _on_closet_area_exited(_area: Area3D) -> void:
	if TempVar.phone_interacted:
		player_looking = false
		PlayerStats.beam_colliding = false

func _on_cooldown_timeout() -> void:
	interactive = true
	left_collision.disabled = false
	right_collision.disabled = false
