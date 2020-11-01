class_name WeaponPickup extends RigidBody

var collision_shape = null
var weapon = null

func set_weapon(_weapon):
	if collision_shape:
		collision_shape.queue_free()
	if weapon:
		weapon.queue_free()
	weapon = _weapon
	weapon.transform = Transform.IDENTITY
	if weapon.get_parent():
		weapon.get_parent().remove_child(weapon)
	if weapon:
		add_child(weapon)
		weapon.mesh_instance.transform.origin = Vector3(0,0,0)
		collision_shape = CollisionShape.new()
		collision_shape.shape = weapon.mesh_instance.get_node("Armature/Skeleton").get_child(0).mesh.create_convex_shape()
		add_child(collision_shape)
	else:
		queue_free()
	apply_impulse(Vector3(0,0,0),Vector3(0,8,0))

func generate():
	set_weapon(Item.new())

func _ready():
	generate()
	add_collision_exception_with(get_node("../../Player"))
