extends Camera2D

@export var speed = 10
@export var zoomzpeed = Vector2(0.1, 0.1)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Camera up"):
		
		position.y -= speed
	if Input.is_action_pressed("Camera Down"):
		
		position.y += speed
	if Input.is_action_pressed("Camera left"):
		position.x -= speed
	if Input.is_action_pressed("Camera right"):
		position.x += speed
	if Input.is_action_just_pressed("Mouse zoom in"):
		if self.zoom < Vector2(2, 2):
			
			self.zoom += zoomzpeed
	if Input.is_action_just_pressed("Camera zoom out"):
		if self.zoom > Vector2(0.1,0.1):
			
			self.zoom -= zoomzpeed
		
	 
