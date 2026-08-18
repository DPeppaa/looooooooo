extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var cooldown: Timer = $cooldown
@onready var left_collision: CollisionShape3D = $left_door_point/left_door/left_collision
@onready var right_collision: CollisionShape3D = $right_door_point/right_door/right_collision

var player_looking := false
var door_opened := false
var interactive := true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("e") && player_looking && interactive:
		cooldown.start()
		left_collision.disabled = true
		right_collision.disabled = true
		interactive = false
		TempVar.closet_first_time = true
		if door_opened:
			door_opened = false
			animation_player.play_backwards("open_door")
		else:
			door_opened = true
			animation_player.play("open_door")

func _on_closet_area_entered(area: Area3D) -> void:
	player_looking = true
	PlayerStats.beam_colliding = true
func _on_closet_area_exited(area: Area3D) -> void:
	player_looking = false
	PlayerStats.beam_colliding = false

func _on_cooldown_timeout() -> void:
	interactive = true
	left_collision.disabled = false
	right_collision.disabled = false
