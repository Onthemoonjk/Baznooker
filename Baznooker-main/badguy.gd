extends RigidBody3D
var health = 100
var flash = 0
var shaking = false
@onready var sol = $SOLBADGUY
@onready var camera = get_viewport().get_camera_3d()
@onready var direction = "for"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sol.play(direction+"run")
	body_entered.connect(_on_body_entered)

func finddir():
	var greg = dot(Vector3(-sin(get_viewport().get_camera_3d().global_rotation.y), 0, -cos(get_viewport().get_camera_3d().global_rotation.y)),Vector3(-sin(self.global_rotation.y), 0, -cos(self.global_rotation.y)))
	if abs(greg) < 45:
		return "bac"
	if abs(greg) < 135:
		if greg > 0:
			return "lef"
		else:
			return "rig"
	else:
		return "for"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	direction = finddir()
	if health > 0:
		sol.play(direction+"run")

func _physics_process(delta: float) -> void:
	flash -= delta
	if health <= 0:
		freeze = true
		$CollisionShape2D.disabled = true
		$SOLBADGUY.play("dierun")
	if flash <= 0:
		flash = 0
	if shaking:
		$SOLBADGUY.position.x=RandomNumberGenerator.new().randf_range(tanh(-flash),0)
	if flash == 0:
		$SOLBADGUY.position = Vector3(0,0,0)
		shaking = false
		flash = 0
	if abs(0 - position.y) > 0.1:
		position.y=0
		linear_velocity.y=0
	
	angular_velocity*=0.8**delta
	var brungitis = dot(Vector3(-sin(camera.global_rotation.y), 0, -cos(camera.global_rotation.y)),Vector3(-sin(self.global_rotation.y), 0, -cos(self.global_rotation.y)))
	var GOLDDD = 2.5
	GOLDDD*=((180/(abs(brungitis)+180)))
	if brungitis > 0:
		apply_torque(Vector3(0,GOLDDD,0))
	else:
		apply_torque(Vector3(0,-GOLDDD,0))
	if abs(brungitis)-180 < 14:
		apply_central_force(15*Vector3(-sin(self.rotation.y), 0, -cos(self.rotation.y)))

func _on_solbadguy_animation_finished() -> void:
	if $SOLBADGUY.animation == "dierun":
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.damage(linear_velocity.length()*2)
	if body.is_in_group("Character"):
		body.damage(linear_velocity.length()/2)
		print("damage player")

func damage(hurty):
	health -= hurty
	shake(0.01*hurty)

func shake(time):
	flash = 0.1*time
	shaking = true

func dot(vector1: Vector3, vector2: Vector3) -> float:
	return rad_to_deg(vector1.signed_angle_to(vector2,Vector3.UP))
