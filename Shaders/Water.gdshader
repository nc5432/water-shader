shader_type spatial;
render_mode world_vertex_coords;

uniform vec3 color = vec3(0.1, 0.4, 0.8);
uniform float reflectiveness = 10.0;
uniform float foamHeight = 0.2;
uniform sampler2D foamTex;

const int WAVE_COUNT = 6;
uniform float amplitudes[WAVE_COUNT];
uniform float waveSpeeds[WAVE_COUNT];
uniform float xAmplifiers[WAVE_COUNT];
uniform float yAmplifiers[WAVE_COUNT];

varying float yOffset;

float calcHeight(float x, float y){
	float offset = 0.0;
	for (int i = 0; i < WAVE_COUNT; i++){
		offset += amplitudes[i] * pow(E, sin((waveSpeeds[i] * TIME) + (xAmplifiers[i] * (x)) + (yAmplifiers[i] * (y))));
	}
	return offset;
}

void vertex() {
	yOffset = VERTEX.y;
	vec3 b = vec3(VERTEX.x, VERTEX.y + calcHeight(VERTEX.x + 0.01, VERTEX.z), VERTEX.z);
	vec3 c = vec3(VERTEX.x, VERTEX.y + calcHeight(VERTEX.x, VERTEX.z + 0.01), VERTEX.z);
	VERTEX.y += calcHeight(VERTEX.x, VERTEX.z);
	NORMAL = normalize(cross(b - VERTEX, c - VERTEX));
	yOffset += VERTEX.y;
}

void fragment() {
	ALBEDO = color * clamp(0.8 + yOffset, 0.2, 2);
	float strength = yOffset * texture(foamTex, UV).r;
	if (strength >= foamHeight) ALBEDO = ALBEDO + vec3(1, 1, 1) * (strength + foamHeight);
	//ALPHA = 0.9;
	//ALBEDO = (NORMAL + 1.0) / 2.0;
}

//void light() {
	//DIFFUSE_LIGHT += clamp(dot(NORMAL, LIGHT), 0.0, 1.0) * ATTENUATION * LIGHT_COLOR;
	//vec3 halfVector = normalize(normalize(VIEW) + normalize(LIGHT));
	//SPECULAR_LIGHT += clamp(pow(dot(NORMAL, halfVector), reflectiveness), 0.0, 1.0) * LIGHT_COLOR;
//}
