class Button {
  //Fields
  int bW;
  int bH;
  int bX;
  int bY;
  color colourActive;
  color colourInactive;
  boolean selected;
  String label;
  int tSize;


  //Constructor
  Button( int x, int y, int w, int h, boolean s, String lab) {
    bW=w;
    bH=h;
    bX=x;
    bY=y;
    colourActive=color(255, 215, 0);
    colourInactive=color(238, 232, 170);
    selected=s;
    label=lab;
    tSize=32;
  } 
  //Button off
  void buttonOff() {
    selected=false;
    drawButton();
  }
  //Button on
  void buttonOn() {
    selected=true;
    drawButton();
  }

  void toggleButton() {
    selected=!selected;
  }

  //Draw the button
  void drawButton() {
    if (selected) {
      fill(colourActive);
    } else {
      fill(colourInactive);
    }
    noStroke();
    rect(bX, bY, bW, bH);
    textSize(tSize);
    textAlign(CENTER, BOTTOM);
    if (selected) {
      fill(25);
    } else {
      fill(125);
    }
    text(label, bX+bW/2, bY+bH);
  }
  //get button location / dimensions  
  int getX() {
    return bX;
  }
  int getY() {
    return bY;
  }
  int getW() {
    return bW;
  }
  int getH() {
    return bH;
  }
  //get button selected value 
  boolean isSelected() {
    return selected;
  }
}

