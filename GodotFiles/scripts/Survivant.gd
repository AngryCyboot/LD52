extends Spatial

var camera
var isSelected = false
var from
var to

var Botanist = int()
var Engineering = int()
var Chemistry = int()

var Class = "Survivant"

var Class_list = [
				"Survivant",  # Sans spé
				"Ingénieur",
				"Botaniste",
				"Chimiste"
				]

func _ready():
	camera = $"../Camera"
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton and event.is_pressed():
		isSelected = true

func _physics_process(delta):
	if isSelected == true :
		var mouse_pos = get_viewport().get_mouse_position()
		from = camera.project_ray_origin(mouse_pos)
		to = from + camera.project_ray_normal(mouse_pos) * 10000
		var space_state = get_world().get_direct_space_state()
		var result = space_state.intersect_ray( from, to)
		if result:
			self.transform.origin = result.position
		isSelected = false
	pass
