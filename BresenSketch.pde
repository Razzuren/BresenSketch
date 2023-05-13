int REFIL_FACTOR=4;
int SIDES = 4;
int STROKE_WIDTH=3;
int STROKE_COLOR=56;
int SATURATION=100;
int BRIGHTNESS=100;
int FUNCTION_SELECTED=0;
int CLICKED_MOUSE_X=0;
int CLICKED_MOUSE_Y=0;
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

 /*  Exemplo de desenho de um elipse
  BresenElipse elips = new BresenElipse(500+60, 500+90, 60, 90,5,STROKE_COLOR);
  elips.drawThis();
  
  Exemplo de desenho de uma elipse
  BresenPoly poly = new BresenPoly(200+60, 200+90, 60, 200,7,3,STROKE_COLOR);
  poly.drawThis(); */

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
    SELECTION_RECT.sides=4;
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

abstract class BresenForm {

  int centerX, centerY;
  int strokeWidth;
  int strokeColor;
  int sizeX, sizeY,sides;

  abstract void drawThis();
  abstract void drawStroke();
  abstract void drawPoints();

}

public class BresenElipse extends BresenForm {

  int semiXAxis, semiYAxis;

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

  void drawThis(){
    
    int i = REFIL_FACTOR;

    stroke(strokeColor,SATURATION,BRIGHTNESS);

    drawStroke();
    
  }
  
  void drawStroke(){

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

  void drawEllipse(int centerX, int centerY, int semiXAxis, int semiYAxis) {
    
    //A funcao da elipse pode ser definida por
    //f(x,y) = (b^2*x^2) + (a^2*y^2) - (a^2*b^2)
    //sendo a e b os semi-eixos de x e y
    
    //adaptado do algoritmo disponivel em
    //https://www.javatpoint.com/computer-graphics-midpoint-ellipse-algorithm
    
    int x = 0;
    int y = semiYAxis;
    float midpoint = (semiYAxis * semiYAxis) - (semiXAxis * semiXAxis * semiYAxis) + (semiXAxis * semiXAxis) / 4;
    
    drawPoints(centerX, centerY, x, y);
    
    while ((semiXAxis * semiXAxis * (y - 0.5)) > (semiYAxis * semiYAxis * (x + 1))) {
      if (midpoint < 0) {
        midpoint += (semiYAxis * semiYAxis) * (2 * x + 3);
      } else {
        midpoint += (semiYAxis * semiYAxis) * (2 * x + 3) + (semiXAxis * semiXAxis) * (-2 * y + 2);
        y--;
      }
      x++;
      
      drawPoints(centerX, centerY, x, y);
    }
    
    midpoint = (semiYAxis * semiYAxis) * ((x + 0.5) * (x + 0.5)) + 
    (semiXAxis * semiXAxis) * ((y - 1) * (y - 1)) - 
    (semiXAxis * semiXAxis) * (semiYAxis * semiYAxis);
    
    while (y > 0) {
      if (midpoint < 0) {
        midpoint += (semiYAxis * semiYAxis) * (2 * x + 2) + (semiXAxis * semiXAxis) * (-2 * y + 3);
        x++;
      } else {
        midpoint += (semiXAxis * semiXAxis) * (-2 * y + 3);
      }
      y--;
      
      drawPoints(centerX, centerY, x, y);
    }
  }

  void drawPoints(){/**Corpo vazio**/}

  void drawPoints(int centerX, int centerY, int x, int y) {
    // Desenha pontos simétricos em todos os quatro quadrantes da elipse
    point(centerX + x, centerY + y);
    point(centerX - x, centerY + y);
    point(centerX + x, centerY - y);
    point(centerX - x, centerY - y);
  }
}

public class BresenPoly extends BresenForm {

  int sides;
  int semiXAxis, semiYAxis;
  ArrayList<int[]> points = new ArrayList<int[]>();

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

  ArrayList<int[]> generatePointsBasedOnEllipse(int semiXAxis, int semiYAxis) {
    float angleStep = TWO_PI / sides;
    float angularOffset = angleStep / (sides/2); // Deslocamento angular para garantir que retangulos fiquem corretos
    int[] point;
    ArrayList<int[]> points = new ArrayList<int[]>();

    for (float angle = 0; angle < TWO_PI; angle += angleStep) {
      point = new int[2];
      float x = centerX + semiXAxis * cos(angle + angularOffset); // Adicionar deslocamento angular
      float y = centerY + semiYAxis * sin(angle + angularOffset); // Adicionar deslocamento angular
      point[0] = Math.round(x);
      point[1] = Math.round(y);
      points.add(point);
    }
    return points;
  }

  void drawThis(){
    
    int i = REFIL_FACTOR;

    stroke(strokeColor,SATURATION,BRIGHTNESS);

    drawStroke();
    
  }

  void drawStroke(){

    int semiXAxisStroke = semiXAxis;
    int semiYAxisStroke = semiYAxis;
    int repetition = strokeWidth/2;
    ArrayList<int[]> points;

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


  void drawPoints(ArrayList<int[]> points) {

    int size = points.size() - 1;

    for (int i = 0 ; i <= size ; i++){

      if ( i == size){
        drawPoints(points.get(i)[0],points.get(i)[1],
                  points.get(0)[0],points.get(0)[1]);
      }

      else {
        drawPoints(points.get(i)[0],points.get(i)[1],
                  points.get(i+1)[0],points.get(i+1)[1]);
      }
    }
  }

  void drawPoints(int x1, int y1, int x2, int y2) {
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

  void drawPoints(){}

}

public class  BresenUI {

  public BresenElipse createEllipse (int x0,int y0,int x1,int y1){

    int deltaX = Math.abs(x1 - x0);
    int deltaY = Math.abs(y1 - y0);

    return new BresenElipse(x0,y0,deltaX,deltaY,STROKE_WIDTH,STROKE_COLOR);

  }

  public BresenPoly createPoly (int x0,int y0,int x1,int y1){

    int deltaX = Math.abs(x1 - x0);
    int deltaY = Math.abs(y1 - y0);

    return new BresenPoly(x0,y0,deltaX,deltaY,SIDES,STROKE_WIDTH,STROKE_COLOR);

  }

}
