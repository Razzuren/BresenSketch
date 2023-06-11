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

    if (FUNCTION_SELECTED == 4){
      for(int i = 0; i<=360 ; i++){
        stroke(i,SATURATION,BRIGHTNESS);
        line(padding+i, height-20-padding, padding+i, height-padding);
      }
      fill(STROKE_COLOR,SATURATION,BRIGHTNESS);
      square(width-padding-20, height-padding-20, 20);
    }

  }

}
