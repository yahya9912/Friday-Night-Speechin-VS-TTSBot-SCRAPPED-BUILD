#pragma header

uniform float range = 0.05;
uniform float noiseQuality = 250.0;
uniform float noiseIntensity = 0.0088;
uniform float offsetIntensity = 0.02;
uniform float colorOffsetIntensity = 1.3;
uniform float iTime;

float rand(vec2 co)
{
    return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float verticalBar(float pos, float uvY, float offset)
{
    float edge0 = (pos - range);
    float edge1 = (pos + range);

    float x = smoothstep(edge0, pos, uvY) * offset;
    x -= smoothstep(pos, edge1, uvY) * offset;
    return x;
}

void main()
{
	vec2 uv = getCamPos(openfl_TextureCoordv).xy;
    
    for (float i = 0.0; i < 0.71; i += 0.1313)
    {
        float d = mod(0.5 * i, 1.7);
        float o = sin(1.0 - tan(iTime * 0.24 * i));
    	o *= offsetIntensity;
        uv.x += verticalBar(d, uv.y, o);
    }
    
    float uvY = uv.y;
    uvY *= noiseQuality;
    uvY = float(int(uvY)) * (1.0 / noiseQuality);
    float noise = rand(vec2(iTime * 0.00001, uvY));
    uv.x += noise * noiseIntensity;

    vec2 offsetR = vec2(0.006 * sin(iTime), 0.0) * colorOffsetIntensity;
    vec2 offsetG = vec2(0.0073 * (cos(iTime * 0.97)), 0.0) * colorOffsetIntensity;
    vec4 tex = textureCam(bitmap, uv);
    tex.r = textureCam(bitmap, uv + offsetR).r;
    tex.g = textureCam(bitmap, uv + offsetG).g;
    tex.b = textureCam(bitmap, uv).b;

    gl_FragColor = tex;
}