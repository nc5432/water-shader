shader_type spatial;

void fragment() {
	if (TIME < 0.5){
		ALBEDO = vec3(0.0, 0.0, 0.0);
	}else if (TIME >= 0.5 && TIME <= 1.0){
		ALBEDO = vec3(0.5, 0.5, 0.5);
	}else if (TIME > 1.0){
		ALBEDO = vec3(1.0, 0.0, 0.0);
	}
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
