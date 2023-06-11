
public class  BresenUI {

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

}
