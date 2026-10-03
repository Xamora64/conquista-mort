shader_type canvas_item;

uniform float fold_x: hint_range(0.0, 1.0, 0.01) = 0.0;
uniform float fold_y: hint_range(0.0, 1.0, 0.01) = 0.0;
uniform float normal_x: hint_range(-1.0, 1.0, 0.01) = 0.0;
uniform float normal_y: hint_range(-1.0, 1.0, 0.01) = 1.0;

uniform float next_shadow_size: hint_range(0.0, 10.0, 0.01) = 0.5;
uniform float next_shadow_power: hint_range(0.0, 1.0, 0.01) = 0.5;
uniform float back_shadow_size: hint_range(0.0, 10.0, 0.01) = 2.0;
uniform float back_shadow_power: hint_range(0.0, 1.0, 0.01) = 0.7;
uniform float cast_shadow_size: hint_range(0.0, 10.0, 0.01) = 1.0;
uniform float cast_shadow_power: hint_range(0.0, 1.0, 0.01) = 0.35;
uniform float contrast: hint_range(0.0, 1.0, 0.01) = 0.2;
uniform float brightness: hint_range(0.0, 1.0, 0.01) = 0.2;

// Dégradé d'ombre : 0 au pli, 1 à "size * 0.1" de distance
float soft(float size, float dist) {
	return smoothstep(0.0, max(size * 0.1, 0.0001), dist);
}

vec3 get_back_page_pixel(vec3 back_color, float page_dist) {
	back_color = back_color * contrast + brightness;
	return mix(back_color * (1.0 - back_shadow_power), back_color, soft(back_shadow_size, page_dist));
}

// Composition "over" avec alpha
vec4 over(vec4 top, vec4 bottom) {
	float a = top.a + bottom.a * (1.0 - top.a);
	vec3 rgb = (top.rgb * top.a + bottom.rgb * bottom.a * (1.0 - top.a)) / max(a, 0.0001);
	return vec4(rgb, a);
}

// Distance signée à un rectangle centré sur l'origine (négative à l'intérieur)
float box_sdf(vec2 p, vec2 half_size) {
	vec2 q = abs(p) - half_size;
	return length(max(q, 0.0)) + min(max(q.x, q.y), 0.0);
}

void fragment() {
	vec2 aspect = vec2(TEXTURE_PIXEL_SIZE.y / TEXTURE_PIXEL_SIZE.x, 1.0);
	float px = TEXTURE_PIXEL_SIZE.y; // taille d'un pixel dans l'espace "aspect"
	vec2 pos = UV * aspect;

	vec2 n = vec2(normal_x, normal_y) * aspect;
	if (length(n) > 0.0001) {
		n = normalize(n);
	} else {
		n = vec2(0.0, 1.0);
	}

	vec2 fold = vec2(1.0 - fold_x, 1.0 - fold_y) * aspect;
	float page_side = dot(pos - fold, n);
	float removed = smoothstep(-px, px, page_side); // 1 = côté retiré

	vec4 front = texture(TEXTURE, UV);

	// Rabat : point miroir du pixel par rapport au pli
	vec2 flip_pos = pos - 2.0 * page_side * n;
	float sd = box_sdf(flip_pos - aspect * 0.5, aspect * 0.5);
	float flap_cover = (1.0 - smoothstep(-px, px, sd)) * (1.0 - removed);
	vec4 back = texture(TEXTURE, clamp(flip_pos / aspect, 0.0, 1.0));
	vec4 flap = vec4(get_back_page_pixel(back.rgb, max(-page_side, 0.0)), back.a * flap_cover);

	// Longueur du rabat (pour atténuer l'ombre quand il est minuscule)
	float flap_len = max(
		max(dot(-fold, n), dot(vec2(aspect.x, 0.0) - fold, n)),
		max(dot(vec2(0.0, 1.0) - fold, n), dot(aspect - fold, n)));

	// Ombre du rabat sur la page en dessous
	float cast = (1.0 - soft(cast_shadow_size, max(sd, 0.0)))
		* soft(cast_shadow_size, max(flap_len, 0.0))
		* cast_shadow_power;

	vec4 page = vec4(front.rgb * (1.0 - cast), front.a * (1.0 - removed));
	vec4 result = over(flap, page);

	// Ombre sur ce qu'il y a derrière (côté retiré)
	float bg = (1.0 - soft(next_shadow_size, max(page_side, 0.0)))
		* next_shadow_power * front.a * removed;
	result = over(result, vec4(0.0, 0.0, 0.0, bg));

	COLOR = result;
}