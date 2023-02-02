#pragma header
uniform float size;
void main()
{
    vec2 uv = getCamPos(openfl_TextureCoordv);
    vec2 d = abs((uv - 0.5) * size);
    d = pow(d, vec2(2.0, 2.0));
    
    vec4 col = textureCam(bitmap, uv);
    col.rgb -= d.x + d.y;
    
    gl_FragColor = col;
}