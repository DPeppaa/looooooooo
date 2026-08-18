extends Node3D

@onready var blink: ColorRect = $player_controller/view/blink

func _ready() -> void:
	blink.visible = false
	PlayerStats.movable = true
