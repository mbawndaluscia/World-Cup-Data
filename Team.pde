class Team {
  //Fields
  int rank;
  String teamName;
  int apps;
  int played;
  int wins;
  int draws;
  int losses;
  int goalsFor;
  int goalsAgainst;
  int goalDifference;
  int points;
  float pointsPerGame;
  String bestFinish;
  String continent;
  ArrayList<String> positions;
  Flag flag;
  int flagX;
  int flagY;
  int mapX;
  int mapY;
  String[] stringDetails;
  String[] summaryLabels;
  color teamColour1;
  color teamColour2;
  int borderX=400;
  int borderY=0;

  //Constructor
  Team(ArrayList<String> data) {
    rank=parseInt(data.get(0));
    teamName=data.get(1);
    apps=parseInt(data.get(2));
    played=parseInt(data.get(3));
    wins=parseInt(data.get(4));
    draws=parseInt(data.get(5));
    losses=parseInt(data.get(6));
    goalsFor=parseInt(data.get(7));
    goalsAgainst=parseInt(data.get(8));
    goalDifference=parseInt(data.get(9));
    points=parseInt(data.get(10));
    pointsPerGame=parseFloat(data.get(11));
    bestFinish=data.get(12);
    continent=data.get(13);
    teamColour1= unhex(data.get(14));
    teamColour2= unhex(data.get(15));
    mapX=parseInt(data.get(16));
    mapY=parseInt(data.get(17));


    String imgPath="flag-of-" + teamName + ".png";
    setFlag(imgPath);


    //populate arrays for printing summary
    stringDetails=new String[] {
      data.get(13), data.get(0), data.get(2), data.get(3), 
      data.get(4), data.get(5), data.get(6), data.get(7), 
      data.get(8), data.get(9), data.get(10), data.get(11), 
      data.get(12)
      };
    summaryLabels=new String[] {
      "Continent:", "Overall Rank:", "Finals Appearances:", "Total Games Played:", 
      "Games Won:", "Games Drawn:", "Games Lost:", "Goals Scored:", "Goals Conceded:", 
      "Goal Difference:", "Total Points:", "Points Per Game:", "Best Finish:"
    };
  }


  //Set/get flag methods

  void setFlag(String fileName) {
    flag=new Flag(fileName);
  }

  PImage getFlag() {
    return flag.getImage();
  }

  void drawFlag(int x, int y) {
    image(flag.getImage(), x, y);
    flagX=x;
    flagY=y;
  }

  //Populate team final positions arraylist
  void setPositions(ArrayList<String> pos) {
    positions=pos;
  }



  //Get methods

    int getRank() {
    return rank;
  }
  String getTeamName() {
    return teamName;
  }

  int getApps() {
    return apps;
  }
  int getPlayed() {
    return played;
  }
  int getWins() {
    return wins;
  }
  int getDraws() {
    return draws;
  }
  int getLosses() {
    return losses;
  }
  int getGoalsFor() {
    return goalsFor;
  }
  int getGoalsAgainst() {
    return goalsAgainst;
  }
  int getGoalsDifference() {
    return goalDifference;
  }
  int getPoints() {
    return points;
  }
  float getPointsPerGame() {
    return pointsPerGame;
  }

  String getBestFinish() {
    return bestFinish;
  }
  String getContinent() {
    return continent;
  }

  int getFlagX() {
    int xloc=flagX;
    return xloc;
  }
  int getFlagY() {
    int yloc=flagY;
    return yloc;
  }

  color getTeamColour1() {
    return teamColour1;
  }

  color getTeamColour2() {
    return teamColour2;
  }

  ArrayList<String> getPositions() {
    return positions;
  }

  int getMapX() {
    return mapX;
  }

  int getMapY() {
    return mapY;
  }


  //Print team header
  void displayHeader() {
    noStroke(); 
    fill(65); 
    rect(borderX, borderY, 476, 48);
    drawFlag(borderX, borderY);
    fill(teamColour1);
    textAlign(LEFT);
    textSize(40);
    text(teamName, borderX+75, borderY+38);
  }

  //Print team summary
  void displayDetails() {
    displayHeader();
    textSize(28);
    int y=borderY+80;
    for (int i=0; i<summaryLabels.length; i++) {
      textAlign(LEFT);
      fill(teamColour2);
      text(summaryLabels[i], borderX, y);
      textAlign(RIGHT);
      fill(teamColour1);
      text(stringDetails[i], borderX+455, y);
      y+=48;
    }
  }
  //draw full trend graph 
  void drawTrendGraph(ArrayList<String> positionLabels, ArrayList<String> yearLabels, ArrayList<Tournament> trn) {
    displayHeader();
    TrendGraph tg=new TrendGraph(this, yearLabels, positionLabels, trn);
    tg.drawGraph();
  }

  //draw trend line only
  void drawTrendLine(ArrayList<String> positionLabels, ArrayList<String> yearLabels, ArrayList<Tournament> trn) {
    TrendGraph tg=new TrendGraph(this, yearLabels, positionLabels, trn);
    tg.drawTrendLine();
  }

  void printGraphInstructions() {
    textSize(13);
    text("Click more flags to compare teams", width-60, 45, 55, 120);
  }
}

