//Arraylist of teams
ArrayList<Team> teams = new ArrayList<Team>(); 

//2d Arraylist of team data
ArrayList<ArrayList<String>> teamData = new ArrayList<ArrayList<String>>();

//2d Arraylist of team final position data
ArrayList<ArrayList<String>> finalPositions = new ArrayList<ArrayList<String>>();

//Arraylist of tournaments
ArrayList<Tournament> tournaments = new ArrayList<Tournament>(); 

//2d arraylist of tournament data
ArrayList<ArrayList<String>> tournamentData = new ArrayList<ArrayList<String>>();

//Arraylist of buttons
ArrayList<Button> buttons = new ArrayList<Button>(); 

//ArrayLists of labels for graphs
ArrayList<String> positionLabels = new ArrayList<String>();
ArrayList<String> yearLabels = new ArrayList<String>();

PFont font;

//Borders
int flagPanelW=272;
int flagW=68;
int flagH=40;


//Buttons
Button nationsButton;
Button tournamentsButton;
Button mapButton;

Button summaryButton;
Button graphButton;
Button clearButton;

Button goalsButton;

Button appearancesButton;

boolean axisDrawn=false;

Team selectedTeam;



void setup() {
  size(1300, 680);
  background(65);
  stroke(0);

  //Font
  font=createFont("Meiryo-Bold.vlw", 28);
  textFont(font);

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
  fill(255);
  textSize(40);
  textAlign(CENTER);
  text("Football World Cup Stats", width/2, flagH);
  showInstructions();
}
void draw() {
  redrawModeButtons();
}

void mousePressed() {

  //Check if any buttons clicked
  for (Button button : buttons) {
    if (mouseX>button.getX()&&mouseX<button.getX()+button.getW()&&
      mouseY>button.getY()&&mouseY<button.getY()+button.getH()) {

      //Show nations
      if (button==nationsButton && !nationsButton.isSelected()) {

        nationsButton.buttonOn();
        tournamentsButton.buttonOff();
        mapButton.buttonOff();
        clearDisplay();
        redrawTeamButtons();
        addFlags();
        showInstructions();
      }

      if (nationsButton.isSelected()) {
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
          selectedTeam.printGraphInstructions();
          axisDrawn=true;
        }
        //Clear the right panel
        if (button==clearButton) {
          clearDisplay();
        }
      }
      //Show maps
      if (button==mapButton && !mapButton.isSelected()) {
        mapButton.buttonOn();
        nationsButton.buttonOff();
        tournamentsButton.buttonOff();
        // redrawModeButtons();
        clearDisplay();
        showMap();
        redrawMapButtons();
        drawAppearances();
        showInstructions();
      }
      if (button==goalsButton && !goalsButton.isSelected()) {
        goalsButton.buttonOn();
        appearancesButton.buttonOff();
        showMap();
        drawGoals();
        redrawMapButtons();
      }

      if (button==appearancesButton && !appearancesButton.isSelected()) {
        goalsButton.buttonOff();
        appearancesButton.buttonOn();
        showMap();
        drawAppearances();
        redrawMapButtons();
      }

      //Show tournaments
      if (button==tournamentsButton && !tournamentsButton.isSelected()) {
        mapButton.buttonOff();
        nationsButton.buttonOff();
        tournamentsButton.buttonOn();
        redrawModeButtons();
        clearDisplay();
        addTournamentLabels();
        showInstructions();
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
            team.displayHeader();
          } else {
            team.drawTrendLine(positionLabels, yearLabels, tournaments);
            team.displayHeader();
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
        tournament.displayTeamPositions(teams);
      }
    }
  }
//Check if map selected
  if (mapButton.isSelected()) {

    showMap();
    showInstructions();
    if (goalsButton.isSelected()) {
      drawGoals();
    }
    if (appearancesButton.isSelected()) {
      drawAppearances();
    }
    redrawMapButtons();

    for (Team team : teams) {
      if (mouseX>team.getMapX()-3 && mouseX<team.getMapX()+3 &&
        mouseY>team.getMapY()-3 && mouseY<team.getMapY()+3) {
        fill(0);
        textSize(26);
        String num;
        if (goalsButton.isSelected()) {
          num="("+team.getGoalsFor()+")";
        } else {
          num="("+team.getApps()+")";
        }
        text(team.getTeamName() +num, mouseX, mouseY);
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
    new Button( flagW+flagH, 640, flagW*4-flagH, flagH, false, "Tournaments");
  buttons.add(tournamentsButton);

  mapButton=
    new Button( 0, height-flagH, flagW+flagH-2, flagH, false, "Map");
  buttons.add(mapButton);

  clearButton=
    new Button(width-420, 0, 100, flagH, false, "Clear");
  buttons.add(clearButton);

  summaryButton=
    new Button(width-319, 0, 170, flagH, true, "Summary");
  buttons.add(summaryButton);


  graphButton=
    new Button( width-148, 0, 150, flagH, false, "Graph");
  buttons.add(graphButton);



  appearancesButton=
    new Button(width-339, height-flagH, 190, flagH, true, "Appearances");
  buttons.add(appearancesButton);

  goalsButton=
    new Button( width-148, height-flagH, 150, flagH, false, "Goals");
  buttons.add(goalsButton);
}






//Redraw mode buttons
void redrawModeButtons() {
  nationsButton.drawButton();
  tournamentsButton.drawButton();
  mapButton.drawButton();
}


//Redraw team buttons
void redrawTeamButtons() {
  summaryButton.drawButton();
  graphButton.drawButton();
  clearButton.drawButton();
}

//Redraw map buttons
void redrawMapButtons() {
  goalsButton.drawButton();
  appearancesButton.drawButton();
}

//Draw the left panel
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
  rect(flagPanelW+flagW, 0, flagH, height-flagH*2);
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

void showMap() {
  clearDisplay();
  PImage img=loadImage("worldMap.png");
  image(img, 0, 0);
}



void drawGoals() {
  noFill();
  strokeWeight(2);
  for (Team team : teams) {

    int x=5;
    for (int goals=0; goals<team.getGoalsFor (); goals+=10) {
      stroke(team.getTeamColour1()); 
      ellipse(team.getMapX(), team.getMapY(), x, x);
      stroke(team.getTeamColour2()); 
      ellipse(team.getMapX(), team.getMapY(), x+1, x+1);
      x+=5;
    }
  }
  for (Team team : teams) {
    fill(team.getTeamColour1());
    stroke(team.getTeamColour2());
    ellipse(team.getMapX(), team.getMapY(), 5, 5);
  }
}
void drawAppearances() {
  noFill();
  strokeWeight(2);
  for (Team team : teams) {

    int x=5;
    for (int apps=1; apps<=team.getApps (); apps+=1) {
      stroke(team.getTeamColour1()); 
      ellipse(team.getMapX(), team.getMapY(), x, x);
      stroke(team.getTeamColour2()); 
      ellipse(team.getMapX(), team.getMapY(), x+1, x+1);
      x+=5;
    }
  }
  for (Team team : teams) {
    fill(team.getTeamColour1());
    stroke(team.getTeamColour2());
    ellipse(team.getMapX(), team.getMapY(), 5, 5);
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
//Display instructions
void showInstructions() {
  fill(255);
  textSize(26);
  textAlign(CENTER);
  if (nationsButton.isSelected()) {
    text("Click a flag to view stats for a country", width/2, 100);
  } else if (tournamentsButton.isSelected() ){
    text("Click a year to view stats for a tournament", width/2, 100);
  } else if(mapButton.isSelected()) {
    text("Select appearances or goals to view on map", width/2, height-30);
  }
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
  //set positions for each team
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
  int index=0;
  for (ArrayList<String> s : tournamentData)
  {
    Tournament tournament=new Tournament(s, index); 
    tournaments.add(tournament);
    index++;
  }
}

