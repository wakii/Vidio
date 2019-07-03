import tactu5.*;
import tactu5.Tactu5SimpleSequencer;


// creating an instance of Tactu5
Tactu5 tactu5;

// creating an aggregator instance
Aggregator aggregator;

void setup() {
       
  
       Tactu5Utilities tactu5utilities = new Tactu5Utilities();
  
       // define various frequencies
  
        float freqA = 440.000;
        float freqC = tactu5utilities.noteToFreq ( T5Notes.C, 4 );
        float freqE = tactu5utilities.noteToFreq ( T5Notes.E, 4 );
        float freqG = tactu5utilities.noteToFreq ( T5Notes.G, 3 );

        // declaring some notes
        
        Note noteA = new Note(freqA,200,1,1,100,false);
        Note noteC = new Note(freqC,200,1,1,100,false);
        Note noteE = new Note(freqE,200,1,1,100,false);
        Note noteG = new Note(freqG,200,1,1,100,false);
        
        // declaring a sequence
        
        Sequence sequence = new Sequence();
        
        // add notes to sequence to create an arpeggio
        
        sequence.addNote(noteA);
        sequence.addNote(noteC);
        sequence.addNote(noteE);
        sequence.addNote(noteG);
        
        aggregator = new Aggregator();
        
        //add the sequence to aggregator
        
        aggregator.addSequence(sequence);
        
        // initializing and feed internal sequencer, boolean value inidicate if it will loop
        
        tactu5 = new Tactu5(this,aggregator.getScore(),true);
       
        // start sequencer
        tactu5.start();
  
  
  }
  
void draw() {
    
    // do something
    
}

void noteReceiver(Note n){
  
  // send data to a synth
  
 println(n.getFrequency());
 println(n.getDuration());
 println(n.getSustain());
 println(n.getPan());
  

  
  
  
}
void stop() {
  
  // eliminate Tactu5 sequencer
  tactu5.closeSequencer();
  super.stop();
  
}
