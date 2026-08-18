extends Node3D

@onready var debris: GPUParticles3D = $debris
@onready var smoke: GPUParticles3D = $smoke
@onready var fire: GPUParticles3D = $fire
@onready var sound: AudioStreamPlayer3D = $sound

func _enter_tree() -> void:
	await get_tree().create_timer(.05).timeout
	debris.emitting = true
	smoke.emitting = true
	fire.emitting = true
	sound.play()
	await get_tree().create_timer(2.).timeout
	queue_free()
