extends Area3D

@onready var holding_point: Node3D = $"../../player_controller/pivot/camera/holding_point"
@onready var sofa: Node3D = $sofa

var finished := false
var player_looking := false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("e") && player_looking && Dialogic.current_timeline == null && PlayerStats.holding != "painting" && !finished:
		Dialogic.start("bad_sofa")
		TempVar.spoken_to_sofa = true
	elif event.is_action_pressed("e") && player_looking && Dialogic.current_timeline == null && PlayerStats.holding == "painting":
		finished = true
		sofa.explode()
		PlayerStats.holding = ""
		PlayerStats.movable = false
		holding_point.queue_free()
		await get_tree().create_timer(2.5).timeout
		PlayerStats.beam_colliding = false
		player_looking = false
		PlayerStats.movable = true
		sofa.disable_collision()
		Dialogic.start("good_sofa")
		TempVar.sofa_flying = true
		
func _on_area_entered(_area: Area3D) -> void:
	player_looking = true
	PlayerStats.beam_colliding = true
func _on_area_exited(_area: Area3D) -> void:
	player_looking = false
	PlayerStats.beam_colliding = false
	
func _physics_process(_delta: float) -> void:
	if TempVar.sofa_flying && Dialogic.current_timeline == null:
		global_position.y += 0.1
