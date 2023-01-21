extends Spatial

var SpecialityList = ["Engineer", "Biologist", "Chemist", "Survivor"] #Enumeration avec les differentes classes
var Speciality = SpecialityList[randi() % SpecialityList.size()] # choix random dans SpecialityList

# charge les matériaux selon les spé des colons
var EngineerMaterial = preload("res://materials et shaders/Engineer.tres")
var ChemistMaterial = preload("res://materials et shaders/Chemist.tres")
var BiologistMaterial = preload("res://materials et shaders/Biologist.tres")

var isUpTime = 0
var time = 0
var isUp = false
var alive = true

var Botanist = int()
var Engineering = int()
var Chemistry = int()


func _ready():
	getSpeciality()  #Donne les attributs des spé aux colons

func dead():
	self.visible = false
	alive = false
	$Survivant_mesh/RigidBody/CollisionShape.disabled =true

func placing(var pos):
	if alive:
		self.transform.origin.x = pos.x
		self.transform.origin.z = pos.z
		isUpTime = time
		isUp = true
	
func up():
	time = Time.get_ticks_msec()
	if (time - isUpTime) > 100 and not isUp and alive:
		$Survivant_mesh.transform.origin.y = 1
		isUpTime = Time.get_ticks_msec()
		isUp = true
	pass

func _process(delta):
	time = Time.get_ticks_msec()
	if ((time - isUpTime) > 300 or not alive) and isUp:
		$Survivant_mesh.transform.origin.y = 0.5
		isUp = false
	pass
	
func getSpeciality():
	print(Speciality)
	if Speciality == "Engineer":
		$Survivant_mesh.set_surface_material(0,EngineerMaterial)
		print("Im engineer")
	if Speciality == "Biologist":
		$Survivant_mesh.set_surface_material(0,BiologistMaterial)
		print("Im Biologist")
	if Speciality == "Chemist":
		$Survivant_mesh.set_surface_material(0,ChemistMaterial)
		print("Im Chemist")
	if Speciality == "Survivor":# ce n'est pas très efficace
		print("Im just a man or wowan")
