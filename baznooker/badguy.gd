extends RigidBody3D
@onready var sol = $SOLBADGUY
@onready var direction = "for"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sol.play(direction+"run")

func finddir():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	direction = finddir()
	
func _physics_process(delta: float) -> void:
	position.y = 0

func _on_solbadguy_animation_finished() -> void:
	pass # Replace with function body.
