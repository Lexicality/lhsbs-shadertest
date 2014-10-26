#version 130

#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform int timer;

uniform vec4 viewport;
uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;

out vec4 pixel;

// http://stackoverflow.com/a/4275343/823542
float rand(vec2 co){
	return fract(sin(dot(co.xy, vec2(12.9898,78.233))) * 43758.5453);
}

float desin(float val, float sinnable) {
	sinnable *= 3.141569;
	sinnable *= mod( float(timer), 10);
	return val + sin(sinnable) * 0.1;// ( ( 1 + sin(sinnable) ) / 2 );
}

void main() {
	vec2 coords;

	coords = vertTexCoord.st;

	// Sine wave distortion
	// coords = vec2( desin( coords.s, coords.t), coords.t );

	vec4 adjust = vertColor;

	const float scandist = 10;
	const float scanAmt = 2;
	float scanloc = mod(float(timer / 40), scandist);
	float cline = mod( (vertTexCoord.t / texOffset.t), scandist );

	if ( cline > scanloc - scanAmt && cline < scanloc + scanAmt ) {
		adjust *= 0.8;
		coords.s += coords.t / 4;
		// adjust = vec4(0,0,0,0);
	}

	// Write it to the screen
	pixel = texture2D(texture, coords) * adjust;
}
