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


//Borders
int flagPanelW=272;
int flagW=68;
int flagH=40;


//Buttons
Button nationsButton;
Button tournamentsButton;

Button summaryButton;
Button graphButton;
Button clearButton;

//Button selected bools
boolean nationsSelected=true;
boolean tournamentSelected=false;
boolean summarySelected=true;
boolean graphSelected=false;

boolean axisDrawn=false;

Team selectedTeam;

void setup() {
  size(1300, 680);
  background(200);
  stroke(0);

  //Load data from csv files
  loadTeamData();
  loadTournamentData();
  loadFinalPositionsData();
  //Draw the left panel
  drawLeftPanel();
  addFlags();
  addButtons();
  nationsButton.drawButton();
  tournamentsButton.drawButton();
  selectedTeam=teams.get(0);

  addLabels();
}
void draw() {


  //Check which panel is active and draw
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

  //Check if any buttons clicked
  for (Button button : buttons) {
    if (mouseX>button.getX()&&mouseX<button.getX()+button.getW()&&
      mouseY>button.getY()&&mouseY<button.getY()+button.getH()) {

      //Show nations
      if (button==nationsButton && !nationsButton.isSelected()) {

        nationsButton.toggleButton();
        tournamentsButton.toggleButton();
        clearDisplay();
        redrawTeamButtons();
      }

      //Show tournaments
      if (button==tournamentsButton && !tournamentsButton.isSelected()) {

        nationsButton.toggleButton();
        tournamentsButton.toggleButton();
        clearButton.toggleButton();
        clearDisplay();
      }
      //Show team summary
      if (button==summaryButton && ! summaryButton.isSelected()) {

        summaryButton.toggleButton();
        graphButton.toggleButton();
        clearButton.toggleButton();
        clearDisplay();
        selectedTeam.displayDetails();
      }
      //Show team graph
      if (button==graphButton && ! graphButton.isSelected()) {
        
        graphButton.toggleButton();
        summaryButton.toggleButton();
        clearButton.toggleButton();
        clearDisplay();
        selectedTeam.drawTrendGraph(positionLabels, yearLabels, tournaments);
        axisDrawn=true;
      }

      if (button==clearButton) {
        clearDisplay();
      }
    }
  }




  //Check if flag clicked and display team
  if (nationsButton.isSelected()) {

    for (Team team : teams) {

      if (mouseX>team.getFlagX()&&mouseX<team.getFlagX()+flagW &&
        mouseY>team.getFlagY()&&mouseY<team.getFlagY()+flagH) {
        if (summaryButton.isSelected()) {
          clearDisplay();
          team.displayDetails();
          selectedTeam=team;
        } else {
          if (!axisDrawn) {
            axisDrawn=false;
            team.drawTrendGraph(positionLabels, yearLabels, tournaments);
            axisDrawn=true;
          } else {
            team.drawTrendLine(positionLabels, yearLabels, tournaments);
          }
          selectedTeam=team;
        }
      }
    }
    redrawTeamButtons();
  }
  //Check if tournament clicked and show
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



//Add buttons
void addButtons() {
  noStroke();

  nationsButton=
    new Button(flagW*2+1, 601, flagW*3-1, flagH-1, true, "Nations");
  buttons.add(nationsButton);


  tournamentsButton=
    new Button( 0, 640, flagW*5+flagH, flagH, false, "Tournaments");
  buttons.add(tournamentsButton);

  clearButton=
    new Button(width-420, 0, 100, flagH, false, "Clear");
  buttons.add(clearButton);

  summaryButton=
    new Button(width-320, 0, 170, flagH, true, "Summary");
  buttons.add(summaryButton);


  graphButton=
    new Button( width-150, 0, 150, flagH, false, "Graph");
  buttons.add(graphButton);
}






//Redraw mode buttons
void redrawModeButtons() {
  nationsButton.drawButton();
  tournamentsButton.drawButton();
}


//redraw team buttons
void redrawTeamButtons() {
  summaryButton.drawButton();
  graphButton.drawButton();
  clearButton.drawButton();
}

//draw the left panel
void drawLeftPanel() {
  fill(255, 215, 0);
  noStroke();
  rect(0, 0, flagPanelW+flagW+flagH, height);
}

//Draw Flags
void addFlags() {
  int row=0;
  int col=0;

  drawLeftPanel();
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

//Draw tournament labels
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


//Populate arraylists of labels for graphs
void addLabels() {
  for (int i=1; i<=32; i+=1) {
    positionLabels.add(String.valueOf(i));
  }


  for (Tournament t : tournaments) {
    yearLabels.add(t.getYear());
  }
}



//Clear the display panel
void clearDisplay() {
  int displayX1=381; 
  int displayX2=width-displayX1; 
  stroke(0); 
  fill(65); 
  rect(displayX1, 0, displayX2, height);
  axisDrawn=false;
}




//Load team data from csv
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

//Load positions data from csv
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
  //set positions foreach team
  for (int i =0; i < teams.size (); i++) {
    teams.get(i).setPositions(finalPositions.get(i));
  }
}

//load tournament data from csv
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

