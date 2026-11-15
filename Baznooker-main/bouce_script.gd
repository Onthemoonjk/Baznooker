extends RigidBody3D
@onready var pause_node: Node = $"../UI/Pause"
var health = 500
var dashcd=1
var chargingdash = false
var chargetime = 0
var shootcd = 0
var shootcharge = 0
var chargingshot = false

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
	if body.is_in_group("Enemy"):
		body.damage(linear_velocity.length()*2.5)

func _physics_process(delta: float) -> void:
	position.y = 0
	dashcd -= delta
	if linear_velocity.length() < 10:
		$CanvasLayer/MistFiner.material.set_shader_parameter("line_density",0)
	else:
		var greg = 0.013*(45/(7-linear_velocity.length())+15)
		$CanvasLayer/MistFiner.material.set_shader_parameter("line_density",greg)
	angular_velocity=Vector3.ZERO
	rotation.x = 0;rotation.z = 0
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
	
	if Input.is_action_just_pressed("forward") and dashcd <= 0 or chargingdash:
		if not chargingdash:
			chargetime=0
		chargingdash=true
		apply_force(-self.linear_velocity*0.5)
		chargetime+=delta
		if chargetime > 0.4:
			chargetime = 0.4
		Engine.time_scale *= 0.3
		$CanvasLayer/MistFiner.material.set_shader_parameter("line_density",0.07+chargetime/3.3)
		if Input.is_action_just_released("forward") and chargingdash:
			chargingdash = false
			var direction = Vector3(-sin(self.rotation.y), 0, -cos(self.rotation.y))
			apply_central_impulse(80*direction)
		dashcd = 1
	shootcd-=delta
	if Input.is_action_just_pressed("shoot") and shootcd <= 0 or chargingshot:
		$CanvasLayer/Gunarm.chargeshot(shootcharge)
		shootcd = 0.18
		if not chargingshot:
			shootcharge = 0
		chargingshot=true
		shootcharge+=delta
		if shootcharge > 5:
			shootcharge = 5
		if Input.is_action_just_released("shoot") and chargingshot:
			shoot(0.5+(shootcharge*3), 10+(shootcharge*10))
			chargingshot=false
		
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
	#END OF TEST CONTROLS
	
	apply_force(-self.linear_velocity*1.5)

func shoot(bigness,force):
	$CanvasLayer/Gunarm.shooted()
	var bullet = preload("res://boolet.tscn").instantiate()
	bullet.rotations = self.rotation
	bullet.setsize = bigness
	bullet.SHOOT = force
	bullet.shooter=self
	get_tree().current_scene.get_node("projectiles").add_child(bullet)

func damage(hurty):
	health -= hurty
	print("Player:"+str(health))
	if health <= 0:
		get_tree().change_scene_to_file("res://Main_menu.tscn")
