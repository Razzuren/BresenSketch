abstract class BresenForm {

  int centerX, centerY;
  int strokeWidth;
  int strokeColor;
  int sizeX, sizeY,sides;
  int semiXAxis, semiYAxis;

  abstract void drawThis();
  abstract void drawStroke();
  abstract void drawPoints();


boolean over()  {
  if (mouseX >= centerX-semiXAxis && mouseX <= centerX+sizeX && 
      mouseY >= centerY-semiYAxis && mouseY <= centerY+sizeY) {
    return true;
  } else {
    return false;
  }
}


}