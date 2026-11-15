extends Node2D
@onready var hand = $TheHandInQuestion
var x = 749
var y = 246
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#test thing, hardcoded, make better eventually
	
	hand.play("Equip_Bingus")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_the_hand_in_question_animation_finished() -> void:
	#hardcoded make better later
	#if hand.animation=="Equip_Bingus":
	hand.play("Cool_Bingus")
func shooted():
	hand.play("Shoot_Bingus")
	position=Vector2(0,0)

func chargeshot(shootcharge):
	position.y=RandomNumberGenerator.new().randf_range(-10*shootcharge,0)
	position.x=RandomNumberGenerator.new().randf_range(-10*shootcharge,0)
