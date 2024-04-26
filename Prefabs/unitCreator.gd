extends StaticBody2D


var entered = false;
var selected = false;
var soldier = preload("res://Prefabs/soldier.tscn")
var worker = preload("res://Prefabs/worker.tscn")
@onready var resourcestore = get_tree().get_first_node_in_group("resourceStore")


# Called when the node enters the scene tree for the first time.
func _ready():
	resourcestore.buildings.append(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if entered == true && Input.is_action_just_pressed("Select"):
		selected = true
	if !entered && Input.is_action_just_pressed("Select"): 
		selected = false
		
	if selected && Input.is_action_just_pressed("Move"):
		print("moved")
		$Marker2D.global_position = get_global_mouse_position()
	
	if selected:
		$Marker2D/Sprite2D.visible = true
		selectedlogic()
	if !selected:
		$Marker2D/Sprite2D.visible = false
		notSelectedLogic()
		
func selectedlogic():
	$Button.disabled = false
	$Button.visible = true
	$Button2.disabled = false
	$Button2.visible = true
	
	
func notSelectedLogic():
	$Button.disabled = true
	$Button.visible = false
	$Button2.disabled = true
	$Button2.visible = false
	


func _on_mouse_entered():
	entered = true


func _on_mouse_exited():
	entered = false







func _on_button_mouse_entered():
	entered = true
	print("entered")
	


func _on_button_mouse_exited():
	entered = false
	print("exit")


func _on_button_pressed():
	if resourcestore.minerals >= 20:
		resourcestore.minerals -= 20
		var instance = soldier.instantiate()
		get_tree().root.add_child(instance)
		instance.position = self.position
		instance.moved = true
		instance.nav2d.target_position = $Marker2D.global_position
	else:
		print("not enough minerals")


func _on_area_2d_body_entered(body):
	if body.target == self:
		body.addResource()
		body.returnToBase = false
		body.needTarget = true


func _on_button_2_pressed():
	if resourcestore.gas >= 20:
		resourcestore.gas -= 20
		var instance = worker.instantiate()
		get_tree().root.add_child(instance)
		instance.position = self.position
		instance.position.y = self.position.y - 5
	else:
		print("not enough gas")
