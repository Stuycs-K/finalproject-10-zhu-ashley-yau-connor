String INPUTFILENAME="cat.png";
String OUTPUTFILENAME="encoded.png";
//the parseArgs function will set these to non-defaults

void draw(){
  print("abc");
}

void setup() {
  size(1200, 600);

  println("Attempting to load image.");
  PImage img = loadImage(INPUTFILENAME);
  blackWhiteImage(img);
  
  //save the modified image to disk.
  println("Attempting to save image.");
  img.save(OUTPUTFILENAME);
  println("Displaying image.");
  image(img,0,0);
  
}

void blackWhiteImage(PImage img) {
  for (int i = 0 ; i < img.pixels.length ; i++) {
    int red = (int) red(img.pixels[i]);
    int blue = (int) blue(img.pixels[i]);
    int green = (int) green(img.pixels[i]);
    if ((red + blue + green) / 3 > 128) {
      img.pixels[i] = color(255,255,255);
    }
    else {
      img.pixels[i] = color(0,0,0);
    }
  }
  
  img.updatePixels();
}
