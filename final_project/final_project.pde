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

  //if(args==null){
  //  println("no arguments provided");
  //  println("flags: -i INPUTFILENAME -o OUTPUTFILENAME -m MASKFILENAME -p PLANEMODE -n PLANENUMBER (for rgb, alpha, random)");
  //  return;
  //}

  //if(!parseArgs()){
  //  println("Parsing argument error;");
  //  return;
  //}

  println("Attempting to load image.");
  PImage img = loadImage(INPUTFILENAME);
  println("xoring now");
  ReadMask();
  RGB(MODE,img);

  //println("Attempting to create part array.");
  //int parts[];
  //if(MODE==FILE){
  //  //in file mode, the plaintext is a filename
  //  parts = fileToArray(PLAINTEXT);
  //}else{
  //  parts = messageToArray(PLAINTEXT);
  //}
  //println("Attempting to modify image.");
  //modifyImage(img, parts);
  //println("Attempting to save image.");

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
ArrayList<String> ReadMask(){
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
    return textmaskarr;
}
void XOR(PImage img){
  String line;
  for(int i = 0; i<textmaskarr.size(); i++){
    line = textmaskarr.get(i);
    for(int ind = 0; ind <line.length(); ind ++){
      if(ind < img.width & i<img.height){
        if(line.charAt(ind)=='1'){
          img.pixels[ind+i*img.width]=color(red(img.pixels[ind+i*img.width]+16), 
                                            green(img.pixels[ind+i*img.width]+16), 
                                            blue(img.pixels[ind+i*img.width]+16));
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

void modifyImage(PImage img, int[]messageArray) {
 
  if (MODE == 0) {

    for (int i = 0; i < messageArray.length; i++) {
      int red = (int) red(img.pixels[i]);
      red &= 252;
      red += messageArray[i];
      
      img.pixels[i] = color(red, green(img.pixels[i]), blue(img.pixels[i])); 
    }
    for (int i = messageArray.length; i < messageArray.length + 4; i++) {
      int red = (int) red(img.pixels[i]);
      red |= 3;
      
      img.pixels[i] = color(red, green(img.pixels[i]), blue(img.pixels[i]));
    }

  } else if (MODE == 1 || MODE == 2) {
    print(messageArray.length);
    int count = 0;
    for (int i = 0; i < img.pixels.length; i++) {
      int red = (int) red(img.pixels[i]); // can try to optimize w/ >> 16 & 0xFF
      int green = (int) green(img.pixels[i]);
      
      if (red % 4 == 0 && green % 4 == 0) {
        if (count < messageArray.length) { 
          int blue = (int) blue(img.pixels[i]);
          blue &= 252;
          blue += messageArray[count];
        
          img.pixels[i] = color(red, green, blue); 
          count++;
        }
       else {
         red |= 1;
         img.pixels[i] = color(red, green, blue(img.pixels[i]));
       }
      }
    }
  }
  img.updatePixels();
}

int [] messageToArray(String s) {
  int[] arr = new int[4* s.length()];
  for (int i = 0; i < s.length(); i++) {
    int ASCII = (int) s.charAt(i);
    for (int j = 0; j < 4; j++) {
      arr[4*(i+1)-j-1] = ASCII & 3;
      ASCII /= 4;
    }
  }
  return arr;
}

int []fileToArray(String filename) {
  byte[] bytes = loadBytes(filename);
  int[] arr = new int[4 * bytes.length];
  
  for (int i = 0; i < bytes.length; i++) {
    //println((int) bytes[i]);
    //println("1: " + (int) (bytes[i] & (128+64)));
    arr[4*i] = (int) (bytes[i] & (128+64)) / 64;
    arr[4*i+1] = (int) (bytes[i] & (32+16)) / 16;
    arr[4*i+2] = (int) (bytes[i] & (8+4)) / 4;
    arr[4*i+3] = (int) (bytes[i] & (2+1));
    //println(arr[4*i]+" "+arr[4*i+1]+" "+arr[4*i+2]+" "+arr[4*i+3]);
  }
  //print(Arrays.toString(arr));
  return arr;
}
