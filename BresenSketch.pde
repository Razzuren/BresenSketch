int REFIL_FACTOR=4;

void setup() {
  size(1200, 680);
  frameRate(4);
}

void draw() {
  background(255);
  stroke(0);
  
  // Exemplo de desenho de um elipse
  BresenElipse elips = new BresenElipse(50+60, 50+90, 60, 90);
  elips.drawThis();
  
  // Exemplo de desenho de uma elipse
  BresenPoly poly = new BresenPoly(150+60, 150+90, 60, 90);
  poly.drawThis();
}

abstract class BresenForm {

  int centerX, centerY;
  int strokeWidth;
  int[] strokeColor;
  int[] fillColor;
  int sizeX, sizeY;

  abstract void drawThis();
  abstract void drawStroke();
  abstract void drawFill();
  abstract void drawPoints();

}

public class BresenElipse extends BresenForm{

  int semiXAxis, semiYAxis;

  public BresenElipse (int centerX, int centerY, int semiXAxis, int semiYAxis){
    this.centerX=centerX;
    this.centerY=centerY;
    this.semiXAxis=semiXAxis;
    this.semiYAxis=semiYAxis;
    this.sizeX=semiXAxis*2;
    this.sizeY=semiYAxis*2;
    
  }

  void drawThis(){
    
    int i = REFIL_FACTOR;
    
    drawStroke();
    
     do{ 
      
      drawFill();
      i--;
      
    }while (i>0);
    
  }
  
  void drawStroke(){

    drawEllipse(centerX,centerY,semiXAxis,semiYAxis);

  }
  
  void drawFill() {

    int semiXAxisFill = semiXAxis;
    int semiYAxisFill = semiYAxis;

    do {
      drawEllipse(centerX,centerY,semiXAxisFill,semiYAxis);
      semiXAxisFill--;
      semiYAxisFill--;

    } while (semiXAxisFill >= 0 || semiYAxisFill >= 0);
  
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

public class BresenPoly extends BresenForm{

  int sides;
  int semiXAxis, semiYAxis;
  ArrayList<int[]> points = new ArrayList<int[]>();

   public BresenPoly (int centerX, int centerY, int semiXAxis, int semiYAxis,int sides){
    this.centerX=centerX;
    this.centerY=centerY;
    this.semiXAxis=semiXAxis;
    this.semiYAxis=semiYAxis;
    this.sizeX=semiXAxis*2;
    this.sizeY=semiYAxis*2;
    this.sides
    
  }

  void generatePointsBasedOnElipse(int centerX, int centerY, int semiXAxis, int semiYAxis) {
    float angleStep = TWO_PI/sides; // Incremento do ângulo
    int[] point = new int[2];
    
    for (float angle = 0; angle < TWO_PI; angle += angleStep) {
      float x = centerX + semiXAxis * cos(angle);
      float y = centerY + semiYAxis * sin(angle);
      point[0]=Math.round(x);
      point[1]=Math.round(y);
      points.add(point);
    }
  }

  void drawThis(){
     int i = REFIL_FACTOR;
  
    drawStroke();
    
    do{ 
    
    drawFill();
    i--;
    
    }while (i>0);

  }

  void drawStroke(){}
  void drawFill(){}

  void drawPoints() {

    for (int i = 0 ; i <= this.points.size() ; i++){

      if ( i == this.points.size()){

        drawPoints(this.points.get(i)[0],this.points.get(i)[1],
                  this.points.get(0)[0],this.points.get(0)[1]);

      }

      else {

        drawPoints(this.points.get(i)[0],this.points.get(i)[1],
                  this.points.get(i+1)[0],this.points.get(i+1)[1]);

      }

    }

  }

  void drawPoints(int x1, int y1, int x2, int y2) {

    int deltaX = x1 - x2;
    int deltaY = y1 - y2;

}

}
