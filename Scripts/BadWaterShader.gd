extends MeshInstance3D

@export var amplitude: float = 1
@export var frequency: float = 1
@export var speed: float = 1
@export var waveCount: int = 5
@export var amplitudeScaleFactor: float = 0.82
@export var frequencyScaleFactor: float = 1.18
@export var dirs: Array[Vector2]

func TIME() -> float:
	return fmod(float(Time.get_ticks_msec()) / 1000, 3600)

func getSumEHeight(x: float, y: float) -> float:
	var amp: float = 1
	var freq: float = 1
	var offset: float = 0
	for i: int in range(waveCount):
		offset += amplitude * amp * pow(exp(1), sin(frequency * freq * (speed * TIME() + (dirs[i].x * x) + (dirs[i].y * y))))
		amp *= amplitudeScaleFactor
		freq *= frequencyScaleFactor
	return offset

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!visible): return
	var plane: PlaneMesh = PlaneMesh.new()
	plane.size = Vector2(50, 50)
	plane.subdivide_depth = 50
	plane.subdivide_width = 50
	var msh: ArrayMesh = ArrayMesh.new()
	msh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, plane.get_mesh_arrays())
	
	var mdt: MeshDataTool = MeshDataTool.new()
	mdt.create_from_surface(msh, 0)
	for i: int in range(mdt.get_vertex_count()):
		var vertex: Vector3 = mdt.get_vertex(i)
		vertex.y = getSumEHeight(global_position.x + vertex.x, global_position.z + vertex.z)
		var b: Vector3 = Vector3(global_position.x + vertex.x + 0.01, getSumEHeight(global_position.x + vertex.x + 0.01, global_position.z + vertex.z), global_position.z + vertex.z)
		var c: Vector3 = Vector3(global_position.x + vertex.x, getSumEHeight(global_position.x + vertex.x, global_position.z + vertex.z + 0.01), global_position.z + vertex.z + 0.01)
		var normal: Vector3 = (c - vertex).cross(b - vertex).normalized()
		mdt.set_vertex(i, vertex)
		mdt.set_vertex_normal(i, normal)
	msh.clear_surfaces()
	mdt.commit_to_surface(msh)
	mesh = msh
