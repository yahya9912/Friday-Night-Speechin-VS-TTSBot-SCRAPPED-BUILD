#pragma header
uniform float opacity = 0.44;
void main()
{
	vec2 fragCoord = getCamPos(openfl_TextureCoordv) * openfl_TextureSize;
	gl_FragColor = textureCam(bitmap, getCamPos(openfl_TextureCoordv));
	vec3 screen = gl_FragColor.rgb;
	screen.rgb -= sin((fragCoord.y)) * opacity;
	gl_FragColor.rgb = screen;
}