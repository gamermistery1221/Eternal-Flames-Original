extends "res://Scripts/EntityBasesScript/EntityBase.gd"

var player
var angle
var speed = 3
var atacou = false

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_parent().get_child(1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	follow()
	if self.hp > 1:
		enemy_is_alive = true
	if get_parent().get_child(1).hp <= 0:
		player_is_alive = false
func follow():
	if player_is_alive:
		angle = get_angle_to(player.position)
		if get_child(0).animation == "Attack" and get_child(0).frame == get_child(0).frames.get_frame_count("Attack") -1:
			atacou = false
		if position.distance_to(player.position) < 50:
				atacou = true
				get_child(0).animation = "Attack"
		if not atacou:
			if position.distance_to(player.position) < 300:
				move_and_collide(Vector2(1,0).rotated(angle) * speed)
				get_child(0).animation = "Walk"
			else:
				get_child(0).animation = "Idle"
		if(player.position.x - position.x) < 0:
			get_child(0).flip_h = true
		else:
			get_child(0).flip_h = false
	else:
		get_child(0).animation = "Idle"
func _on_EntityBase_died():
	player_is_alive = false
