#pragma header
uniform float iTime;
void main()
{
	// Get the UV Coordinate of your texture or Screen Texture, yo!
	vec2 uv = openfl_TextureCoordv;
	
    uv.y += sin(uv.x*5.0+iTime)/10.0;
	
	// Modify that X coordinate by the sin of y to oscillate back and forth up in this.
	uv.x += sin(uv.y*10.0+iTime)/5.0;
	
	// Get the pixel color at the index.
	vec4 color = flixel_texture2D(bitmap, uv);
	
	gl_FragColor = color;
}