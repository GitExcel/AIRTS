extends ColorRect

@onready var text3 = $Context
@onready var timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func makeText(text2):
	text3.text = text2
	timer.start()


func _on_timer_timeout():
	text3.text = ""
	
