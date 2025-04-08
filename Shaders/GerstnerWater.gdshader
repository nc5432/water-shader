shader_type spatial;
render_mode world_vertex_coords;

uniform vec3 color = vec3(0.1, 0.4, 0.8);
uniform float speed = 1.0;
uniform float amplitude = 0.2;
uniform float frequency = 1.0;
uniform int waveCount = 5;
uniform float amplitudeScaleFactor = 0.82;
uniform float frequencyScaleFactor = 1.18;
uniform float dirs[40];

uniform sampler2D depth: hint_depth_texture;

varying float baseHeight;

vec3 calcHeight(float x, float y){
	float amp = 1.0;
	float freq = 1.0;
	vec2 xOffset = vec2(0.0, 0.0);
	float yOffset = 0.0;
	for (int i = 0; i < waveCount; i++){
		xOffset += amplitude * amp * cos((frequency * freq * (speed * TIME + (dirs[2 * i] * x) + (dirs[2 * i + 1] * y)))) * dirs[2 * i + 1];
		yOffset += amplitude * amp * sin((frequency * freq * (speed * TIME + (dirs[2 * i] * x) + (dirs[2 * i + 1] * y))));
		amp *= amplitudeScaleFactor;
		freq *= frequencyScaleFactor;
	}
	return vec3(xOffset, yOffset);
}

void vertex() {
	baseHeight = VERTEX.y;
	vec3 offsets = calcHeight(VERTEX.x + 0.01, VERTEX.z);
	vec3 b = vec3(VERTEX.x + 0.01 + offsets[0], VERTEX.y + offsets[2], VERTEX.z + offsets[1]);
	offsets = calcHeight(VERTEX.x, VERTEX.z + 0.01);
	vec3 c = vec3(VERTEX.x + offsets[0], VERTEX.y + offsets[2], VERTEX.z + offsets[1] + 0.01);
	offsets = calcHeight(VERTEX.x, VERTEX.z);
	VERTEX.y += offsets[2];
	VERTEX.x += offsets[0];
	VERTEX.z += offsets[1];
	NORMAL = normalize(cross(c - VERTEX, b - VERTEX));
	baseHeight += VERTEX.y;
}

void fragment() {
	ALBEDO = color * clamp(baseHeight, 0.2, 11.0);
	//SPECULAR = 1.0;
	//float strength = baseHeight * texture(foamTex, UV).r;
	//if (strength >= foamHeight) ALBEDO = ALBEDO + vec3(1, 1, 1) * (strength + foamHeight);
	ALPHA = 0.9;
	float dep = texture(depth, SCREEN_UV).x;
	vec3 ndc = vec3(SCREEN_UV * 2.0 - 1.0, dep);
	vec4 view = INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
	view.xyz /= view.w;
	float linear_depth = -view.z;

	float object_depth = FRAGCOORD.z;
	vec3 object_ndc = vec3(SCREEN_UV * 2.0 - 1.0, object_depth);
	vec4 object_view = INV_PROJECTION_MATRIX * vec4(object_ndc, 1.0);
	object_view.xyz /= object_view.w;
	float linear_object_depth = -object_view.z;
	if (linear_depth - linear_object_depth <= 0.7){
		discard;
		//ALPHA = 0.9 * clamp(linear_depth - linear_object_depth - 0.7, 0.0, 1.0);
	}
}
