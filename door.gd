extends StaticBody3D
@onready var anim: AnimationPlayer = $"../../AnimationPlayer"
var open = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func interact():
	
	if not anim.is_playing():
		if open == false:
			anim.play("open")
			open = true
			
		elif open == true:
			anim.play("close")
			open = false
		#await get_tree().create_timer(2.0).timeout
	
