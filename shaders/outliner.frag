#pragma header
uniform float edgeIntense;

float d;

float lookup(vec2 p, float dx, float dy, float edgeIntensity)
{
    vec2 uv = (p.xy + vec2(dx * edgeIntensity, dy * edgeIntensity)) / openfl_TextureSize;
    vec4 c = textureCam(bitmap, uv.xy);
	
	// return as luma
    return 0.2126*c.r + 0.7152*c.g + 0.0722*c.b;
}

void main()
{
	vec2 fragCoord = getCamPos(openfl_TextureCoordv)*openfl_TextureSize;
    float timeNorm = 5;
    vec3 glowCol = vec3(2.,2.,2.);
    float edgeIntensity = edgeIntense;
    vec2 p = fragCoord.xy;
    
	// simple sobel edge detection
    float gx = 0.0;
    gx += -1.0 * lookup(p, -1.0, -1.0, edgeIntensity);
    gx += -2.0 * lookup(p, -1.0,  0.0, edgeIntensity);
    gx += -1.0 * lookup(p, -1.0,  1.0, edgeIntensity);
    gx +=  1.0 * lookup(p,  1.0, -1.0, edgeIntensity);
    gx +=  2.0 * lookup(p,  1.0,  0.0, edgeIntensity);
    gx +=  1.0 * lookup(p,  1.0,  1.0, edgeIntensity);
    
    float gy = 0.0;
    gy += -1.0 * lookup(p, -1.0, -1.0, edgeIntensity);
    gy += -2.0 * lookup(p,  0.0, -1.0, edgeIntensity);
    gy += -1.0 * lookup(p,  1.0, -1.0, edgeIntensity);
    gy +=  1.0 * lookup(p, -1.0,  1.0, edgeIntensity);
    gy +=  2.0 * lookup(p,  0.0,  1.0, edgeIntensity);
    gy +=  1.0 * lookup(p,  1.0,  1.0, edgeIntensity);
    
	// hack: use g^2 to conceal noise in the video
    float g = gx*gx + gy*gy;
    
    vec4 col = textureCam(bitmap, fragCoord / openfl_TextureSize);
    col += vec4(g * glowCol, 0.0);
    
    gl_FragColor = col;
}