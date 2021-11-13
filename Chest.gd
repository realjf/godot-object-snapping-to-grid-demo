extends Node2D


var rect = Rect2(0,0,0,0)
var mouse_tile
var collision = false

func _ready():
	pass


func _process(delta):
	mouse_tile = get_parent().tilemap.world_to_map(get_global_mouse_position())
	var local_pos = get_parent().tilemap.map_to_world(mouse_tile)
	var world_pos = get_parent().tilemap.to_global(local_pos)
	global_position = world_pos
	

func _input(event):
	if Input.is_action_pressed("build"):
		var cell_size = get_parent().tilemap.get_cell_size()
		var offsetx = global_position.x - (mouse_tile.x) * cell_size.x
		var offsety = global_position.y - (mouse_tile.y) * cell_size.y
		rect = Rect2(offsetx, offsety, cell_size.x+1, cell_size.y+1)
		update()
		if event is InputEventMouseButton and event.is_pressed() and event.button_index == BUTTON_LEFT:
			# place the chest
			if !collision:
				set_process(false)
				rect = Rect2(0,0,0,0)
	else:
		rect = Rect2(0,0,0,0)

func _draw():
	if collision:
		draw_rect(rect, Color.red)
	else:
		draw_rect(rect, Color.green)
	
	
func _on_Area2D_body_entered(body):
	collision = true
	
	


func _on_Area2D_body_exited(body):
	collision = false
