extends RichTextLabel

signal timer_finished  # Sinal que será emitido quando o timer chegar a 0

@export var countdown_time: int = 180  # Tempo inicial em segundos

var current_time: int  # Variável para armazenar o tempo atual

func _ready() -> void:
	current_time = countdown_time  # Inicia o timer com o tempo configurado
	update_timer_text()
	start_timer()

func start_timer() -> void:
	var timer = Timer.new()
	timer.wait_time = 1.0  # Tempo de espera para decrementar o tempo (1 segundo)
	timer.autostart = true
	timer.one_shot = false  # Para que ele se repita até o tempo zerar
	add_child(timer)
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	if current_time > 0:
		current_time -= 1
		update_timer_text()
		if current_time == 0:
			emit_signal("timer_finished")  # Emite o sinal quando chegar a 0
	else:
		for child in get_children():
			if child is Timer:
				child.queue_free()
func update_timer_text() -> void:
	text = "Time left: %d" % current_time
