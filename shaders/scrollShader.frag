#pragma header

uniform float killMe;
void main(){
        vec2 p_m = openfl_TextureCoordv;
        vec2 p_d = p_m;
        p_d.t -= killMe * 0.05;
        p_d.t = mod(p_d.t, 1.0);
        vec2 dist_tex_coord = p_d.st;
        gl_FragColor = flixel_texture2D(bitmap, dist_tex_coord); 
}