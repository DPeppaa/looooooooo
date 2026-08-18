extends CharacterBody3D
class_name player_controller

@onready var pivot: Node3D = $pivot
@onready var camera: Camera3D = $pivot/camera
@onready var animation_player: AnimationPlayer = $animation_player
@onready var todo: Label = $view/todo
@onready var interact: Label = $view/interact
@onready var bean: MeshInstance3D = $bean

@export var speed := 4.
@export var sensitivity := 0.0015

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

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		pivot.rotation.y -= event.relative.x * sensitivity
		camera.rotation.x -= event.relative.y * sensitivity
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		
