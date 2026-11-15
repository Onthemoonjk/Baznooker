extends Control
var paused : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause()

func pause():
	paused = not paused
	if paused:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		Engine.time_scale = 0.0
	elif not paused:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
		Engine.time_scale = 1.0
	var children = self.get_children()
	for i in children.size():
		children[i].disabled = not children[i].disabled
		children[i].visible = not children[i].visible
