 String INPUTFILENAME="cat.png";
String OUTPUTFILENAME="output.png";
int threshold = 128;
PImage img;
PImage base;
int increment = 1;
//the parseArgs function will set these to non-defaults

void setup() {
  size(1200, 600);

  println("Attempting to load image.");
  img = loadImage(INPUTFILENAME);
  base = loadImage(INPUTFILENAME);
  blackWhiteImage(img);

  println("Displaying image.");
  image(img,0,0);
  
}

void save() {
    
  //save the modified image to disk.
  println("Attempting to save image.");
  img.save(OUTPUTFILENAME);
  
  PrintWriter writer = createWriter("messageMask.txt");
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
