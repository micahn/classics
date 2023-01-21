shader_type canvas_item;

uniform sampler2D noise : hint_default_black;
uniform float threshold;
void fragment() {
	float h = texture(noise,UV).r;
	h = smoothstep(threshold,1.0,h);
	COLOR = vec4(h,h,h,1.0);
	// Place fragment code here.
}
