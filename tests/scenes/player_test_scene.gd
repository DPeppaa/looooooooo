extends Node3D

@onready var view: Control = $player/view

func _ready() -> void:
	PlayerStats.movable = true
	view.visible = false
