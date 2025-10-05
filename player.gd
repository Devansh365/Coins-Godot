extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var SENSITIVITY= 0.005
@onready var head: Node3D = $head
@onready var camera: Camera3D = $head/Camera3D
@onready var coinui: RichTextLabel = $CanvasLayer/coins

var coinsinhand = 0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Signalman.coinpicked.connect(coinpicked)
	Signalman.coinplaced.connect(coinplaced)
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-40), deg_to_rad(60))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	
	if Input.is_action_just_pressed("flash"):
		if $head/Camera3D/SpotLight3D.visible == false:
			$head/Camera3D/SpotLight3D.visible = true
		elif $head/Camera3D/SpotLight3D.visible == true:
			$head/Camera3D/SpotLight3D.visible = false
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
			
	else:
		velocity.x = lerp(velocity.x,direction.x * SPEED, delta * 3)
		velocity.z = lerp(velocity.z,direction.z * SPEED, delta * 3)

	move_and_slide()



func coinpicked():
	coinui.visible = true
	coinsinhand = coinsinhand + 1
	coinui.text = "Total coins: " + str(coinsinhand)
func coinplaced():
	coinsinhand = coinsinhand - 1
	coinui.text = "Total coins: " + str(coinsinhand)
	
