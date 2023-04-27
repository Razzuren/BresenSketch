void setup() {
  size(400, 400);
}

void draw() {
  background(255);
  
  // Exemplo de desenho de um círculo
  drawEllipse(width/2, height/2, 100, 100);
  
  // Exemplo de desenho de uma elipse
  drawEllipse(width/2, height/2, 150, 100);
}

void drawEllipse(int centerX, int centerY, int semiXAxis, int semiYAxis) {
  
  //A funcao da elipse pode ser definida por
  //f(x,y) = (b^2*x^2) + (a^2*y^2) - (a^2*b^2)
  //sendo a e b os semi-eixos de x e y
  
  //adaptado do algoritmo disponivel em
  //https://www.javatpoint.com/computer-graphics-midpoint-ellipse-algorithm
  
  int a = semiXAxis;
  int b = semiYAxis;
  
  int x = 0;
  int y = semiYAxis;
  float midpoint = (semiYAxis * semiYAxis) - (semiXAxis * semiXAxis * semiYAxis) + (semiXAxis * semiXAxis) / 4;
  
  drawEllipsePoints(centerX, centerY, x, y);
  
  while ((semiXAxis * semiXAxis * (y - 0.5)) > (semiYAxis * semiYAxis * (x + 1))) {
    if (midpoint < 0) {
      midpoint += (semiYAxis * semiYAxis) * (2 * x + 3);
    } else {
      midpoint += (semiYAxis * semiYAxis) * (2 * x + 3) + (semiXAxis * semiXAxis) * (-2 * y + 2);
      y--;
    }
    x++;
    
    drawEllipsePoints(centerX, centerY, x, y);
  }
  
  midpoint = (semiYAxis * semiYAxis) * ((x + 0.5) * (x + 0.5)) + (semiXAxis * semiXAxis) * ((y - 1) * (y - 1)) - (semiXAxis * semiXAxis) * (semiYAxis * semiYAxis);
  
  while (y > 0) {
    if (midpoint < 0) {
      midpoint += (semiYAxis * semiYAxis) * (2 * x + 2) + (semiXAxis * semiXAxis) * (-2 * y + 3);
      x++;
    } else {
      midpoint += (semiXAxis * semiXAxis) * (-2 * y + 3);
    }
    y--;
    
    drawEllipsePoints(centerX, centerY, x, y);
  }
}

void drawEllipsePoints(int centerX, int centerY, int x, int y) {
  // Desenha pontos simétricos em todos os quatro quadrantes da elipse
  point(centerX + x, centerY + y);
  point(centerX - x, centerY + y);
  point(centerX + x, centerY - y);
  point(centerX - x, centerY - y);
}
