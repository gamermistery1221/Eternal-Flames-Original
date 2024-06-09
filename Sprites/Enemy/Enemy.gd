extends CharacterBody2D
@export var MoveSpeed:float=20
@export var Damage:float=1
@onready var Sprite=$AnimatedSprite2D
var Direction:bool=1
func _process(_delta):
	if is_on_wall():
		DealDamage()
		if Direction:
			Direction=false
		else:
			Direction=true
	if Direction:
		velocity.x=MoveSpeed
		Sprite.flip_h=false
	else:
		velocity.x=-MoveSpeed
		Sprite.flip_h=true
	move_and_slide()
	
func DealDamage():
	if get_slide_collision(0).get_collider().name=="Player":
			get_slide_collision(0).get_collider().call("TakeDamage",Damage)
