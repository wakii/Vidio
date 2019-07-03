class PixelInf {
  float hue;
  float brightness;
  float saturation;

  PixelInf(float h, float s, float b) {
    hue = h;
    brightness = b;
    saturation = s;
  }

  float getHue() {
    return hue;
  }
  float getBrightness() {
    return brightness;
  }
  float  getSaturation() {
    return saturation;
  }
}



class Code {

  String playingNote1, playingNote2, playingNote3;

  Code(String note1, String note2, String note3) {
    playingNote1 = note1;
    playingNote2 = note2;
    playingNote3 = note3;
  }
  String getNote1() {
    return playingNote1;
  }
  String getNote2() {
    return playingNote2;
  }
  String getNote3() {
    return playingNote3;
  }


  void setNote(String note1, String note2, String note3) {
    playingNote1 = note1;
    playingNote2 = note2;
    playingNote3 = note3;
  }
}

