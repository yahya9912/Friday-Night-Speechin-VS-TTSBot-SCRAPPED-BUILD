#pragma header
uniform float iTime;
uniform vec2 offset;
uniform vec2 scaling;
void main() {
    vec2 uv = openfl_TextureCoordv;
    uv.x = fract((uv.x - offset.x * 0.1 * iTime) * scaling.x);
    uv.y = fract((uv.y + offset.y * 0.1 * iTime) * scaling.y);
    gl_FragColor = flixel_texture2D(bitmap, uv);
}