import java.util.*;
import java.awt.*;

LinkedList<Point> points = new LinkedList();

void setup(){
  size(256, 256);
}

void draw(){
  pushMatrix();
  translate(0, 256);
  rotate(-HALF_PI);
  background(255);
  for(int i = 0; i < points.size(); i++){
    Point p = points.get(i);
    circle(p.x, p.y, 8);
  }
  fill(0, 128, 255);
  //傾きを求める
  float a = getKyo() / getSX();
  float num = 0;
  float sx = 0, sy = 0;
  for(int i = 0; i < points.size(); i++){
    sx += points.get(i).x;
    sy += points.get(i).y;
    num +=1;
  }
  float ax = sx / num, ay = sy / num;
  float b = ay - a * ax;
  for(int i = 0; i < width; i++){
    line(i - 1, a * i - a + b, i, a * i + b);
  }
  float r = getKyo() / (sqrt(getSX()) * sqrt(getSY()));
  popMatrix();
  text("r = " + r, 10, 10);
}

// X とYの共分散を求める
float getKyo(){
  float num = 0, sxy = 0;
  float sx = 0, sy = 0;
  for(int i = 0; i < points.size(); i++){
    sx += points.get(i).x;
    sy += points.get(i).y;
    num +=1;
  }
  float ax = sx / num, ay = sy / num;
  for(int i = 0; i < points.size(); i++){
    sxy += (points.get(i).x - ax) * (points.get(i).y - ay);
  }
  return sxy / num;
}

//X の分散を求める
float getSX(){
  float sx = 0, sxx=0, num=0;
  for(int i = 0; i < points.size(); i++){
    sx += points.get(i).x;
    sxx += points.get(i).x * points.get(i).x;
    num += 1;
  }
  float ax = sx / num;
  float axx = sxx / num;
  return axx - ax * ax;
}

//Yの分散を求める
float getSY(){
  float sy = 0, syy=0, num=0;
  for(int i = 0; i < points.size(); i++){
    sy += points.get(i).y;
    syy += points.get(i).y * points.get(i).y;
    num += 1;
  }
  float ay = sy / num;
  float ayy = syy / num;
  return ayy - ay * ay;
}

void mousePressed(MouseEvent event){
  int x = 256 - event.getY();
  int y = event.getX();
  points.add(new Point(x, y));
  System.out.println("New Point: ("+ x +", "+ y + ")");
}
