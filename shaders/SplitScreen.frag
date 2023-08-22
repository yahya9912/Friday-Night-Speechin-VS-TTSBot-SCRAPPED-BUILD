#pragma header

mat2 rot(float a) {
    return mat2(cos(a), -sin(a), sin(a), cos(a));
}

const vec2 halfVec = vec2(0.5);

uniform vec2 renderOffset = vec2(0.0);
uniform vec2 renderScale = vec2(1.0);
uniform float renderRot = 0.0;

vec2 renderSmhoove(vec2 uv) {
	if (renderScale.x == 1.0 && renderScale.y == 1.0 && renderRot == 0.0) return fract(uv + renderOffset);

	if (renderRot != 0.0) {
                float aspectRatio = openfl_TextureSize.x / openfl_TextureSize.y;
                uv -= 0.5;
		uv = uv * rot(renderRot);
                uv += 0.5;
        }

	//zoom part taken from codename
	uv = halfVec + ((uv - halfVec) * renderScale);
	return fract(uv + renderOffset);
}

void main() {
        vec2 uv = openfl_TextureCoordv;
	uv = renderSmhoove(uv);

        gl_FragColor = flixel_texture2D(bitmap, uv);
}