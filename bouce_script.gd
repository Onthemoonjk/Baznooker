extends RigidBody3D
@export var init_speed: Vector3

func _ready() -> void:
	self.linear_velocity = init_speed
	contact_monitor = true
	max_contacts_reported = 1
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	pass

func _on_body_entered(body: RigidBody3D):
	print("collided")
	body.linear_velocity *= 1.5
