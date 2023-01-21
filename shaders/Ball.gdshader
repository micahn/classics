shader_type canvas_item;
uniform vec4 in_color : source_color;
void fragment() {
	vec2 uv = UV*2.0-vec2(1.0);
	float mask = smoothstep(0.0,0.1,1.0-length(uv));
	vec3 c = vec3(smoothstep(0.1,0.11,1.0-length(uv)));
	c = c * in_color.rgb;
	COLOR = vec4(c,mask);
}
