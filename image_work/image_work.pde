String INPUTFILENAME="cat.png";
String OUTPUTFILENAME="messaegMask.txt";
int threshold = 128;
PImage img;
PImage base;
int increment = 1;
//the parseArgs function will set these to non-defaults

void setup() {
  size(1200, 600);
  
  if(args==null){
    println("no arguments provided");
    println("flags: -i INPUTFILENAME -o OUTPUTFILENAME");
    return;
  }

  if(!parseArgs()){
    println("Parsing argument error;");
    return;
  }
  
  println("Attempting to load image.");
  img = loadImage(INPUTFILENAME);
  base = loadImage(INPUTFILENAME);
  blackWhiteImage(img);

  println("Displaying image.");
  image(img,0,0);
  
}

boolean parseArgs() {
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
      if(args[i].equals("-o")){
        if(args[i+1]!=null){
          OUTPUTFILENAME=args[i+1];
        }else{
          println("-o requires filename as next argument");
          return false;
        }
      }
    }
  }
  return true;
}
void save() {
    
  //save the modified image to disk.
  println("Attempting to save image.");
  img.save(OUTPUTFILENAME);
  
  PrintWriter writer = createWriter(OUTPUTFILENAME);
  for (int i = 0; i < img.height; i++) {
    for (int j = 0; j < img.width; j++) {
      int px = j + i * img.width;
      color c = img.pixels[px];
      
      writer.print(c == color(0,0,0) ? '0' : '1');
    }
    writer.println();
  }
  
  writer.flush();
  writer.close();
  
  println("Saved.");
}
void blackWhiteImage(PImage img) {
  for (int i = 0 ; i < img.pixels.length ; i++) {
    int red = (int) red(base.pixels[i]);
    int blue = (int) blue(base.pixels[i]);
    int green = (int) green(base.pixels[i]);
    if ((red + blue + green) / 3 > threshold) {
      img.pixels[i] = color(255,255,255);
    }
    else {
      img.pixels[i] = color(0,0,0);
    }
  }
  
  img.updatePixels();
  image(img,0,0);
}

void keyPressed() {
  //print("abc");
  if (key == CODED) {
    if (keyCode == RIGHT) {
    threshold-=increment;
    }
    if (keyCode == LEFT) {
      threshold+=increment;
    }
    if (keyCode == SHIFT) {
      increment = 5;
      //print("asd");
    }

  }
  if (key == 's') {
    save();
  }
  
  if (threshold < 0) threshold = -1;
  if (threshold > 255) threshold = 256;
  
  print(key);
  //print(MODE);
  blackWhiteImage(img);
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == SHIFT) {
      increment = 1;
    }
  }
}
void draw() {
  return;
}
