#pragma header
uniform float chromatic;
uniform float hDRthingy;
vec3 sampleSplit(sampler2D tex, vec2 coord)
{
	vec3 frag;
	frag.r = textureCam(tex, vec2(coord.x - (chromatic / 100), coord.y)).r;
	frag.g = textureCam(tex, vec2(coord.x       , coord.y)).g;
	frag.b = textureCam(tex, vec2(coord.x + (chromatic / 100), coord.y)).b;
	return frag;
}

void main()
{
	vec3 tempRGB = sampleSplit(bitmap, getCamPos(openfl_TextureCoordv));
	gl_FragColor = textureCam(bitmap, getCamPos(openfl_TextureCoordv)) * hDRthingy;
	gl_FragColor.rgb -= tempRGB.rgb;
}