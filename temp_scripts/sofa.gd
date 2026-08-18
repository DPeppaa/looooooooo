extends Node3D

@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var explosion : PackedScene

var explosion_count := 0

func explode():
	animation_player.play("transform")
	await get_tree().create_timer(1.5).timeout
	timer.start()
	
func _on_timer_timeout() -> void:
	if explosion_count <= 3:
		PlayerStats.camera_shaking = true
		var explosion_effect = explosion.instantiate()
		add_child(explosion_effect)
		explosion_count += 1
	else:
		timer.stop()

#func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("e"):
		#explode()
