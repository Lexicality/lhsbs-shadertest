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

final int keyUp = 38;
final int keyDown = 40;

boolean isDamage;
int damageAmt = 0;

void keyPressed() {
  if (key == ' ') {
    loadShader();
    shader.set("boom", isDamage);
    shader.set("damage", damageAmt);
  } else if (key == 'd') {
    isDamage = ! isDamage;
    shader.set("boom", isDamage);
  } else if (keyCode == keyUp && damageAmt < 100) {
    damageAmt++;
    shader.set("damage", damageAmt);
  } else if (keyCode == keyDown && damageAmt > 0) {
    damageAmt--;
    shader.set("damage", damageAmt);
  }
}


int lastDistort = 0;

void draw() {
  image(img, -30, -50);

  shader.set("timer", millis());
  filter(shader);

  text(str(damageAmt), 50, 50);
}

