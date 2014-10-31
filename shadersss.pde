//import javax.media.opengl.GL;
//import javax.media.opengl.GL2;

PImage img;
PShader shader;

//PJOGL pgl;
//GL2 gl2;


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
//  pgl = (PJOGL)((PGraphicsOpenGL)g).pgl;
//  gl2 = pgl.gl.getGL2();
}

boolean isDamage;

void keyPressed() {
  if (key == ' ')
    loadShader();
  if (key == 'd') {
    isDamage = ! isDamage;
    shader.set("boom", isDamage);
  }
}


int lastDistort = 0;

void draw() {
  image(img, -30, -50);
  rect(20, 20, 20, 20);
  // filter(BLUR, 5);
  int tx = 0, ty = 0, i, j;
  int now = millis();
  shader.set("timer", now);
  
  filter(shader);
  rect(40, 40, 20, 20);
  text(binary(tx), 40, 70);
  text(binary(ty), 40, 80);
}

