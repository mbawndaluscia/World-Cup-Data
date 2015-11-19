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
  Flag flag;
  
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
    String imgPath="flag-of-" + teamName+".png";
    setFlag(imgPath);
  }


  //Set/get flag methods
  
  void setFlag(String fileName){
    flag=new Flag(fileName);
  }
  
  PImage getFlag(){
    return flag.getImage();
  }
  
  void drawFlag(int x, int y){
    image(flag.getImage(),x,y);
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
  float getPointsPerGame(){
    return pointsPerGame;
  }
  
  String getBestFinish(){
    return bestFinish;
  }
  String getContinent(){
    return continent;
  }
  
  String getAllDetails(){
   String details=rank +" "+teamName+" "+apps+" "+bestFinish;
     return details;             
  }
  
}

