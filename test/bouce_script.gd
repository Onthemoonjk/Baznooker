extends RigidBody3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	contact_monitor = true
	max_contacts_reported = 1
#	body_entered.connect(_on_body_entered)

func _process(_delta: float) -> void:
	var screen_size = get_viewport().get_visible_rect().size
	self.rotate_y(-0.00045 * (get_viewport().get_mouse_position().x - screen_size.x/2))
	get_viewport().warp_mouse(screen_size/2)
	if Input.is_action_just_pressed("forward"):
		apply_central_impulse(Vector3(10000,0,0))
		print(self.global_position)

#func _on_body_entered(body: RigidBody3D):
#	print("collided")
#	body.linear_velocity *= 1.5
