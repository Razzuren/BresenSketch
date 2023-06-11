/* autogenerated by Processing revision 1292 on 2023-06-11 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class BresenSketch extends PApplet {

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
BresenUI UI;
BresenForm SELECTION_RECT = null;
BresenForm SELECTED_FORM = null;
ArrayList<BresenForm> forms= new ArrayList<BresenForm>();

public void setup() {
  /* size commented out by preprocessor */;
  frameRate(60);
  background(0);
  colorMode(HSB,360,SATURATION,BRIGHTNESS);
  UI = new BresenUI();
}

public void draw() {
  
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

public void mousePressed(){

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

public void mouseDragged(){

  switch (FUNCTION_SELECTED) {

    case 0 : 
      SELECTION_RECT = createEllipse(CLICKED_MOUSE_X,CLICKED_MOUSE_Y,mouseX,mouseY);
      SELECTION_RECT.strokeColor=10;
      SELECTION_RECT.strokeWidth=1;
    break;	

    case 1 : 
      SELECTION_RECT = createPoly(CLICKED_MOUSE_X,CLICKED_MOUSE_Y,mouseX,mouseY);
      SELECTION_RECT.sides=SIDES;
      SELECTION_RECT.strokeColor=10;
      SELECTION_RECT.strokeWidth=1;
    break;	

    case 2 : 
      if (SELECTED_FORM != null){
        SELECTION_RECT = new BresenPoly (SELECTED_FORM.centerX, SELECTED_FORM.centerY, 
                          SELECTED_FORM.semiXAxis, SELECTED_FORM.semiYAxis, 4, 10, 1);

        SELECTED_FORM.centerX=mouseX;
        SELECTED_FORM.centerY=mouseY;
      }
    break;

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

 public void mouseReleased() {
  
  SELECTION_RECT = null;

  switch (FUNCTION_SELECTED) {

    case 0 : 
      BresenElipse newElipse = createEllipse(CLICKED_MOUSE_X,CLICKED_MOUSE_Y,mouseX,mouseY);
      forms.add(newElipse);
      
    break;	

    case 1 : 
      BresenPoly newPoly = createPoly(CLICKED_MOUSE_X,CLICKED_MOUSE_Y,mouseX,mouseY);
      forms.add(newPoly);
    break;	
    
    case 2 : 
      SELECTED_FORM=null;
    break;	

    case 3 : 
      SELECTED_FORM=null;
    break;

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

  public void keyPressed() {
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
public class BresenElipse extends BresenForm {

  public BresenElipse (int centerX, int centerY, int semiXAxis, 
  int semiYAxis, int strokeWidth, int strokeColor){
    this.centerX=centerX;
    this.centerY=centerY;
    this.semiXAxis=semiXAxis;
    this.semiYAxis=semiYAxis;
    this.sizeX=semiXAxis*2;
    this.sizeY=semiYAxis*2;
    this.strokeColor=strokeColor;
    this.strokeWidth=strokeWidth;
    
  }

  public void drawThis(){
    
    int i = REFIL_FACTOR;

    stroke(strokeColor,SATURATION,BRIGHTNESS);

    drawStroke();
    
  }
  
  public void drawStroke(){

    int semiXAxisStroke = semiXAxis;
    int semiYAxisStroke = semiYAxis;
    int repetition = strokeWidth/2;

    drawEllipse(centerX,centerY,semiXAxisStroke,semiYAxisStroke);

    do {
      drawEllipse(centerX,centerY,semiXAxisStroke+repetition,semiYAxisStroke+repetition);
      repetition--;
    } while (repetition > 0);

    drawEllipse(centerX,centerY,semiXAxis,semiYAxis);

  }

  public void drawEllipse(int centerX, int centerY, int semiXAxis, int semiYAxis) {
    
    //A funcao da elipse pode ser definida por
    //f(x,y) = (b^2*x^2) + (a^2*y^2) - (a^2*b^2)
    //sendo a e b os semi-eixos de x e y
    
    //adaptado do algoritmo disponivel em
    //https://www.javatpoint.com/computer-graphics-midpoint-ellipse-algorithm
    //ele usa a derivada parcial de cada eixo pra determinar a funcao do vetor
    //depois dissoé um bresenham convencional
    
    int x = 0;
    int y = semiYAxis;
    double midpoint = (semiYAxis * semiYAxis) - (semiXAxis * semiXAxis * semiYAxis) + (semiXAxis * semiXAxis) / 4;

    drawPoints(centerX, centerY, x, y);
    
    while ((semiXAxis * semiXAxis * (y - 0.5f)) > (semiYAxis * semiYAxis * (x + 1))) {
      if (midpoint <= 0) {
        midpoint += (semiYAxis * semiYAxis) * (2 * x + 3);
      } else {
        midpoint += (semiYAxis * semiYAxis) * (2 * x + 3) + (semiXAxis * semiXAxis) * (-2 * y + 2);
        y--;
      }
      x++;
      
      drawPoints(centerX, centerY, x, y);
    }
    
    midpoint = (semiYAxis * semiYAxis) * ((x + 0.5f) * (x + 0.5f)) + 
    (semiXAxis * semiXAxis) * ((y - 1) * (y - 1)) - 
    (semiXAxis * semiXAxis) * (semiYAxis * semiYAxis);
    
    while (y > 0) {
      if (midpoint <= 0) {
        midpoint += (semiYAxis * semiYAxis) * (2 * x + 2) + (semiXAxis * semiXAxis) * (-2 * y + 3);
        x++;
      } else {
        midpoint += (semiXAxis * semiXAxis) * (-2 * y + 3);
      }
      y--;
      
      drawPoints(centerX, centerY, x, y);
    }
  }

  public void drawPoints(){/**Corpo vazio**/}

  public void drawPoints(int centerX, int centerY, int x, int y) {
    // Desenha pontos simétricos em todos os quatro quadrantes da elipse
    point(centerX + x, centerY + y);
    point(centerX - x, centerY + y);
    point(centerX + x, centerY - y);
    point(centerX - x, centerY - y);
  }
}
abstract class BresenForm {

  int centerX, centerY;
  int strokeWidth;
  int strokeColor;
  int sizeX, sizeY,sides;
  int semiXAxis, semiYAxis;

  public abstract void drawThis();
  public abstract void drawStroke();
  public abstract void drawPoints();


public boolean over()  {
  if (mouseX >= centerX-semiXAxis && mouseX <= centerX+sizeX && 
      mouseY >= centerY-semiYAxis && mouseY <= centerY+sizeY) {
    return true;
  } else {
    return false;
  }
}


}
public class BresenPoly extends BresenForm {

  int sides;
  ArrayList<long[]> points = new ArrayList<long[]>();

   public BresenPoly (int centerX, int centerY, int semiXAxis, 
   int semiYAxis,int sides,int strokeWidth,int strokeColor){
    this.centerX=centerX;
    this.centerY=centerY;
    this.semiXAxis=semiXAxis;
    this.semiYAxis=semiYAxis;
    this.sizeX=semiXAxis*2;
    this.sizeY=semiYAxis*2;
    this.sides=sides;
    this.points=generatePointsBasedOnEllipse(semiXAxis,semiYAxis);
    this.strokeColor=strokeColor;
    this.strokeWidth=strokeWidth;
    
  }

  public ArrayList<long[]> generatePointsBasedOnEllipse(int semiXAxis, int semiYAxis) {
    double angleStep = TWO_PI / sides;
    double angularOffset = angleStep / (sides/2); // Deslocamento angular para garantir que retangulos fiquem corretos
    long[] point;
    ArrayList<long[]> points = new ArrayList<long[]>();

    for (double angle = 0; angle < TWO_PI; angle += angleStep) {
      point = new long[2];
      double x = centerX + semiXAxis * cos((float)(angle + angularOffset)); // Adicionar deslocamento angular
      double y = centerY + semiYAxis * sin((float)(angle + angularOffset)); // Adicionar deslocamento angular
      point[0] = Math.round(x);
      point[1] = Math.round(y);
      points.add(point);
    }
    return points;
  }

  public void drawThis(){
    
    int i = REFIL_FACTOR;

    stroke(strokeColor,SATURATION,BRIGHTNESS);

    drawStroke();
    
  }

  public void drawStroke(){

    int semiXAxisStroke = semiXAxis;
    int semiYAxisStroke = semiYAxis;
    int repetition = strokeWidth/2;
    ArrayList<long[]> points;

    points = generatePointsBasedOnEllipse(semiXAxisStroke,semiYAxisStroke);
    drawPoints(points);

    do {
      points = generatePointsBasedOnEllipse(semiXAxisStroke+repetition,semiYAxisStroke+repetition);
      drawPoints(points);
      points = generatePointsBasedOnEllipse(semiXAxisStroke-repetition,semiYAxisStroke-repetition);
      drawPoints(points);
      repetition--;
    } while (repetition > 0);

  }


  public void drawPoints(ArrayList<long[]> points) {

    int size = points.size() - 1;

    for (int i = 0 ; i <= size ; i++){

      if ( i == size){
        drawPoints((int)points.get(i)[0],(int)points.get(i)[1],
                  (int)points.get(0)[0],(int)points.get(0)[1]);
      }

      else {
        drawPoints((int)points.get(i)[0],(int)points.get(i)[1],
                  (int)points.get(i+1)[0],(int)points.get(i+1)[1]);
      }
    }
  }

  public void drawPoints(int x1, int y1, int x2, int y2) {
    int deltaX = abs(x2 - x1);
    int deltaY = abs(y2 - y1);
    int incrementX = (x1 < x2) ? 1 : -1;
    int incrementY = (y1 < y2) ? 1 : -1;
    int decisionParamater;

    int currentX = x1;
    int currentY = y1;

    point(currentX, currentY);

    if (deltaX > deltaY) {
      decisionParamater = 2 * deltaY - deltaX;

      while (currentX != x2) {
        currentX += incrementX;

        if (decisionParamater >= 0) {
          currentY += incrementY;
          decisionParamater -= 2 * deltaX;
        }

        decisionParamater += 2 * deltaY;

        point(currentX, currentY);
      }
    } else {

      decisionParamater = 2 * deltaX - deltaY;

      while (currentY != y2) {
        currentY += incrementY;

        if (decisionParamater >= 0) {
          currentX += incrementX;
          decisionParamater -= 2 * deltaY;
        }

        decisionParamater += 2 * deltaX;

        point(currentX, currentY);
      }
    }
  }

  public void drawPoints(){}

}
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


  public void settings() { size(800, 680); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "BresenSketch" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
