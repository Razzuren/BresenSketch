public class BresenUI {
  PImage elipseBtn;
  PImage polygonBtn;
  PImage moveBtn;
  PImage resizeBtn;
  PImage colorBtn;
  int padding = 5;
  int btnWidth =50;

  public BresenUI(){
  elipseBtn = loadImage("1.png");
  polygonBtn = loadImage("2.png");
  moveBtn = loadImage("3.png");
  resizeBtn = loadImage("4.png");
  colorBtn = loadImage("5.png");

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

  public void drawUI(){
    tint(255, (FUNCTION_SELECTED == 0) ? 255 : 125); 
    image(elipseBtn, padding, padding);

    tint(255, (FUNCTION_SELECTED == 1) ? 255 : 125); 
    image(polygonBtn,2*padding+btnWidth,padding);

    tint(255, (FUNCTION_SELECTED == 2) ? 255 : 125); 
    image(moveBtn,3*padding+btnWidth*2, padding);

    tint(255, (FUNCTION_SELECTED == 3) ? 255 : 125); 
    image(resizeBtn, 4*padding+btnWidth*3, padding);

    tint(255, (FUNCTION_SELECTED == 4) ? 255 : 125); 
    image(colorBtn, 5*padding+btnWidth*4, padding);

    textSize(btnWidth/2);
    String str = "Número de Lados = " + SIDES;
    text(str, 9*padding+btnWidth*5, padding+btnWidth);

}

}
