shader_type canvas_item;

uniform float glitch_amount : hint_range(0.0, 1.0) = 0.0;
uniform float speed = 12.0;

float rand(vec2 co) {
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
    vec4 col = texture(TEXTURE, UV);

    float row = floor(UV.y * 16.0);          // per-pixel-row banding
    float t   = floor(TIME * speed);
    float n   = rand(vec2(row, t));

    if (n > 1.0 - glitch_amount) {
        float pick = rand(vec2(t, row + 1.0));
        if (pick < 0.33) {
            col.rgb = col.gbr;               // channel rotate
        } else if (pick < 0.66) {
            col.rgb = 1.0 - col.rgb;         // invert
        } else {
            col.rgb = mix(col.rgb, vec3(0.0, 1.0, 0.1), 0.7);
        }
    }
    COLOR = col;
}