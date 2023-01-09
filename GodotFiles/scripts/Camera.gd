extends Camera

var from
var to
var result
var mouse_pos
var space_state
var Survivant
var mousePressed
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"



func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_TAB:
			if $Champ.visible:
				$Champ.visible = false
				$Base.visible = true
			else:
				$Champ.visible = true
				$Base.visible = false
	if event is InputEventMouseButton :
		mousePressed = event.is_pressed()
	pass
	
func _physics_process(delta):
	var exclude = Array()
	if Survivant:
		var patate = Survivant.get_child(0)
		exclude = [patate.get_child(0)]
	mouse_pos = get_viewport().get_mouse_position()
	from = self.project_ray_origin(mouse_pos)
	to = from + self.project_ray_normal(mouse_pos) * 10000
	space_state = get_world().get_direct_space_state()
	result = space_state.intersect_ray( from, to, exclude)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) :
	if result:
		var truc = result.collider.get_parent()
		if truc.name == "Survivant_mesh":
			truc = truc.get_parent() #Sshhh !
			truc.up()
			if mousePressed:
				Survivant = truc
	if not mousePressed:
		Survivant = null
	if Survivant:
		Survivant.placing(result.position)
	pass
