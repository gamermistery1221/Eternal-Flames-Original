extends KinematicBody2D

signal hp_max_changed(new_hp_max)
signal hp_changed(new_hp)
signal died

export(bool) var enemy_is_alive = true 
export(bool) var player_is_alive = true
export(int) var hp_max: int = 20 setget set_hp_max
export(int) var hp: int = hp_max setget set_hp, get_hp
export(int) var defense: int = 0

export(int) var SPEED: int = 75
var velocity: Vector2 = Vector2.ZERO

onready var animatedsprite = $AnimatedSprite
onready var collshape = $CollisionShape2D

func get_hp():
	return hp

func set_hp(value):
	if value != hp:
		hp = clamp(value, 0, hp_max)
		emit_signal("hp_changed", hp)
		if hp == 0:
			emit_signal("died")

func set_hp_max(value):
	if value != hp_max:
		hp_max = max(0, value)
		emit_signal("hp_max_changed", hp_max)
		self.hp = hp

func die():
	player_is_alive = false

func receive_damage(base_damage: int):
	var actual_damage = base_damage - defense
	
	self.hp -= actual_damage
	print(name + " has a total of " + str(self.hp) + " hp")

func _on_Hurtbox_area_entered(hitbox):
	receive_damage(hitbox.damage)


func _on_EntityBase_died():
	die()
