extends Control


@onready var lava_rising: RichTextLabel = $lava_rising

@onready var timer: RichTextLabel = $timer

@onready var lava: Node3D = $"../../Lava"
var lava_up = false

func _ready() -> void:
	# Configura o texto com efeito wave e alinhamento central horizontal
	lava_rising.text = "[rainbow freq=1.0 sat=0.8 val=0.8][center][wave amp=50.0 freq=5.0 connected=1]RISING LAVA[/wave][/center][/rainbow]"

func _on_timer_timer_finished() -> void:
	timer.visible = false
	lava_rising.visible = true
	lava_up = true


func _physics_process(delta: float) -> void:
	if lava_up:
		lava.position.y += 0.001
		print(lava.position.y)
	
