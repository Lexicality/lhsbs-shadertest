#version 130

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform int timer;
uniform bool boom;
uniform int damage;

uniform vec4 viewport;
uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

out vec4 pixel;

const float pi = 3.141569;

// http://stackoverflow.com/a/4275343/823542
float rand(vec2 co){
	return fract(sin(dot(co.xy, vec2(12.9898,78.233))) * 43758.5453);
}

float desin(float val, float sinnable) {
	sinnable *= pi;
	sinnable *= mod( float(timer), 10);
	return val + sin(sinnable) * 0.1;
}

void main() {
	vec2 coords;

	coords = vertTexCoord.st;

	vec4 adjust = vertColor;

	const float scandist = 10;
	const float scanAmt = 4;
	float scanloc = mod(float(timer / 40), scandist);
	float cline = mod( (vertTexCoord.t / texOffset.t), scandist );

	// Constant damage screen distortion
	if (damage > 0) {
		float damageAmt = (float(damage) / 100);
		// Skew it sideways
		float val = coords.t;
		if (val > .5)
			val = 1 - val;
		val += (1 - (rand(vec2(coords.t, timer / 1000)) * 2)) / 10;
		val *= damageAmt;
		coords.s -= val;
	}

	// Active damage moving scanlines
	if ( boom && cline > scanloc - scanAmt && cline < scanloc + scanAmt ) {
		// Endarken the section
		adjust *= 0.8;
		// Skew it sideways
		coords.s -= (2 - coords.t * 4) / 4;
		// Sine wave distortion
		coords.s = desin( coords.s, coords.t);
	}

	// Wrap the coordinates
	if (coords.s < 0)
		coords.s += 1;
	if (coords.s > 1)
		coords.s -= 1;

	// Write it to the screen
	pixel = texture2D(texture, coords) * adjust;
}
