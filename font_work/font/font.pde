PGraphics pg;
PFont font;
String INPUTFILENAME="message.png";
String OUTPUTFILENAME="messageMask.txt";
String message = "SECRET";
int maskSize = 1;

void setup() {
  size(300, 100); 
  font = createFont("Qaroxe-zrllw.otf", 48);
  
  int paddingX = 10;
  int paddingY = 10;

  textFont(font);
  textSize(48);
  
  float tw = textWidth(message);
  float th = textAscent() + textDescent();

  pg = createGraphics(width, height);
  pg.beginDraw();
  pg.background(255);
  pg.fill(0);
  pg.textFont(font);
  pg.textSize(48);
  pg.text(message, paddingX, 2* paddingY + textAscent());
  pg.endDraw();

  pg.loadPixels();

  PrintWriter writer = createWriter(OUTPUTFILENAME);
  
  for (int y = 2 * paddingY; y < paddingY + th; y+= maskSize) {
    for (int x = paddingX; x < paddingX + tw; x+= maskSize) {
      if (x < 0 || y < 0 || x >= pg.width || y >= pg.height) continue;  // bounds check
      int i = x + y * pg.width;
      color c = pg.pixels[i];
      int brightness = (int) brightness(c);
      writer.print(brightness < 128 ? '1' : '0');
    }
    writer.println();
  }

  writer.flush();
  writer.close();

  image(pg, 0, 0);
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
