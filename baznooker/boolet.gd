extends RigidBody3D


@onready var col = $"collision"
@onready var visual = $"400kdollars"
var setsize = 1
var shooter 
var rotations
var SHOOT
var lifetime = 4


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.linear_damp = 0
	var dir = -shooter.global_transform.basis.z
	global_position = shooter.global_position+3*dir
	self.scale *= setsize
	visual.play("test")
	apply_central_impulse(SHOOT*dir)
	shooter.apply_central_impulse(-0.5*SHOOT*dir)
	body_entered.connect(_on_body_entered)
	contact_monitor = true
	max_contacts_reported = 1
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lifetime-=delta
	if lifetime <= 0:
		queue_free()

func _physics_process(delta: float) -> void:
	pass
	
func _on_body_entered(body: RigidBody3D):
#	body.damage(10)
	queue_free()
