//Arraylist of team objects
ArrayList<Team> teams = new ArrayList<Team>(); 

//2d Arraylist of team data
ArrayList<ArrayList<String>> teamData = new ArrayList<ArrayList<String>>();

//2d Arraylist of team final position data
ArrayList<ArrayList<String>> finalPositions = new ArrayList<ArrayList<String>>();

//Arraylist of tournament objects
ArrayList<Tournament> tournaments = new ArrayList<Tournament>(); 

//2d arraylist of tournament data
ArrayList<ArrayList<String>> tournamentData = new ArrayList<ArrayList<String>>();

//Arraylist of button objects
ArrayList<Button> buttons = new ArrayList<Button>(); 

//ArrayLists of labels for graphs
ArrayList<String> positionLabels = new ArrayList<String>();
ArrayList<String> yearLabels = new ArrayList<String>();

int flagPanelW=272;
int flagW=68;
int flagH=40;

Button nationsButton;
Button tournamentsButton;

Button summaryButton;
Button graphButton;


boolean nationsSelected=true;
boolean tournamentSelected=false;
boolean summarySelected=true;
boolean graphSelected=false;
Team selectedTeam;

void setup() {
  size(1300, 680);
  background(200);
  stroke(0);
  loadTeamData();
  loadTournamentData();
  loadFinalPositionsData();
  clearDisplay();
  drawLeftPanel();
  addFlags();
  addButtons();
  nationsButton.drawButton();
  tournamentsButton.drawButton();
  selectedTeam=teams.get(0);

  addLabels();
}
void draw() {



  if (nationsButton.isSelected()) {
    nationsSelected=true;
    tournamentSelected=false;
    addFlags();
  } else {
    nationsSelected=false;
    tournamentSelected=true;
    addTournamentLabels();
  }

  redrawModeButtons();
}

void mousePressed() {
  for (Button button : buttons) {
    if (mouseX>button.getX()&&mouseX<button.getX()+button.getW()&&
      mouseY>button.getY()&&mouseY<button.getY()+button.getH()) {

      if (button==nationsButton && !nationsButton.isSelected()) {
        
          nationsButton.toggleButton();
          tournamentsButton.toggleButton();
          clearDisplay();
          redrawTeamButtons();
      
      }
      if (button==tournamentsButton && !tournamentsButton.isSelected()) {
       
          nationsButton.toggleButton();
          tournamentsButton.toggleButton();
          clearDisplay();
        
      }

      if (button==summaryButton && ! summaryButton.isSelected()) {
       
          summaryButton.toggleButton();
          graphButton.toggleButton();
          clearDisplay();
          selectedTeam.displayDetails();
        
      }

      if (button==graphButton && ! graphButton.isSelected()) {
       
          graphButton.toggleButton();
          summaryButton.toggleButton();
          clearDisplay();
          selectedTeam.drawTrendGraph(positionLabels,yearLabels,tournaments);
        
      }
    }
  }





  if (nationsButton.isSelected()) {

    for (Team team : teams) {

      if (mouseX>team.getFlagX()&&mouseX<team.getFlagX()+flagW &&
        mouseY>team.getFlagY()&&mouseY<team.getFlagY()+flagH) {
        if (summaryButton.isSelected()) {
          clearDisplay();
          team.displayDetails();
          selectedTeam=team;
        } else {
          clearDisplay();
          team.drawTrendGraph(positionLabels, yearLabels,tournaments);
          selectedTeam=team;
        }
      }
    }
    redrawTeamButtons();
  }

  if (tournamentsButton.isSelected()) {

    for (Tournament tournament : tournaments) {
      if (mouseX>tournament.getFlagX()&&mouseX<tournament.getFlagX()+flagW+85 &&
        mouseY>tournament.getFlagY()&&mouseY<tournament.getFlagY()+flagH) {
        clearDisplay();
        tournament.displayDetails();
      }
    }
  }
}




void addButtons() {
  noStroke();

  nationsButton=
    new Button(flagW*2+1, 601, flagW*3-1, flagH-1, true, "Nations");
  buttons.add(nationsButton);


  tournamentsButton=
    new Button( 0, 640, flagW*5+flagH, flagH, false, "Tournaments");
  buttons.add(tournamentsButton);

  summaryButton=
    new Button(width-300, 0, 150, flagH, true, "Summary");
  buttons.add(summaryButton);


  graphButton=
    new Button( width-150, 0, 150, flagH, false, "Graph");
  buttons.add(graphButton);
}







void redrawModeButtons() {
  nationsButton.drawButton();
  tournamentsButton.drawButton();
}

void redrawTeamButtons() {
  summaryButton.drawButton();
  graphButton.drawButton();
}

void drawLeftPanel() {
  fill(255, 215, 0);
  noStroke();
  rect(0, 0, flagPanelW+flagW+flagH, height);
}


void addFlags() {
  int row=0;
  int col=0;

  drawLeftPanel();



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
  stroke(0);
  strokeWeight(1);

  for (int i =flagW; i<flagPanelW+flagW; i+=flagW) {
    line(i, 0, i, height-flagH);
  }
  for (int i =flagH; i<height-flagH; i+=flagH) {
    line(0, i, flagPanelW+flagW-1, i);
  }
  line(flagPanelW+flagW, 0, flagPanelW+flagW, height-flagH*2);
}


void addTournamentLabels() {
  fill(0, 191, 255);
  noStroke();
  rect(0, 0, flagPanelW+flagW, height);
  rect(0, height-flagH*2+1, flagW*2+1, flagH);
  fill(255, 215, 0);
  rect(flagW*5, height-flagH*2+1, flagH, flagH);
  int row=10;
  int col=10;
  int halfW=flagPanelW/2+25;

  for (Tournament tournament : tournaments) {
    tournament.drawFlag(col, row);
    fill(0);
    text(tournament.getYear(), col+115, row+36);
    if (col >=halfW) {
      row+=61;
      col=10;
    } else {
      col+=halfW;
    }
    if (row>=630) {
      row=0;
    }
  }
  stroke(255, 215, 0);
  line(flagPanelW+flagW, 0, flagPanelW+flagW, height-flagH*2);
  fill(255, 215, 0);
  noStroke();
  rect(flagPanelW+flagW, height-flagH, flagH, flagH);
}

void addLabels() {
  for (int i=1; i<=32; i+=1) {
    positionLabels.add(String.valueOf(i));
  }


  for (Tournament t : tournaments) {
    yearLabels.add(t.getYear());
  }
}




void clearDisplay() {
  int displayX1=381; 
  int displayX2=width-displayX1; 
  stroke(0); 
  fill(65); 
  rect(displayX1, 0, displayX2, height);
}





void loadTeamData()
{
  //Load team data to a string arrray
  String[] strings = loadStrings("worldcup.csv"); 

  //Split cs strings
  for (String s : strings)
  {
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

void loadFinalPositionsData()
{
  //Load final position data to a string arrray
  String[] strings = loadStrings("teampositions.csv"); 



  //Split cs strings
  for (String s : strings)
  {
    String[] line = s.split(","); 
    ArrayList<String> lineData = new ArrayList<String>(); 

    for (int i = 1; i < line.length; i ++)
    {
      lineData.add(line[i]);
    }
    finalPositions.add(lineData);
  }

  for (int i =0; i < teams.size (); i++) {
    teams.get(i).setPositions(finalPositions.get(i));
  }
}

void loadTournamentData()
{
  //Load team data to a string arrray
  String[] strings = loadStrings("tournaments.csv"); 

  //Split cs strings
  for (String s : strings)
  {
    String[] line = s.split(","); 
    ArrayList<String> lineData = new ArrayList<String>(); 


    for (int i = 0; i < line.length; i ++)
    {
      lineData.add(line[i]);
    }
    tournamentData.add(lineData);
  }

  //Add team objects to arraylist
  for (ArrayList<String> s : tournamentData)
  {
    Tournament tournament=new Tournament(s); 
    tournaments.add(tournament);
  }
}

