extends RigidBody3D


@onready var col = $"collision"
@onready var visual = $"400kdollars"
var setsize = 1
var shooter 
var rotations
var SHOOT
var lifetime = 2
#@onready var setsize


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.linear_damp = 0
	var dir = -shooter.global_transform.basis.z
	global_position = shooter.global_position+0.9*shooter.global_transform.basis.x+0.4*shooter.global_transform.basis.y
	self.scale *= setsize
	visual.play("test")
	apply_central_impulse(SHOOT*dir)
	body_entered.connect(_on_body_entered)
	contact_monitor = true
	max_contacts_reported = 1
	var jim = RandomNumberGenerator.new()
	visual.modulate = Color(jim.randf_range(0.25,1.45), jim.randf_range(0.5,2.75), jim.randf_range(0.4,1.65))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lifetime-=delta
	if lifetime <= 0:
		queue_free()

func _physics_process(delta: float) -> void:
	if linear_velocity.y > 0:
		linear_velocity.y=0

func _on_body_entered(body: RigidBody3D):
	if body.is_in_group("Enemy"):
		body.damage(linear_velocity.length()/10)
		shooter.dashcd=0
	queue_free()
