class Tournament {
  //Fields
  int index;
  String year;
  String host;
  String winner;
  String runnerUp;
  int entrants;
  int games;
  int goals;
  float goalsPerGame;
  Flag flag;
  int flagX;
  int flagY;  

  String[] stringDetails;
  String[] summaryLabels;

  int borderX=400;
  int borderY=0;

  //Constructor
  Tournament(ArrayList<String> data, int ind) {
    index=ind;
    year=data.get(0);
    host=data.get(1);
    winner=data.get(2);
    runnerUp=data.get(3);
    entrants=parseInt(data.get(4));
    games=parseInt(data.get(5));
    goals=parseInt(data.get(6));
    goalsPerGame=parseFloat(data.get(7));

    //Set image path for flag
    String imgPath="flag-of-" + host + ".png";
    setFlag(imgPath);

    //populate arrays for printing summary
    stringDetails=new String[] {
      data.get(2), data.get(3), data.get(4), 
      data.get(5), data.get(6), data.get(7)
      };
    summaryLabels=new String[] {
      "Winner:", "Runner Up:", "Entrants:", 
      "Total Games:", "Total Goals:", "Goals Per Game:"
    };
  }

  //Set/get flag methods

  void setFlag(String fileName) {
    flag=new Flag(fileName);
  }

  PImage getFlag() {
    return flag.getImage();
  }

  int getFlagX() {
    int xloc=flagX;
    return xloc;
  }
  int getFlagY() {
    int yloc=flagY;
    return yloc;
  }

  //draw the flag
  void drawFlag(int x, int y) {
    image(flag.getImage(), x, y);
    flagX=x;
    flagY=y;
  }

  //Print tournament header 
  void displayHeader() {
    drawFlag(borderX, borderY);
    fill(255);
    textAlign(LEFT);
    textSize(40);
    text(host+" "+year, borderX+75, borderY+38);
  }

  //Print tournament summary
  void displayDetails() {

    displayHeader();
    textSize(24);

    textAlign(LEFT);


    drawFlag(borderX, borderY);

    int y=borderY+80;
    for (int i=0; i<summaryLabels.length; i++) {
      textAlign(LEFT);

      text(summaryLabels[i], borderX, y);
      textAlign(RIGHT);

      text(stringDetails[i], borderX+455, y);
      y+=48;
    }
  }

  void displayTeamPositions(ArrayList<Team> teams ) {
    ArrayList<Team> participants=new ArrayList<Team>();
    for (Team team : teams) {
      if (int(team.getPositions().get(index))<33) {
        participants.add(team);
      }
    }
    textSize(16);
    textAlign(LEFT);
    int bordX;
    if (participants.size()>16) {
      bordX=width-430;
    } else {
      bordX=width-240;
    }
    int bordY=30;

    for (Team team : participants) {
      int pos=int(team.getPositions().get(index));
      int y=bordY+(pos-1)*42;
      int x=bordX;
      if (pos>16) {
        x+=220;
        y=bordY+(pos-17)*42;
      }
      text(pos + ": " + team.getTeamName(), x, y);
      team.drawFlag(x+142,y-26);
    }
  }

  //get methods for data needed elsewhere
  String getYear() {
    return year;
  }

  int getEntrants() {
    return entrants;
  }
}

