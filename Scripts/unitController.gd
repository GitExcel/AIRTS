extends Node2D



#var clickbox = preload("res://Prefabs/clickbox.tscn")
var soldierArray = []
var activeSoldiers = []
var deselect = true
@onready var attackManager = get_tree().get_first_node_in_group("attackManager")

#####THIS IS THE SELECT CODE, TAKEN FROM: https://kidscancode.org/godot_recipes/3.x/input/multi_unit_select/index.html#:~:text=Realtime%20strategy%20(RTS)%20games%20often,map%20commands%20them%20to%20move.
var dragging = false  
var selected = []  
var drag_start = Vector2() 
var select_rect = RectangleShape2D.new()  


	
func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		
			
		if event.is_pressed():
			
			for i in attackManager.soldiers.size():
				attackManager.soldiers[i].selected = false
			
			if selected.size() == 0:
				dragging = true
				drag_start = get_global_mouse_position()
			else:
				#for item in selected:
					#if item.collider !=null:
						#item.collider.selected = false
				selected = []
				
		elif dragging:
			
			dragging = false
			queue_redraw()
			var drag_end = event.position
			select_rect.size = (drag_end - drag_start).abs()
			var space = get_world_2d().direct_space_state
			var query = PhysicsShapeQueryParameters2D.new()
			query.set_shape(select_rect)
			query.collision_mask = 2
			query.transform = Transform2D(0, (drag_end + drag_start) / 2)
			selected = space.intersect_shape(query)
			
			for item in selected:
				for i in attackManager.soldiers.size():
					if item.collider == attackManager.soldiers[i]:
						
						item.collider.selected = true
						break
	if event is InputEventMouseMotion and dragging:
		queue_redraw()
		
func _draw():
	if dragging:
		
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start),
				Color.YELLOW, false, 2.0)
			
		
