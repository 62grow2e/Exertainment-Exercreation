import codeanticode.gsvideo.*;
import gifAnimation.*;
import java.util.Date;

GSCapture video;
GifMaker gifExport;

boolean isCapturing = false;
GifMaker[] gifAnimes = new GifMaker[3];
PImage img;
float img_x, img_y;
int mode = 0;
void setup() {
  size(640, 480);

  video = new GSCapture(this, width, height);
  video.start();

  

  img = loadImage("neko.png");
}

void draw() {
  println(video.available());
  println(img_x+" , "+img_y);
  println("isCapturing : "+isCapturing);
  if (video.available()) {
    video.read();
    image(video, 0, 0, width, height);
  }
  if (isCapturing) {
    image(img, img_x, img_y, 200, 130);
    gifExport.addFrame();
    println("captured");
    if (mode %2 == 0) {
      
    }
    else if (mode % 2 == 1) {
      img_x -= 150;
      if (img_x <= -500) {
        isCapturing = false;
        gifAnimes[2] = gifAnimes[1];
        gifAnimes[1] = gifAnimes[0];
        gifAnimes[0] = gifExport; 
        gifExport.finish();
        frameRate(60);
      }
    }
  }
}

int startMillis;
void keyPressed() {
  switch(key) {
  case ENTER:
    if (!isCapturing) {
      startMillis = millis();
      gifExport = new GifMaker(this, "img"+String.format("%1$tY%1$tm%1$td-%1$tH%1$tM%1$tS%1$tL", new Date())+".gif");
      gifExport.setRepeat(0);
      frameRate(60);
      img_x = width+10;
      img_y = 280;
      gifExport.setDelay(60);
      gifExport.addFrame();

      isCapturing = true;
    }
    else if (isCapturing) {
      isCapturing = false;
      gifAnimes[2] = gifAnimes[1];
      gifAnimes[1] = gifAnimes[0];
      gifAnimes[0] = gifExport; 
      gifExport.finish();
      frameRate(60);
    }
    break;
  case 'm':
    mode++;
    break;
  }
}

