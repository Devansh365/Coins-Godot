extends StaticBody3D
@onready var anim: AnimationPlayer = $"../../AnimationPlayer"
var open = false
var omg = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	omg = false
	
	Signalman.done.connect(donee)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func interact():
	if omg == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file("res://menu.tscn")
func donee():
	omg = true
	
	
