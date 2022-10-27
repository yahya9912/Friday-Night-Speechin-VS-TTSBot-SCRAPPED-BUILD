#pragma header
void main()
{
	vec2 uv = getCamPos(openfl_TextureCoordv);
	uv.x =  fract(-getCamPos(openfl_TextureCoordv).x);
	gl_FragColor = textureCam(bitmap, uv);
}