#pragma header
void main()
{
	vec2 uv = getCamPos(openfl_TextureCoordv);
	
    vec2 d = abs((uv - 0.5) * 2.0);
    d = pow(d, vec2(2.0, 2.0));
    vec3 frag;
	frag.r = textureCam(bitmap, uv - d * 0.015).r;
    frag.g = textureCam(bitmap, uv).g;
    frag.b = textureCam(bitmap, uv + d * 0.015).b;
    gl_FragColor = textureCam(bitmap, uv) / 3;
    gl_FragColor.rgb = frag.rgb;
}