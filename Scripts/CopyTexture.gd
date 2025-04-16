extends SubViewport

@export var shaderObject: ColorRect
@export var shader: ShaderMaterial

@export var tex: Texture2D

func _ready() -> void:
	var result: Error = ResourceSaver.save(ImageTexture.create_from_image(tex.get_image()), "iconImage")
	print(result)

func _process(delta: float) -> void:
	await RenderingServer.frame_post_draw
	var img: Image = get_texture().get_image()
	tex = ImageTexture.create_from_image(img)
	shader.set_shader_parameter("tex", tex)
