public class BresenPoly extends BresenForm {

  int sides;
  int semiXAxis, semiYAxis;
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

  ArrayList<long[]> generatePointsBasedOnEllipse(int semiXAxis, int semiYAxis) {
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

  void drawThis(){
    
    int i = REFIL_FACTOR;

    stroke(strokeColor,SATURATION,BRIGHTNESS);

    drawStroke();
    
  }

  void drawStroke(){

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


  void drawPoints(ArrayList<long[]> points) {

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