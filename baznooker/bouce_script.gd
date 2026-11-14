extends RigidBody3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	contact_monitor = true
	max_contacts_reported = 1
#	body_entered.connect(_on_body_entered)

func _process(_delta: float) -> void:
	#print(self.rotation_degrees)
	pass
	#var screen_size = get_viewport().get_visible_rect().size
	#self.rotate_y(-0.00045 * (get_viewport().get_mouse_position().x - screen_size.x/2))
	#get_viewport().warp_mouse(screen_size/2)
	#if Input.is_action_just_pressed("forward"):
		#apply_central_impulse(Vector3(10000,0,0))
		#print(self.global_position)

#func _on_body_entered(body: RigidBody3D):
#	print("collided")
#	body.linear_velocity *= 1.5

func _physics_process(delta: float) -> void:
	angular_velocity=Vector3.ZERO
	var screen_size = get_viewport().get_visible_rect().size
	self.rotate_y(-0.00045 * (get_viewport().get_mouse_position().x - screen_size.x/2))
	get_viewport().warp_mouse(screen_size/2)
	if Input.is_action_just_pressed("forward"):
		#print(self.global_position)
		
		var direction = Vector3(-sin(self.rotation.y), 0, -cos(self.rotation.y))
		apply_central_impulse(10*direction)
		
	if Input.is_action_just_pressed("shoot"):
		self.shoot(1,100)
	
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
	print("it works")
	#get_tree().root.get_node("projectiles").add_child(bullet)
	get_tree().root.add_child(bullet)
