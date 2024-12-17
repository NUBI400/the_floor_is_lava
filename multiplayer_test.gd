extends Node3D
 
var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene
 
@onready var canvas_layer: CanvasLayer = $CanvasLayer

func _on_host_pressed():
	peer.create_server(135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	_add_player()
	canvas_layer.hide()
 
func _add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child",player)
	

 
func _on_join_pressed():
	peer.create_client("localhost", 135)
	multiplayer.multiplayer_peer = peer
	canvas_layer.hide()

func exit_game(id):
	multiplayer.peer_disconnected.connect(del_player)
	del_player(id)

func del_player(id):
	rpc("_del_player", id)

@rpc("any_peer","call_local")
func _del_player(id):
	get_node(str(id)).queue_free()
