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
    //ele usa a derivada parcial de cada eixo pra determinar a funcao do vetor
    //depois dissoé um bresenham convencional
    
    int x = 0;
    int y = semiYAxis;
    double midpoint = (semiYAxis * semiYAxis) - (semiXAxis * semiXAxis * semiYAxis) + (semiXAxis * semiXAxis) / 4;

    drawPoints(centerX, centerY, x, y);
    
    while ((semiXAxis * semiXAxis * (y - 0.5)) > (semiYAxis * semiYAxis * (x + 1))) {
      if (midpoint <= 0) {
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

  void drawPoints(){/**Corpo vazio**/}

  void drawPoints(int centerX, int centerY, int x, int y) {
    // Desenha pontos simétricos em todos os quatro quadrantes da elipse
    point(centerX + x, centerY + y);
    point(centerX - x, centerY + y);
    point(centerX + x, centerY - y);
    point(centerX - x, centerY - y);
  }
}