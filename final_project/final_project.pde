import java.util.Arrays;
import java.util.Scanner;
import java.util.ArrayList;
import java.io.File;

final static int RED = 0;
final static int GRE = 1;
final static int BLU = 2;
final static int ALP = 3;
final static int XOR = 4;
final static int GRA = 5;
final static int FUL = 6;
final static int RAN = 7;

int PLANENO = 0;
int MODE = RED;

String MASKFILENAME = "messageMask.txt";
String INPUTFILENAME="cat.png";
String OUTPUTFILENAME="output.png";
ArrayList<String> textmaskarr= new ArrayList<String>();


void setup() {
  //size(1200, 600);

  if(args==null){
    println("no arguments provided");
    println("flags: -i INPUTFILENAME -o OUTPUTFILENAME -m MASKFILENAME -p PLANEMODE -n PLANENUMBER (for rgb, alpha, random)");
    return;
  }

  if(!parseArgs()){
    println("Parsing argument error;");
    return;
  }
  println("Attempting to load image.");
  PImage img = loadImage(INPUTFILENAME);
  println("reading mask file");
  ReadMask();
  println("completing task");  
  if(MODE == XOR){
    XOR(img);
  }
  else if (MODE==0 | MODE == 1| MODE == 2){
    RGB(MODE,img);
  }
  img.save(OUTPUTFILENAME);
  println("done and saved");

}

boolean parseArgs(){
  if (args != null) {
    for (int i = 0; i < args.length; i++){
      if(args[i].equals("-i")){
        try{
          INPUTFILENAME=args[i+1];
        }catch(Exception e){
          println("-i requires filename as next argument");
          return false;
        }
      }
      if(args[i].equals("-m")){
        try{
          MASKFILENAME=args[i+1];
        }catch(Exception e){
          println("-m requires filename as next argument");
          return false;
        }
      }
      if(args[i].equals("-o")){
        if(args[i+1]!=null){
          OUTPUTFILENAME=args[i+1];
        }else{
          println("-o requires filename as next argument");
          return false;
        }
      }
      if(args[i].equals("-p")){
        if(args[i+1]!=null){
          String modeString=args[i+1];
          String[] modes = {"red", "green", "blue", "alpha", "xor", "gray", "full", "random"};
          for(int ind = 0; ind <modes.length; ind++){
            if(modeString.equalsIgnoreCase(modes[ind])){
              MODE=ind;
            }
          }
        }else{
          println("-p requires plane number as next argument");
          return false;
        }
      }
      if(args[i].equals("-n")){
        if(args[i+1]!=null){
          PLANENO=Integer.valueOf(args[i+1]);
        }else{
          println("-n requires plane number as next argument");
          return false;
        }
      }
    }
  }
  return true;
}
void ReadMask(){
  File maskFile = new File(MASKFILENAME);
  try{
  Scanner readMask = new Scanner(maskFile);
    while(readMask.hasNextLine()){
      textmaskarr.add(readMask.nextLine());
    }
  readMask.close();
  }catch(Exception e){
    e.printStackTrace();
  }
}
void XOR(PImage img){
  String line;
  for(int i = 0; i<textmaskarr.size(); i++){
    line = textmaskarr.get(i);
    for(int ind = 0; ind <line.length(); ind ++){
      if(ind < img.width & i<img.height){
        if(line.charAt(ind)=='1'){
          img.pixels[ind+i*img.width]=color(red(1), green(1), blue(1));
        }
        else{
          img.pixels[ind+i*img.width]=color(0,0,0);
        }
      }
    }
  }
}

void RGB(int col, PImage img){ // col 0, 1, 2 for R, G, B
  String line;
  int mask = 256 - (int) pow(2, PLANENO);
  for(int i = 0; i<textmaskarr.size(); i++){
    line = textmaskarr.get(i);
    for(int ind = 0; ind <line.length(); ind ++){
      if(ind < img.width & i<img.height){
        if(line.charAt(ind)=='1'){ // make last 0
          if(col == 0){
            int red = (int) red(img.pixels[ind+i*img.width]);
            red = red&mask+1;
            img.pixels[ind+i*img.width]=color(red, green(img.pixels[ind+i*img.width]), blue(img.pixels[ind+i*img.width]));
          }  
          else if (col == 1){
            int green = (int) green(img.pixels[ind+i*img.width]);
            green = green&mask+1;          
            img.pixels[ind+i*img.width]=color(red(img.pixels[ind+i*img.width]), green, blue(img.pixels[ind+i*img.width]));
          }
          else if (col == 2){
            int blue = (int) blue(img.pixels[ind+i*img.width]);
            blue = blue&mask+1;    
            img.pixels[ind+i*img.width]=color(red(img.pixels[ind+i*img.width]), green(img.pixels[ind+i*img.width]), blue);
          }
        }
        else{ // make last 1
          if(col == 0){
            int red = (int) red(img.pixels[ind+i*img.width]);
            red &= mask; 
            img.pixels[ind+i*img.width]=color(red, green(img.pixels[ind+i*img.width]), blue(img.pixels[ind+i*img.width]));
          }  
          else if (col ==1){
            int green = (int) green(img.pixels[ind+i*img.width]);
            green = green&mask;      
            img.pixels[ind+i*img.width]=color(red(img.pixels[ind+i*img.width]), green, blue(img.pixels[ind+i*img.width]));
          }
          else if (col ==2){
            int blue = (int) blue(img.pixels[ind+i*img.width]);
            blue = blue&mask;    
            img.pixels[ind+i*img.width]=color(red(img.pixels[ind+i*img.width]), green(img.pixels[ind+i*img.width]), blue);
          }
        }
      }
    }
  }
}
