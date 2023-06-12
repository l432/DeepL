#include "pitches.h"
#include  <Narcoleptic.h>

// notes in the melody:
int melody[] = {
  NOTE_C4, NOTE_G3, NOTE_G3, NOTE_A3, NOTE_G3, 0, NOTE_B3, NOTE_C4
};

// note durations: 4 = quarter note, 8 = eighth note, etc.:
int noteDurations[] = {
  4, 8, 8, 4, 4, 4, 4, 4
};

const byte TonePin=8;
const byte AnalogReadPin=0;
const int PorogValue = 200;

void Melody(byte Pin);

void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
}

// the loop routine runs over and over again forever:
void loop() {
 if (analogRead(AnalogReadPin)>PorogValue)
//  Serial.println(analogRead(AnalogReadPin));
  {Melody(TonePin);}
  Narcoleptic.delay(100);
}

void Melody(byte Pin){
    for (int thisNote = 0; thisNote < 8; thisNote++) {

    int noteDuration = 1000 / noteDurations[thisNote];
    tone(Pin, melody[thisNote], noteDuration);

    int pauseBetweenNotes = noteDuration * 1.30;
    delay(pauseBetweenNotes);
    // stop the tone playing:
    noTone(Pin);
  }
}

