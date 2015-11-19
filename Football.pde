//Arraylist of Team objects
ArrayList<Team> teams = new ArrayList<Team>(); 

//2d arraylist of team data
ArrayList<ArrayList<String>> teamData = new ArrayList<ArrayList<String>>();

void setup() {
  size(476, 440);
  background(0);
  stroke(0);
  loadData();
}
void draw() {
  int rows=0;
  int cols=0;

  int flagW=68;
  int flagH=40;



  for (Team t : teams) {
    image( t.getFlag(), cols, rows);
    if (cols<width-flagW) {
      cols+=flagW;
    } else {
      cols=0;
      rows+=flagH;
    }
  }
  strokeWeight(2);
  for(int i =0; i<width; i+=flagW-1){
     line(i,0,i,height);
  }
  for(int i =0; i<height; i+=flagH-1){
     line(0,i,width,i);
  }
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

