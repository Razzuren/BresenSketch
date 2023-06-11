void mousePressed(){
    CLICKED_MOUSE_X=mouseX;
    CLICKED_MOUSE_Y=mouseY;
  
    if((FUNCTION_SELECTED==2 || FUNCTION_SELECTED==3) && !forms.isEmpty()){
      for (BresenForm f : forms){
          if (f.over()) {
          SELECTED_FORM=f;
          break;
          }
      }
    }

    if((FUNCTION_SELECTED==4) && !forms.isEmpty()){
        boolean found = false;
        for (BresenForm f : forms){
            if (f.over()) {
            SELECTED_FORM=f;
            found=true;
            break;
            }
        }
        if (!found) STROKE_COLOR = ((mouseX >= 5) && (mouseX <= 365)) ? mouseX-5 : STROKE_COLOR;
    }

}

void mouseDragged(){

  switch (FUNCTION_SELECTED) {
    
    //Elipse
    case 0 : 
      SELECTION_RECT = createEllipse(CLICKED_MOUSE_X,CLICKED_MOUSE_Y,mouseX,mouseY);
      SELECTION_RECT.strokeColor=10;
      SELECTION_RECT.strokeWidth=1;
    break;	

    //Polygon
    case 1 : 
      SELECTION_RECT = createPoly(CLICKED_MOUSE_X,CLICKED_MOUSE_Y,mouseX,mouseY);
      SELECTION_RECT.sides=SIDES;
      SELECTION_RECT.strokeColor=10;
      SELECTION_RECT.strokeWidth=1;
    break;	

    //Move
    case 2 : 
      if (SELECTED_FORM != null){
        SELECTION_RECT = new BresenPoly (SELECTED_FORM.centerX, SELECTED_FORM.centerY, 
                          SELECTED_FORM.semiXAxis, SELECTED_FORM.semiYAxis, 4, 10, 1);

        SELECTED_FORM.centerX=mouseX;
        SELECTED_FORM.centerY=mouseY;
      }
    break;

    //Scale
    case 3 : 
      if (SELECTED_FORM != null){
        SELECTION_RECT = new BresenPoly (SELECTED_FORM.centerX, SELECTED_FORM.centerY, 
                          SELECTED_FORM.semiXAxis, SELECTED_FORM.semiYAxis, 4, 10, 1);

        int newSemiX = (Math.abs(SELECTED_FORM.centerX-mouseX)
         < SKETCH_WIDTH/4) ? Math.abs(SELECTED_FORM.centerX-mouseX) : SKETCH_WIDTH/4;

        int newSemiY = ( Math.abs(SELECTED_FORM.centerY-mouseY)
         < SKETCH_HEIGHT/4) ? Math.abs(SELECTED_FORM.centerY-mouseY) : SKETCH_HEIGHT/4;

        SELECTED_FORM.semiXAxis=newSemiX;
        SELECTED_FORM.semiYAxis=newSemiY;
      }
    break;	

    default :
      
    break;	
  }

}

 void mouseReleased() {
  
  SELECTION_RECT = null;

  switch (FUNCTION_SELECTED) {

    //Elipse
    case 0 : 
      BresenElipse newElipse = createEllipse(CLICKED_MOUSE_X,CLICKED_MOUSE_Y,mouseX,mouseY);
      forms.add(newElipse);
      
    break;	

    //Polygon
    case 1 : 
      BresenPoly newPoly = createPoly(CLICKED_MOUSE_X,CLICKED_MOUSE_Y,mouseX,mouseY);
      forms.add(newPoly);
    break;	
    
    //Move
    case 2 : 
      SELECTED_FORM=null;
    break;	

    //Scale
    case 3 : 
      SELECTED_FORM=null;
    break;

    //Color
    case 4 : 
      if (SELECTED_FORM != null){
        SELECTED_FORM.strokeColor = STROKE_COLOR;
        SELECTED_FORM=null;
      }
    break;

    default :
      
    break;	
    
  }
 }

void keyPressed() {
  if (keyCode == '1') FUNCTION_SELECTED = 0;
  if (keyCode == '2') FUNCTION_SELECTED = 1;
  if (keyCode == '3') FUNCTION_SELECTED = 2;
  if (keyCode == '4') FUNCTION_SELECTED = 3;
  if (keyCode == '5') FUNCTION_SELECTED = 4;
  if (keyCode == '9') SIDES++;
  if (keyCode == '0') SIDES= (SIDES-1 >=3) ? SIDES-1 : 3;
}

public BresenElipse createEllipse (int x0,int y0,int x1,int y1){

  int deltaX = (Math.abs(x1 - x0) < SKETCH_WIDTH/4) ? Math.abs(x1 - x0) : SKETCH_WIDTH/4;
  int deltaY = (Math.abs(y1 - y0) < SKETCH_HEIGHT/4) ? Math.abs(y1 - y0) : SKETCH_HEIGHT/4;

  return new BresenElipse(x0,y0,deltaX,deltaY,STROKE_WIDTH,STROKE_COLOR);

}

public BresenPoly createPoly (int x0,int y0,int x1,int y1){

  int deltaX = (Math.abs(x1 - x0) < SKETCH_WIDTH/4) ? Math.abs(x1 - x0) : SKETCH_WIDTH/4;
  int deltaY = (Math.abs(y1 - y0) < SKETCH_HEIGHT/4) ? Math.abs(y1 - y0) : SKETCH_HEIGHT/4;

  return new BresenPoly(x0,y0,deltaX,deltaY,SIDES,STROKE_WIDTH,STROKE_COLOR);

}