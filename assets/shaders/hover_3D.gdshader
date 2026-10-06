shader_type spatial;
render_mode unshaded, cull_front;

uniform vec4 couleur : source_color = vec4(1.0);
uniform float epaisseur = 3.0; // en pixels

void vertex() {
	vec4 clip = PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(VERTEX, 1.0);
	vec3 normale_vue = mat3(MODELVIEW_MATRIX) * NORMAL;
	vec2 direction = (PROJECTION_MATRIX * vec4(normale_vue, 0.0)).xy;

	if (length(direction) > 0.0001) {
		clip.xy += normalize(direction) * epaisseur * 2.0 / VIEWPORT_SIZE * clip.w;
	}
	POSITION = clip;
}

void fragment() {
	ALBEDO = couleur.rgb;
}