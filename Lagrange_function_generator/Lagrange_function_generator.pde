import java.util.*;
import java.awt.*;

LinkedList<Point> points = new LinkedList();

void setup(){
  size(256, 256);
}

void draw(){
  background(255);
  int[] ys = new int[width];
  for(int i = 0; i < width; i++){
    ys[i] = getY(i);
  }
  stroke(0, 255, 128);
  for(int i = 1; i < width; i++){
    line(i, ys[i], i -1, ys[i - 1]);
    //line(ys[i], i, ys[i - 1], i - 1);
  }
  fill(0, 128, 255);
  for(int i = 0; i < points.size(); i++){
    Point p = points.get(i);
    circle(p.x, p.y, 8);
  }
}

int getY(int x0){
  float sum = 0;
  if(points.size() == 0)return 0;
  for(int i = 0; i < points.size(); i++){
    sum += points.get(i).y * twoF(i, x0) / twoF(i, points.get(i).x);
  }
  return (int) sum;
}

float twoF(int i, int x){
  int pi = 1;
  for(int k = 0; k < points.size(); k++){
    if(k != i)pi *= x - points.get(k).x;
  }
  return (float) pi;
}

void mousePressed(MouseEvent event){
  points.add(new Point(event.getX(), event.getY()));
}
