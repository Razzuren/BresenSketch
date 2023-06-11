void setup() {
  size(800, 680);
  frameRate(60);
  background(0);
  colorMode(HSB,360,SATURATION,BRIGHTNESS);
  UI = new BresenUI();
}

void draw() {
  
  background(0);
  stroke(0);
  fill(255);
  
  if (SELECTION_RECT != null) SELECTION_RECT.drawThis();

  if (!forms.isEmpty()){

    for (BresenForm form : forms){
      form.drawThis();
    }

  }

  UI.drawUI();

}