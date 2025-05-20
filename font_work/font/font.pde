PGraphics pg;
PFont font;
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

  PrintWriter writer = createWriter("messageMask.txt");
  
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
