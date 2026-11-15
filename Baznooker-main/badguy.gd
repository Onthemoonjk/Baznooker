extends RigidBody3D
@onready var sol = $SOLBADGUY
@onready var direction = "for"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sol.play(direction+"run")


func finddir():
	var greg = dot(Vector3(-sin(get_viewport().get_camera_3d().global_rotation.y), 0, -cos(get_viewport().get_camera_3d().global_rotation.y)),Vector3(-sin(self.global_rotation.y), 0, -cos(self.global_rotation.y)))
	print(greg)
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
	#print(direction)
	sol.play(direction+"run")
	
	
func _physics_process(delta: float) -> void:
	#position.y = 0
	if abs(0 - position.y) > 0.1:
		position.y=0
		linear_velocity.y=0
		

func _on_solbadguy_animation_finished() -> void:
	pass # Replace with function body.



func dot(vector1: Vector3, vector2: Vector3) -> float:
	return rad_to_deg(vector1.signed_angle_to(vector2,Vector3.UP))
