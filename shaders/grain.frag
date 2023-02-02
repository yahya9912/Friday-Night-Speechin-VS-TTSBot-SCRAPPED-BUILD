#pragma header
uniform float strength = 16.0;
uniform float iTime;
void main()
{
	vec2 uv = getCamPos(openfl_TextureCoordv);
    
    vec4 color = textureCam(bitmap, uv);
    
    float x = (uv.x + 4.0 ) * (uv.y + 4.0 ) * (iTime * 10.0);
	vec4 grain = vec4(mod((mod(x, 13.0) + 1.0) * (mod(x, 123.0) + 1.0), 0.01)-0.005) * strength;
    
	gl_FragColor = color + grain;
}