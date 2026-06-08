shader_type canvas_item;

uniform float scroll_speed : hint_range(-2.0, 2.0) = 0.2;

void fragment() {
    vec2 uv = UV;
    uv.x += TIME * scroll_speed;
    COLOR = texture(TEXTURE, uv);
}