extends MeshInstance

signal scream

export (Material) var damageMaterial #= preload("res://materials et shaders/Batiment/Damage.tres")
export (Material) var activeMaterial #= preload("res://materials et shaders/Batiment/Active.tres")
#export (Material) var idleMaterial = preload("res://materials et shaders/Batiment/Idle.tres")

export (int) var Food = 0
export (int) var Oxy = 0
export (int) var Energy = 0
export (int) var Water = 0
export (int) var Shit = 0

var prod = Array()


var active = false
export var plant = false
export var damage = false
export var needSurvivorDefault = true
var survivors = 0
var needSurvivor = true
export var stage = 0

#func _input(event):
	#if event is InputEventKey and event.pressed:
		#if event.scancode == KEY_D:
			#set_damage()
		#if event.scancode == KEY_A:
			#set_actif()
		#if event.scancode == KEY_I:
			#set_inactif()

func grow():
	if stage == 5:
		Food = 8
		stage = 0
	else:
		Food = 0
		stage += 1
		
func body_entered(_plop):
	survivors += 1
	pass

func body_exited(_plop):
	survivors -= 1
	pass

func repair():
	damage = false

func set_damage(): # Asign damage (red color) to building
	if damage:
		self.set_surface_material(0,damageMaterial)
	else:
		self.set_surface_material(0,activeMaterial)
	
	#status = "damage"

func set_actif(): # Asign active (green color) to building
	#self.get_mesh().surface_set_material(0,activeMaterial)
	active = true
	$SpotLight.visible = active
	emit_signal("scream")
	#status = "active"
	
func set_inactif(): # Asign idle (yellow color) to building
	#self.get_mesh().surface_set_material(0,idleMaterial)
	active = false
	$SpotLight.visible = active
	#status = "idle"
	
func status():
	prod = [Energy,Oxy,Shit,Water,Food,active,damage,stage,needSurvivor]
	return prod
	
func _ready():
	set_inactif()
	set_damage()
	needSurvivor = needSurvivorDefault
	


func _process(delta):
	if damage:
		needSurvivor = true
	else:
		needSurvivor = needSurvivorDefault
	set_damage()
	if needSurvivor:
		$Placement.visible = true
		$Area.monitoring = true
	else:
		$Placement.visible = false
		$Area.monitoring = false
	if survivors > 0 :
		set_actif()
	else:
		set_inactif()
	pass
