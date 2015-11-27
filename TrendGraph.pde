class TrendGraph {
  Team team;
  ArrayList<String> data;
  ArrayList<String>  xAxisLabels;
  ArrayList<String>  yAxisLabels;
  ArrayList<Tournament>  tournaments;
  color teamColour1;
  color teamColour2;


  TrendGraph(Team t, ArrayList<String> x, ArrayList<String> y, ArrayList<Tournament> trn) {
    team=t;
    data=team.getPositions();
    xAxisLabels=x;
    yAxisLabels=y;
    tournaments=trn;
    teamColour1=team.getTeamColour1();
    teamColour2=team.getTeamColour2();
  }

  void drawGraph() {
    drawXAxis();
    drawYAxis();
    drawTrendLine();
  }


  void drawXAxis() {
    float x1=425.0f;
    float x2=float(width-80);
    float y=float(height-40);

    float xInterval=(x2-x1)/float(data.size()-1);
    int tick=10;
    strokeWeight(2);
    stroke(255);
    fill(255);
    line(x1, y, x2, y);
    float x=x1;
    textSize(14);
    textAlign(CENTER, CENTER);
    for (String s : xAxisLabels) {
      text(s, x, y+17);
      line(x, y, x, y+tick);
      x+=xInterval;
    }
    
    text("Year", x, y+17);
    text("(Entrants)", x, y+31);
    x=x1;
    for (Tournament trn : tournaments) {
      text("("+trn.getEntrants()+")", x+3, y+31); 
      x+=xInterval;
    }
  }

  void drawYAxis() {
    float x=425.0f;
    float y1=65.0f;
    float y2=float(height-40);

    float yInterval=(y2-y1)/float(yAxisLabels.size());
    int tick=10;
    float y=y1;
    strokeWeight(2);
    stroke(255);
    fill(255);
    line(x, y1, x, y2);
    textSize(14);
    textAlign(CENTER, CENTER);
    text("Position",x,y-14);
    for (String s : yAxisLabels) {
      text(s, x-20, y);
      line(x, y, x-tick, y);
      y+=yInterval;
    }
    text("DNQ", x-27, y2);
    line(x, y, x-tick, y);
  }






  void drawTrendLine() {
    float xBorder1=425.0f;
    float xBorder2=float(width-80);
    float yBorder1=65.0f;
    float yBorder2=float(height-40);
    float xInterval=(xBorder2-xBorder1)/float(data.size()-1);
    float yInterval=(yBorder2-yBorder1)/float(yAxisLabels.size());


    for (int i=1; i<data.size (); i++) {

      float val1=33-(int(data.get(i-1)));
      float val2=33-(int(data.get(i)));

      float x1=xBorder1+xInterval*(i-1);
      float x2=xBorder1+xInterval*(i);
      float y1=yBorder2-val1*yInterval;
      float y2=yBorder2-val2*yInterval;

      if (val1>0&&val2>0) {
        stroke(teamColour1);
      } else {
        stroke(teamColour2);
      }

      line(x1, y1, x2, y2);

      stroke(teamColour2);
      fill(teamColour1);
      ellipse(x1, y1, 13, 13);
      ellipse(x2, y2, 13, 13);
      fill(teamColour2);
      if (val1>0) {
        text(data.get(i-1), x1+17, y1);
      }
      if (val2>0) {
        text(data.get(i), x2+17, y2);
      }
    }
  }
}

