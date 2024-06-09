extends "res://Scripts/EntityBasesScript/EntityBase.gd"


var direction = Vector2()
export(int) var speed = 3
var fireball = preload("res://Instantiables/Fireball.tscn")
var atacou = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Animação
	anim()
	#Movimentação
	move()
	#Atirar bola de fogo
	shoot()

#Movimentação
func move():
	if Input.is_key_pressed(KEY_D):
		direction.x = speed
		get_child(0).flip_h = false
	elif Input.is_key_pressed(KEY_A):
		direction.x = -speed
		get_child(0).flip_h = true
	else:
		direction.x = 0
	if Input.is_key_pressed(KEY_W):
		direction.y = -speed
	elif Input.is_key_pressed(KEY_S):
		direction.y = speed
	else:
		direction.y = 0
	
	move_and_collide(direction)
#Animação
func anim():
	if get_child(0).animation == "Attack" and get_child(0).frame == get_child(0).frames.get_frame_count("Attack") - 1:
		atacou = false
	if Input.is_action_just_pressed("fb"):
		get_child(0).animation = "Attack"
		atacou = true
	if not atacou:
		if direction.x == 0 and direction.y == 0:
			get_child(0).animation = "Idle"
		else:
			get_child(0).animation = "Walk"
#Atirar Bolas de fogo
func shoot():
	if Input.is_action_just_pressed("fb"):
		var newFireball = fireball.instance()
		newFireball.global_position = position
		get_parent().add_child(newFireball)
