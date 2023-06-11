int REFIL_FACTOR=4;
int SIDES = 4;
int STROKE_WIDTH=3;
int STROKE_COLOR=56;
int SATURATION=100;
int BRIGHTNESS=100;
int FUNCTION_SELECTED=0;
int CLICKED_MOUSE_X=0;
int CLICKED_MOUSE_Y=0;
int SKETCH_WIDTH = 800;
int SKETCH_HEIGHT = 680;
BresenUI UI = new BresenUI();
BresenForm SELECTION_RECT = null;
ArrayList<BresenForm> forms= new ArrayList<BresenForm>();

void setup() {
  size(800, 680);
  frameRate(60);
  background(0);
  colorMode(HSB,360,SATURATION,BRIGHTNESS);
}

void draw() {
  
  background(0);
  stroke(0);
  
  if (SELECTION_RECT != null) SELECTION_RECT.drawThis();

  if (!forms.isEmpty()){

    for (BresenForm form : forms){
      form.drawThis();
    }

  }

}

void mousePressed(){

  CLICKED_MOUSE_X=mouseX;
  CLICKED_MOUSE_Y=mouseY;

}

void mouseDragged(){

  
  if (FUNCTION_SELECTED == 0) { 
    SELECTION_RECT = UI.createEllipse(CLICKED_MOUSE_X,CLICKED_MOUSE_Y,mouseX,mouseY);
  } else {
    SELECTION_RECT = UI.createPoly(CLICKED_MOUSE_X,CLICKED_MOUSE_Y,mouseX,mouseY);
    SELECTION_RECT.sides=SIDES;
  }
  SELECTION_RECT.strokeColor=10;
  SELECTION_RECT.strokeWidth=1;

}

 void mouseReleased() {
  
  SELECTION_RECT = null;

  switch (FUNCTION_SELECTED) {

    case 0 : 
      BresenElipse newElipse = UI.createEllipse(CLICKED_MOUSE_X,CLICKED_MOUSE_Y,mouseX,mouseY);
      forms.add(newElipse);
      
    break;	

    
    case 1 : 
      BresenPoly newPoly = UI.createPoly(CLICKED_MOUSE_X,CLICKED_MOUSE_Y,mouseX,mouseY);
      forms.add(newPoly);
    break;	

    default :
      
    break;	
    
  }

}