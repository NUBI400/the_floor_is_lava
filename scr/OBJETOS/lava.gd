@tool
extends Node3D
@onready var texture_csg: CSGBox3D = $texture_csg

@export var speed: Vector3
@export var speed_multiplier: float = 1.0
var off: Vector3 = Vector3.ZERO

func _physics_process(delta: float) -> void:
	off += speed * speed_multiplier * delta
	texture_csg.material.albedo_texture.noise.offset = off
