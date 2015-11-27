class Flag{
  //fields
  String fileName;
  PImage img;
  
  //constructor
  Flag(String file){
    fileName=file;
    img=loadImage(fileName);
  }

//get image or fileName 
  PImage getImage(){
   return img; 
  }
  String getFileName(){
    return fileName;
  }
}
