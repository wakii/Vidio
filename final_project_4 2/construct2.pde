import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput out;

int time;
int wait;

Code[] codes = new Code[28];



void synthesize() {
  minim = new Minim(this);
  out = minim.getLineOut(Minim.STEREO, 512);
  for (int i=0; i< codes.length; i++) {
    codes[0] = new Code("C4", "E4", "G4");
    codes[1] = new Code("D4", "F#4", "A4");
    codes[2] = new Code("E4", "G#4", "B4");
    codes[3] = new Code("F4", "A4", "C5");
    codes[4] = new Code("G4", "B4", "D5");
    codes[5] = new Code("A4", "C#5", "E5");
    codes[6] = new Code("B4", "D#5", "F#5");
    codes[7] = new Code("C5", "E5", "G5");
    codes[8] = new Code("D5", "F#5", "A5");
    codes[9] = new Code("E5", "G#5", "B5");
    codes[10] = new Code("F5", "A5", "C6");
    codes[11] = new Code("G5", "B5", "D6");
    codes[12] = new Code("A5", "C#6", "E6");
    codes[13] = new Code("B5", "D#6", "F#6");
    codes[14] = new Code("C5", "E5", "G5");
    codes[15] = new Code("D5", "F#5", "A5");
    codes[16] = new Code("E5", "G#5", "B5");
    codes[17] = new Code("F5", "A5", "C6");
    codes[18] = new Code("G5", "B5", "D6");
    codes[19] = new Code("A5", "C#6", "E6");
    codes[20] = new Code("B5", "D#6", "F#6");
    codes[21] = new Code("C6", "E6", "G6");
    codes[22] = new Code("D6", "F#6", "A6");
    codes[23] = new Code("E6", "G#6", "B6");
    codes[24] = new Code("F6", "A6", "C7");
    codes[25] = new Code("G6", "B6", "D7");
    codes[26] = new Code("A6", "C#7", "E7");
    codes[27] = new Code("B6", "D#7", "F#7");
  }
}


class SineInstrument implements Instrument
{
  Oscil wave;
  Line  ampEnv;
  
  SineInstrument( float frequency )
  {
    // make a sine wave oscillator
    // the amplitude is zero because 
    // we are going to patch a Line to it anyway
    wave   = new Oscil( frequency, 0, Waves.SINE );
    ampEnv = new Line();
    ampEnv.patch( wave.amplitude );
  }
  
  // this is called by the sequencer when this instrument
  // should start making sound. the duration is expressed in seconds.
  void noteOn( float duration )
  {
    // start the amplitude envelope
    ampEnv.activate( duration, 0.5f, 0 );
    // attach the oscil to the output so it makes sound
    wave.patch( out );
  }
  
  // this is called by the sequencer when the instrument should
  // stop making sound
  void noteOff()
  {
    wave.unpatch( out );
  }
}
