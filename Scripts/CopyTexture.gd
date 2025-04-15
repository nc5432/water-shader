extends SubViewport

@onready var textureRect: TextureRect = $TextureRect
@onready var shader: ShaderMaterial

func _ready() -> void:
	shader = $ColorRect.material

func _process(delta: float) -> void:
	textureRect.texture = get_texture()
	shader.set_shader_parameter("tex", textureRect.texture)
