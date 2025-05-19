import java.util.Arrays;
final static int GREEDY = 0;
final static int SELECTIVE = 1;
final static int FILE = 2;
final static int RED = 0;
final static int GRE = 1;
final static int BLU = 2;
final static int ALP = 3;
final static int XOR = 4;
final static int GRA = 5;
final static int FUL = 6;
final static int RAN = 7;

//default settings
int MODE = GREEDY;
int TYPE = RED;
int PLANE = 0;

String PLAINTEXT = "This";
String DISPLAYMODE = "false";
String INPUTFILENAME="input.png";
String OUTPUTFILENAME="encoded.png";
//the parseArgs function will set these to non-defaults

void draw(){
  if(DISPLAYMODE.equalsIgnoreCase("false")){
    exit();
    return;
  }
}

void setup() {
  size(1200, 600);
   
  //String s = "This";
  //int[] arr = messageToArray(s);
  //print(Arrays.toString(arr));

  if(args==null){
    println("no arguments provided");
    println("flags: -i INPUTFILENAME -o OUTPUTFILENAME -p PLAINTEXT (text or filename depending on mode) -d DISPLAYMODE (true/false) -m MODE (GREEDY/SELECTIVE/FILE)");
    return;
  }

  if(!parseArgs()){
    println("Parsing argument error;");
    return;
  }

  println("Attempting to load image.");
  PImage img = loadImage(INPUTFILENAME);

  //2. Write the MESSAGETOARRAY method
  //convert the string into an array of ints in the range 0-3
  println("Attempting to create part array.");
  int parts[];
  if(MODE==FILE){
    //in file mode, the plaintext is a filename
    parts = fileToArray(PLAINTEXT);
  }else{
    parts = messageToArray(PLAINTEXT);
  }

  //3. Write the MODIFY method.
  println("Attempting to modify image.");
  modifyImage(img, parts);

  //save the modified image to disk.
  println("Attempting to save image.");
  img.save(OUTPUTFILENAME);

  if(!DISPLAYMODE.equalsIgnoreCase("FALSE")){
    println("Displaying image.");
    image(img,0,0);
  }
}

boolean parseArgs(){
  if (args != null) {
    for (int i = 0; i < args.length; i++){
      if(args[i].equals("-i")){
        try{
          INPUTFILENAME=args[i+1];
        }catch(Exception e){
          println("-o requires filename as next argument");
          return false;
        }
      }

      if(args[i].equals("-p")){
        try{
          PLAINTEXT=args[i+1];
        }catch(Exception e){
          println("-p requires quoted plaintext as next argument");
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

      if(args[i].equals("-d")){
        if(args[i+1]!=null){
          DISPLAYMODE=args[i+1];
        }else{
          println("-d requires true/false as next argument");
          return false;
        }
      }

      if(args[i].equals("-m")){
        if(args[i+1]!=null){
          String modeString=args[i+1];
          if(modeString.equalsIgnoreCase("greedy")){
            MODE = GREEDY;
          }else if(modeString.equalsIgnoreCase("selective")){
            MODE = SELECTIVE;
          }else if(modeString.equalsIgnoreCase("file")){
            MODE = FILE;
          }else{
            println("Invalid mode choice, defaulting to Greedy");
            MODE = GREEDY;
          }

        }else{
          println("-m requires mode as next argument");
          return false;
        }
      }
    }
  }
  return true;
}



void modifyImage(PImage img, int[]messageArray) {
  //load the image into an array of pixels.
  //img.loadPixels();
  //You can use img.pixels[index] to access this array

  if (MODE == GREEDY) {
    //GREEDY mode : use each pixel in order until you are done with the message.
    //Loop over the pixels in order. For each pixel:
    //-Take the next array value and write it to the red channel of the pixel.
    //-When there are no more letters, write a terminating character.
    //This means 4 pixels will store 1 char value from your String.
    //The terminating character is the value 255.
    //Note: (255 is 11111111b and 11b is just 3, make the last
    //four pixels store {3,3,3,3}
    
    // Loop through every pixel column
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

  } else if (MODE == SELECTIVE || MODE == FILE) {
    //SELECTIVE MODE: only use a few pixels based on some criteria
    //when the red and green end in 00, modify the last 2 bits of blue with the bit value.
    //e.g.   if the pixel is r = 1100 ,g=1100 and blue=11xy, replace the xy in the blue with the next message value.
    //To terminate the message:
    //when no more message is left to encode, change all the remaining red values that end in 00 to 01.
    //This means the number of pixels that qualify for decoding will be a multiple of 4.
    
    // Loop through every pixel
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

  //write the pixel array back to the image.
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
