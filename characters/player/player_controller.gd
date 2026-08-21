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
@onready var parkour_points: Label = $view/parkour_points

@export var speed := 4.
@export var sensitivity := 0.0015
@export var jump_velocity := 5.
var sprint_speed := 1.
var sprint_multiplier := 1.5
var mouse_moving := false
var keyboard_moving := false
var idle_timer := 0.

var cam_shake_cooldown_triggered := false

func _ready() -> void:
	interact.visible = false
	bean.visible = false
	camera.make_current()
	
func _physics_process(delta: float) -> void:
	var input_direction = Input.get_vector("a","d","w","s").normalized()
	var direction = (pivot.transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()
	if input_direction and PlayerStats.movable and Dialogic.current_timeline == null:
		keyboard_moving = true
		idle_timer = 0.
		velocity.x = direction.x * speed * sprint_speed
		velocity.z = direction.z * speed * sprint_speed
	else:
		keyboard_moving = false
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
			
	if Input.is_action_pressed("space"):
		jump_velocity += 0.2
	else:
		jump_velocity = 7.
	
	if Input.is_action_pressed("shift"):
		sprint_speed = sprint_multiplier
	else:
		sprint_speed = 1.
		
##Idle parkour section:
	print(idle_timer)
	parkour_points.text = ("跳一跳分数： " + str(PlayerStats.parkour_point))
	if !mouse_moving && !keyboard_moving && !PlayerStats.in_parkour && Dialogic.current_timeline == null:
		idle_timer += 1
	if idle_timer > 600:
		get_tree().change_scene_to_file("res://scenes/game/idle_parkour/idle_parkour.tscn")
			
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		pivot.rotation.y -= event.relative.x * sensitivity
		camera.rotation.x -= event.relative.y * sensitivity
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		idle_timer = 0.
		
	if event.is_action_released("space") && Dialogic.current_timeline == null && is_on_floor():
		velocity.y = jump_velocity

func _on_shake_timeout() -> void:
	PlayerStats.camera_shaking = false
	camera.global_position = pivot.global_position
	
