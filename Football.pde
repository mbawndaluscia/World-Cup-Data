//Arraylist of Team objects
ArrayList<Team> teams = new ArrayList<Team>(); 

//2d arraylist of team data
ArrayList<ArrayList<String>> teamData = new ArrayList<ArrayList<String>>();

int flagW=68;
int flagH=40;
void setup() {
  size(1200, 680);
  background(200);
  stroke(0);
  loadData();
}
void draw() {
  drawFlags();
}

void mousePressed() {
  for (Team team : teams) {
    if (mouseX>team.getFlagX()&&mouseX<team.getFlagX()+flagW) {
      if (mouseY>team.getFlagY()&&mouseY<team.getFlagY()+flagH) {


        displayTeamSummary(team);
      }
    }
  }
}


void displayTeamSummary(Team team) {
  int displayX1=381;
  int displayX2=width-displayX1;
  fill(200);
  rect(displayX1,0,displayX2,height);
  stroke(0);
  fill(0);
  textSize(28);
  text(team.getAllDetails(), displayX1+100, 100);
}




void drawFlags() {
  int row=0;
  int col=0;



  int flagPanelW=272;
  fill(230, 230, 20);
  rect(0, 0, flagPanelW+flagW+flagH, height);

  //Draw Flags
  for (Team t : teams) {
    t.drawFlag(col, row);
    if (col<flagPanelW) {
      col+=flagW;
    } else {
      col=0;
      row+=flagH;
    }
  }


  //Draw borders
  strokeWeight(4);
  stroke(0);
  for (int i =0; i<=flagPanelW+flagW; i+=flagW) {
    line(i, 0, i, height-flagH);
  }
  for (int i =0; i<=height; i+=flagH) {
    line(0, i, flagPanelW+flagW, i);
  }

  //Draw buttons to toggle beteween nations and tournaments
  fill(230, 230, 20);
  stroke(0);
  strokeWeight(0);
  rect(col, row, flagW*3+flagH, flagH);
  fill(0);
  textSize(28);
  text("Nations", col+50, row+30);
  row+=flagH;
  col=0;

  fill(230, 230, 60);
  rect(col, row, flagW*5, flagH);
  stroke(0);
  fill(0);
  text("Tournaments", col+70, row+30);
}




void loadData()
{
  //Load teaam data to a string arrray
  String[] strings = loadStrings("worldcup.csv");

  //Split cs strings
  for (String s : strings)
  {
    println(s);
    String[] line = s.split(",");
    ArrayList<String> lineData = new ArrayList<String>();


    for (int i = 0; i < line.length; i ++)
    {
      lineData.add(line[i]);
    }
    teamData.add(lineData);
  }

  //Add team objects to arraylist
  for (ArrayList<String> s : teamData)
  {
    Team team=new Team(s); 
    teams.add(team);
  }
}

