extends RigidBody3D
@onready var pause_node: Node = $"../UI/Pause"

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	contact_monitor = true
	max_contacts_reported = 1
	body_entered.connect(_on_body_entered)
	pause_node.pause();pause_node.pause()

func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: RigidBody3D):
	body.linear_velocity *= 1.25
	print(self.linear_velocity)

func _physics_process(_delta: float) -> void:
	position.y = 0
	if linear_velocity.length() < 10:
		$CanvasLayer/MistFiner.material.set_shader_parameter("line_density",0)
	else:
		var greg = 0.1*((0.45/(linear_velocity.length())-12))
		$CanvasLayer/MistFiner.material.set_shader_parameter("line_density",greg)
	angular_velocity=Vector3.ZERO
	var screen_size = get_viewport().get_visible_rect().size
	if not pause_node.paused:
		self.rotate_y(-0.00045 * (get_viewport().get_mouse_position().x - screen_size.x/2))
		get_viewport().warp_mouse(screen_size/2)
		if Input.is_action_pressed("dilate"):
			Engine.time_scale = 0.3
		elif pause_node.paused:
			Engine.time_scale = 0.0
		elif not pause_node.paused:
			Engine.time_scale = 1.0
	
	if Input.is_action_just_pressed("forward"):
		var direction = Vector3(-sin(self.rotation.y), 0, -cos(self.rotation.y))
		apply_central_impulse(10*direction)
	if Input.is_action_just_pressed("shoot"):
		shoot(0.5, 10)
	
	#TEST CONTROLS
	var horseyforcey=Vector3.ZERO	
	if Input.is_action_pressed("debugfor"):
		horseyforcey+=Vector3(-sin(self.rotation.y), 0, -cos(self.rotation.y))
	if Input.is_action_pressed("debugback"):
		horseyforcey-=Vector3(-sin(self.rotation.y), 0, -cos(self.rotation.y))
	if Input.is_action_pressed("debuglef"):
		horseyforcey+=Vector3(-sin(self.rotation.y+PI/2), 0, -cos(self.rotation.y+PI/2))
	if Input.is_action_pressed("debugrig"):
		horseyforcey+=Vector3(-sin(self.rotation.y-PI/2), 0, -cos(self.rotation.y-PI/2))
	apply_central_force(horseyforcey*10)
	apply_force(-self.linear_velocity*1.5)
	#END OF TEST CONTROLS
	
func shoot(bigness,force):
	var bullet = preload("res://boolet.tscn").instantiate()
	bullet.rotations = self.rotation
	bullet.setsize = bigness
	bullet.SHOOT = force
	bullet.shooter=self
	get_tree().current_scene.get_node("projectiles").add_child(bullet)
