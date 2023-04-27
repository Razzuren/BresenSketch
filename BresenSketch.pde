int REFIL_FACTOR=4;

void setup() {
  size(1200, 680);
  frameRate(4);
}

void draw() {
  background(255);
  stroke(0);
  
  // Exemplo de desenho de um círculo
  BresenElipse circle = new BresenElipse(width/2, height/2, 358, 58);
  circle.drawThis();
  
  // Exemplo de desenho de uma elipse
  //drawEllipse(width/2, height/2, 150, 100);
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
