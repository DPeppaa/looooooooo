extends CharacterBody3D
class_name player_controller

@onready var pivot: Node3D = $pivot
@onready var camera: Camera3D = $pivot/camera
@onready var animation_player: AnimationPlayer = $animation_player
@onready var todo: Label = $view/todo
@onready var interact: Label = $view/interact
@onready var bean: MeshInstance3D = $bean
@onready var shake: Timer = $shake
@onready var shake_point: Node3D = $shake_point

@export var speed := 4.
@export var sensitivity := 0.0015

var cam_shake_cooldown_triggered := false

func _ready() -> void:
	interact.visible = false
	bean.visible = false
	camera.make_current()
	
func _physics_process(delta: float) -> void:
	var input_direction = Input.get_vector("a","d","w","s").normalized()
	var direction = (pivot.transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()
	if input_direction and PlayerStats.movable and Dialogic.current_timeline == null:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = lerp(velocity.x, 0., 10. * delta)
		velocity.z = lerp(velocity.z, 0., 10. * delta)
		
	if !is_on_floor():
		velocity.y -= .5
		
	move_and_slide()
	
	todo.text = PlayerStats.todo
	
	if PlayerStats.beam_colliding:
		interact.visible = true
	else:
		interact.visible = false
		
	#print(PlayerStats.camera_shaking)
	if PlayerStats.camera_shaking:
		if cam_shake_cooldown_triggered == false:
			cam_shake_cooldown_triggered = true
			shake.start()
		else:
			var point_x = randf_range(shake_point.global_position.x - 0.1, shake_point.global_position.x + 0.1)
			var point_y = randf_range(shake_point.global_position.y - 0.1, shake_point.global_position.y + 0.1)
			var point_z = randf_range(shake_point.global_position.z - 0.1, shake_point.global_position.z + 0.1)
			shake_point.global_position.x = point_x
			shake_point.global_position.y = point_y
			shake_point.global_position.z = point_z
			camera.global_position = shake_point.global_position
			
			
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		pivot.rotation.y -= event.relative.x * sensitivity
		camera.rotation.x -= event.relative.y * sensitivity
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		

func _on_shake_timeout() -> void:
	PlayerStats.camera_shaking = false
	camera.global_position = pivot.global_position
	
