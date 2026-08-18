extends Node3D

@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var player_looking := false
var cooldown := false
var doors_opened := false

func _on_detection_area_entered(area: Area3D) -> void:
	PlayerStats.beam_colliding = true
	player_looking = true
func _on_detection_area_exited(area: Area3D) -> void:
	PlayerStats.beam_colliding = false
	player_looking = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("e") && player_looking && !cooldown:
		cooldown = true
		timer.start()
		
		if doors_opened:
			animation_player.play_backwards("door_open")
			doors_opened = false
		else:
			animation_player.play("door_open")
			doors_opened = true
		
func _on_timer_timeout() -> void:
	cooldown = false
