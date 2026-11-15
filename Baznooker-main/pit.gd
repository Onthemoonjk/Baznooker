extends Area3D
var guystokill=[]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for guy in guystokill:
		guy.careaboutheight=false
		#guy.position.y-=(5*delta)
		guy.apply_central_force(Vector3(0,-9.81,0))
		if guy.position.y <= -16:
			guy.damage(guy.health)


func _on_body_entered(body: Node3D) -> void:
	guystokill.append(body)
	body.pitkiller=self
