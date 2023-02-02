#pragma header

float NoiseSeed;
float randomFloat(){
  NoiseSeed = sin(NoiseSeed) * 84522.13219145687;
  return fract(NoiseSeed);
}

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
vec3 chromaticAbberation(sampler2D tex, vec2 uv, float amount)
{
    float aberrationAmount = amount/10.0;
   	vec2 distFromCenter = uv - 0.5;

    // stronger aberration near the edges by raising to power 3
    vec2 aberrated = aberrationAmount * pow(distFromCenter, vec2(3.0, 3.0));
    
    vec3 color = vec3(0.0);
    
    for (int i = 1; i <= 8; i++)
    {
        float weight = 1.0 / pow(2.0, float(i));
        color.r += textureCam(tex, uv - float(i) * aberrated).r * weight;
        color.b += textureCam(tex, uv + float(i) * aberrated).b * weight;
    }
    
    color.g = textureCam(tex, uv).g * 0.9961; // 0.9961 = weight(1)+weight(2)+...+weight(8);
    
    return color.rgb;
}




//film grain from: https://www.shadertoy.com/view/wl2SDt
vec3 filmGrain()
{
    return vec3(0.9 + randomFloat()*0.15);
}




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
    
    //vertical
    for (float i=c/2.0; i>-1.0; i--)
    {
        float texU = textureCam(tex, uv+vec2(0.0, i/d)).r;
        float texD = textureCam(tex, uv-vec2(0.0, i/d)).r;
        hdr += floor(threshold+pow(max(texU,texD), 40.0))*(1.0-i/c) * 0.25;
    }
    
    hdr *= vec3(0.5,0.4,1.0); //tint
    
	return hdr*brightness;
}

//margins from: https://www.shadertoy.com/view/wl2SDt
vec3 margins(vec3 color, vec2 uv, float marginSize)
{
    if(uv.y < marginSize || uv.y > 1.0-marginSize)
    {
        return vec3(0.0);
    }else{
        return color;
    }
}




void main() {
    
    vec2 uv = getCamPos(openfl_TextureCoordv);
    
    vec4 color = textureCam(bitmap, uv);
    
    
    //chromatic abberation
    color.rgb = chromaticAbberation(bitmap, uv, 0.3);
    
    
    //film grain
    //color *= filmGrain();
    
    
    //ACES Tonemapping
  	color = ACESFilm(color);
    
    
    //contrast
    color.rgb = contrast(color) * 0.9;
    
    
    //flare
    //color += flares(bitmap, uv, 0.9, 200.0, 0.5, 0.06);
    
    
    //margins
    //color = margins(color, uv, 0.1);
    
    
    //output
    gl_FragColor = color;
}