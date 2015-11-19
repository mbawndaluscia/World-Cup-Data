class Flag{
  String fileName;
  PImage img;
  Flag(String file){
    fileName=file;
    img=loadImage(fileName);
  }
  
  PImage getImage(){
   return img; 
  }
  String getFileName(){
    return fileName;
  }
}
