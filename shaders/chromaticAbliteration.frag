#pragma header

uniform float offset = 0;
uniform float uTime = 0;
void main() {
    float sinus = sin(uTime * 30);
    vec2 offsetGen = vec2(sin(uTime * 80) * offset * 0.125, 0);

    vec4 colorR = flixel_texture2D(bitmap, openfl_TextureCoordv + vec2(offset + (sinus * offset * 0.125), 0) + offsetGen);
    vec4 colorG = flixel_texture2D(bitmap, openfl_TextureCoordv + vec2(0, 0) + offsetGen);
    vec4 colorB = flixel_texture2D(bitmap, openfl_TextureCoordv + vec2(-offset + (sinus * offset * 0.125), 0) + offsetGen);

    gl_FragColor = vec4(colorR.r, colorG.g, colorB.b, (colorG.a + colorB.a + colorR.a) / 3);
}