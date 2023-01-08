extends MeshInstance
export (Material) var damageMaterial = preload("res://materials et shaders/Batiment/Damage.tres")
export (Material) var activeMaterial = preload("res://materials et shaders/Batiment/Active.tres")
export (Material) var idleMaterial = preload("res://materials et shaders/Batiment/Idle.tres")
var status = "active"

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_D:
			set_damage()
		if event.scancode == KEY_A:
			set_actif()
		if event.scancode == KEY_I:
			set_inactif()

func set_damage(): # Asign damage (red color) to building
	self.get_mesh().surface_set_material(0,damageMaterial)
	status = "damage"

func set_actif(): # Asign active (green color) to building
	self.get_mesh().surface_set_material(0,activeMaterial)
	status = "active"

func set_inactif(): # Asign idle (yellow color) to building
	
	self.get_mesh().surface_set_material(0,idleMaterial)
	status = "idle"
	
func status():
	return status
	


func _ready():
	set_inactif()

#func _process(delta):
#	pass
