extends Node2D



#var clickbox = preload("res://Prefabs/clickbox.tscn")
var soldierArray = []
var activeSoldiers = []
var deselect = true
@onready var attackManager = get_tree().get_first_node_in_group("attackManager")

#####THIS IS THE SELECT CODE
var dragging = false  # Are we currently dragging?
var selected = []  # Array of selected units.
var drag_start = Vector2() # Location where drag began.
var select_rect = RectangleShape2D.new()  # Collision shape for drag box.


	
func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		
			
		if event.is_pressed():
			print("test2")
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
			print("test")
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
			print(selected)
			for item in selected:
				for i in attackManager.soldiers.size():
					if item.collider == attackManager.soldiers[i]:
						print("its in")
						item.collider.selected = true
						break
	if event is InputEventMouseMotion and dragging:
		queue_redraw()
		
func _draw():
	if dragging:
		
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start),
				Color.YELLOW, false, 2.0)
			
		
###THIS IS THE SELECT CODE


# Called when the node enters the scene tree for the first time.
#func _ready():
	#var instance = clickbox.instantiate()
	#add_child(instance)
	##soldierArray = get_tree().get_nodes_in_group("soldiers")
	##print(soldierArray)
	#
	#
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if Input.is_action_just_pressed("Select"):
		#checkSelected()
		#
	#
	#for i in soldierArray.size() - 1:
		#
			#
		#if soldierArray[i].selected == true:
			#print("active")
			#activeSoldiers.append(soldierArray[i])
			#soldierArray.remove_at(i)
			#print(activeSoldiers)
			#
	#for i in activeSoldiers.size() - 1:
		#if activeSoldiers[i].selected == false:
			##print(i)
			##print("deactivate")
			#soldierArray.append(activeSoldiers[i])
			#activeSoldiers.remove_at(i)
			#
#func checkSelected():
	#deselect = true
	#for i in soldierArray.size() - 1:
		#if soldierArray[i].mouseIn == true:
			#deselect = false
	#if deselect == true:
		#for i in activeSoldiers.size() - 1:
			#activeSoldiers[i].selected = false
	#if deselect == false:
		#for i in activeSoldiers.size() - 1:
			#activeSoldiers[i].selected = true
		
			
	
#for item in selected:
				#for i in attackManager.soldiers.size():
					#if item.collider == attackManager.soldiers[i]:
						#print("its in")
						#item.collider.selected = true
						#break
		
