#pragma header

float SCurve (float value, float amount, float correction) {

	float curve = 1.0; 

    if (value < 0.5)
    {

        curve = pow(value, amount) * pow(2.0, amount) * 0.5; 
    }
        
    else
    { 	
    	curve = 1.0 - pow(1.0 - value, amount) * pow(2.0, amount) * 0.5; 
    }

    return pow(curve, correction);
}

//ACES tonemapping from: https://www.shadertoy.com/view/wl2SDt
vec4 ACESFilm(vec4 x)
{
    float a = 2.51;
    float b = 0.03;
    float c = 2.43;
    float d = 0.59;
    float e = 0.14;
    return (x*(a*x+b))/(x*(c*x+d)+e);
}

//Chromatic Abberation from: https://www.shadertoy.com/view/XlKczz

//Sigmoid Contrast from: https://www.shadertoy.com/view/MlXGRf
vec3 contrast(vec4 color)
{
    return vec3(SCurve(color.r, 3.0, 1.0), 
                SCurve(color.g, 4.0, 0.7), 
                SCurve(color.b, 2.6, 0.6)
               );
}

//anamorphic-ish flares from: https://www.shadertoy.com/view/MlsfRl
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
    //ACES Tonemapping
  	color = ACESFilm(color);
    
    
    //contrast
    color.rgb = contrast(color) * 0.9;
    
    
    //flare float threshold, float intensity, float stretch, float brightness
    color.rgb += flares(bitmap, uv, 0.7, 250.0, 0.03, 0.1);

    //output
    gl_FragColor = color;
}