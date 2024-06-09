extends Node2D

@onready var col=$AnimatedSprite2D/ShapeCast2D
func _process(_delta):
	if col.is_colliding() and col.get_collider(0).name=="Player":
		col.get_collider(0).call("Victory")
