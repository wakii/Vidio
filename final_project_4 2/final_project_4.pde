// Pythagoras said "the world is consisted of numbers."

import processing.video.*;
Capture cam;
int numPixels;

PixelInf[] pix = new PixelInf[0];
PixelInf prevPix;
Code prevCode;

void setup() {
  size(640, 480);
  cam = new Capture(this, width, height);
  cam.start();
  numPixels = (cam.width * cam.height)/100;

  loadPixels();
  colorMode(HSB, 0.5, 24, 10);

  time = millis();
  synthesize();

  prevPix = new PixelInf(0, 0, 0);
  prevCode = new Code("C4", "E4", "G4");
}

void draw() {
  if (cam.available() == true) {
    cam.read();
    cam.loadPixels();
  }
  image(cam, 0, 0, width, height);


  //make a pixel array that class has a each pixel information 
  for ( int i = 0; i<numPixels; i++) {
    float h = hue(cam.pixels[i]);
    float b = brightness(cam.pixels[i]);
    float s = saturation(cam.pixels[i]);


    // saturation difference changes the music speed
    PixelInf prevP   = prevPix;
    float diffP = (abs(prevP.getSaturation() - s))*100;
    wait = (int)map(diffP, 0, 100, 3000, 1000);


    PixelInf p = new PixelInf(h, s, b);
    pix = (PixelInf[])append(pix, p);

    prevPix = p;
  }

  float averHue = 0;
  float averSat = 0;
  float averBri = 0;

  // get  average information of all pixel.
  for ( int i = 0; i<pix.length; i++) {
    averHue += pix[i].getHue();
    averBri += pix[i].getBrightness();
    averSat += pix[i].getSaturation();
  }
  averHue/=numPixels;
  averSat/=numPixels;
  averBri/=numPixels;


  //initialize the pixel information of each frame.
  // it means we collect one frame for a specific period of frame.
  pix = new PixelInf[0];

  // brightness changes octave
  float briVal = map(averBri, 0, 24, 0.3, 0.7);
  int hueVal = (int)map(averHue, 0, briVal, 0, 28);

  Code tempCode = codes[hueVal];

  if (wait<1000) {
    wait = 1000;
  }
  // make delays between the codes and the delay time is controlled by the frame saturation differences
  if (millis() - time >= wait) {
    time = millis();
    // next music code tends to be differienced with previous code.
    if (tempCode == prevCode) {
      hueVal += round(random(-2.5, 2.5));
      if ((hueVal>0)&&(hueVal<28)) {
        tempCode = codes[hueVal];
      }
    }

    println(briVal + "        " +wait+"       " + tempCode.getNote1() + "     " + tempCode.getNote2() + "      " + tempCode.getNote3());

    out.playNote(0, 2, tempCode.getNote1());
    out.playNote(0, 2, tempCode.getNote2());
    out.playNote(0, 2, tempCode.getNote3());
    out.playNote( 0, 0.7, new SineInstrument( Frequency.ofPitch( tempCode.getNote1() ).asHz() ) );
    out.playNote( 1, 0.7, new SineInstrument( Frequency.ofPitch( tempCode.getNote2() ).asHz() ) );
    out.playNote( 2, 0.7, new SineInstrument( Frequency.ofPitch( tempCode.getNote3() ).asHz() ) );
  }
  prevCode = tempCode;
}

