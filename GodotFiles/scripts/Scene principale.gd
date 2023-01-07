extends Spatial


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_TAB:
			if $Champ.visible:
				$Champ.visible = false
				$Base.visible = true
			else:
				$Champ.visible = true
				$Base.visible = false
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
