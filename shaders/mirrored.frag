#pragma header
uniform float threshold;
uniform float intensity;
uniform float stretch;
uniform float brightness;
vec3 flares(sampler2D tex, vec2 uv, float threshold, float intensity, float stretch, float brightness)
{
    threshold = 1.0 - threshold;
    
    vec3 hdr = textureCam(tex, uv).rgb;
    hdr = vec3(floor(threshold+pow(hdr.r, 1.0)));
    
    float d = intensity; //200.;
    float c = intensity*stretch; //100.;
    
    
    //horizontal
    for (float i=c; i>-1.0; i--)
    {
        float texL = textureCam(tex, uv+vec2(i/d, 0.0)).r;
        float texR = textureCam(tex, uv-vec2(i/d, 0.0)).r;
        hdr += floor(threshold+pow(max(texL,texR), 4.0))*(1.0-i/c);
    }
    
    hdr *= vec3(0.9,0.4,1.0); //tint
    
	return hdr*brightness;
}
void main() {
    vec2 uv = getCamPos(openfl_TextureCoordv);
    vec4 color = textureCam(bitmap, uv);

    color.rgb += flares(bitmap, uv, 0.8, 200.0, 0.07, 0.05);
    gl_FragColor = color;
}