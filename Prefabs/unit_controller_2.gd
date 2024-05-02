extends Node2D

var isDragging = false
var selectedUnits = []
var dragStart = Vector2()
var selectedRectangle = RectangleShape2D.new()
@onready var attackManager = get_tree().get_first_node_in_group("attackManager")
#THIS CODE IS FROM A TUTORIAL BY: https://kidscancode.org/godot_recipes/3.x/input/multi_unit_select/
# IT WAS TINKERED SLIGHLY TO WORK FOR GODOT 4 HERE; https://godotforums.org/d/33401-whats-the-godot-4-equivalent-of-extents
func _unhandled_input(event): 
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			if selectedUnits.size() == 0:
				isDragging = true
				dragStart = get_global_mouse_position()
			else:
				
				for item in selectedUnits:
					if item.collider !=null:
						item.collider.selected = false
				selectedUnits = []
					
		
		elif isDragging == true:
			isDragging = false
			queue_redraw()
			var dragEnd = get_global_mouse_position()
			selectedRectangle.size = (dragEnd - dragStart).abs()
			
			var space = get_world_2d().direct_space_state
			var query = PhysicsShapeQueryParameters2D.new()
			query.collision_mask = 2
			query.set_shape(selectedRectangle)
			query.transform = Transform2D (0, (dragEnd + dragStart) / 2)
			selectedUnits = space.intersect_shape(query)
			
			
			for selection in selectedUnits:
				
				selection.collider.selected = true
			
	if event is InputEventMouseMotion and isDragging == true:
		queue_redraw()
		
func _draw():
	if isDragging == true:
		draw_rect(Rect2 (dragStart, get_global_mouse_position() - dragStart), Color.DARK_GREEN, false)
