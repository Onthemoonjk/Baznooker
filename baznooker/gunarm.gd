extends Node2D
@onready var hand = $TheHandInQuestion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#test thing, hardcoded, make better eventually
	
	hand.play("Equip_Bingus")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_the_hand_in_question_animation_finished() -> void:
	#hardcoded make better later
	if hand.animation=="Equip_Bingus":
		hand.play("Hold_Bingus")
