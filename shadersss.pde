
PImage img;
PShader shader;

final int tilesX = 5, tilesY = 5;

void loadShader() {
  shader = loadShader("test.glsl");
}

void setup () {
  img = loadImage("bg.png");
  size(img.width - 60, img.height - 80, OPENGL);
  loadShader(); 
  if (shader == null) {
    exit();
  }
}

void keyPressed() {
  if (key == ' ')
    loadShader();
}


int lastDistort = 0;

void draw() {
  image(img, -30, -50);
  rect(20, 20, 20, 20);
  // filter(BLUR, 5);
  int tx = 0, ty = 0, i, j;
  int now = millis();
  shader.set("timer", now);
  int distortio = round(now / 100);
  if ( distortio > lastDistort) {
    lastDistort = distortio;
    for (i = 0; i < tilesX; i++) {
      for (j = 0; j < tilesY; j++) {
        if (random(100) < 25) {
          tx |= 1 << i;
          ty |= 1 << j;
        }
      }
    }
    shader.set("tiles", tx, ty);
  }

  filter(shader);
  rect(40, 40, 20, 20);
  text(binary(tx), 40, 70);
  text(binary(ty), 40, 80);
}

