#pragma header

uniform bool enable;
float quadInOut(float t) {
    return t <= .5 ? t * t * 2 : 1 - (--t) * t * 2;
}

void main() {
    vec2 uv = openfl_TextureCoordv;
    if (enable) uv = vec2(quadInOut(openfl_TextureCoordv.x), quadInOut(openfl_TextureCoordv.y));
    gl_FragColor = flixel_texture2D(bitmap, uv);
}