#include <fix_fft.h>
#include <Narcoleptic.h>

//#include <avr/delay.h>
//#include <TimerOne.h>


//#define F_CPU 16000000UL;

const byte analogPin = A1;
const byte AlarmPin = 13;
// const long GAIN = 10;


const byte PS_128 = (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0);
const byte PS_16 = (1 << ADPS2);


const byte MeasureDelay = 40;
//time between measuring, us
const uint16_t Np = 256;
volatile uint16_t myByte[Np];
volatile int ArrayIndex;
uint16_t MaxMeasureValue;
uint16_t MinMeasureValue;
int8_t im[Np];
int8_t data[Np];
const byte ThresholdValue = 10;

const boolean DraftMode = false;
// const boolean DraftMode = true;

unsigned long myTimer;

void setup() {
  // initialize serial communication at 9600 bits per second:
  ADCSRA &= -PS_128;
  ADCSRA |= PS_16;
  Serial.begin(9600);
  pinMode(AlarmPin, OUTPUT);

  cli();
  TCCR1B = 0;
  TCCR1A = 0;
  OCR1A = MeasureDelay / 1e6 * F_CPU - 1;
  TIMSK1 |= (1 << OCIE1A);
  sei();
}

// the loop routine runs over and over again forever:
void loop() {
  //  myTimer = millis();
  MeasureSignal();
  MaxMinInMeasedSignal();
  // showMeasurement();
  sampleWindowFull();

  fix_fft(data, im, 8, 0);
  updateData();


  // Serial.println(millis()-myTimer);
  if (DraftMode) {
    // showSpectrum();
    Serial.print("MaxMeasureValue=");
    Serial.println(MaxMeasureValue);
    Serial.print("MinxMeasureValue=");
    Serial.println(MinMeasureValue);
    Serial.println(findF());
  }


  if (findF() > 0) {
    AlarmSgnal();
  }

  if (DraftMode) {
    delay(200);
    Serial.println(' ');
    delay(5000);
  } else {
    Narcoleptic.delay(200);
  }
}

void MeasureSignal() {
  cli();
  TCCR1B |= (1 << WGM12);
  TCCR1B |= (1 << CS10);
  sei();
  ArrayIndex = 0;
  while (ArrayIndex < Np) {
  };
  TCCR1B = 0;
}

ISR(TIMER1_COMPA_vect) {
  myByte[ArrayIndex] = analogRead(analogPin);
  ArrayIndex++;
}

void MaxMinInMeasedSignal() {
  MaxMeasureValue = myByte[0];
  MinMeasureValue = myByte[0];

  for (int i = 1; i < Np; i++) {
    if (myByte[i] > MaxMeasureValue) {
      MaxMeasureValue = myByte[i];
    }
    if (myByte[i] < MinMeasureValue) {
      MinMeasureValue = myByte[i];
    }
  }
}

void sampleWindowFull() {
  if ((MaxMeasureValue - MinMeasureValue) > 15) {
    for (int i = 0; i < Np; i++) {
      data[i] = map(myByte[i], MinMeasureValue, MaxMeasureValue, -127, 127);
      im[i] = 0;
    }
  } else {
    for (int i = 0; i < Np; i++) {
      data[i] = myByte[i] - MinMeasureValue;
      im[i] = 0;
    }
  }

  // for (int i = 0; i < Np; i++) {
  //   //    int val = (analogRead(analogPin) - 512) * GAIN;
  //   data[i] = myByte[i] * GAIN / 4;
  //   im[i] = 0;
  // }
}

void updateData() {
  for (int i = 0; i < (Np / 2); i++) {
    //    data[i] = sqrt(data[i] * data[i] + im[i] * im[i]);
    // data[i] = (data[i] * data[i] + im[i] * im[i]);
    myByte[i] = sq(data[i]) + sq(im[i]);
  }
}

void showSpectrum() {
  for (int i = 1; i < (Np / 2); i++) {
    Serial.print(i);
    Serial.print(' ');
    // Serial.println(myByte[i]);
    uint16_t p = myByte[i];
    // Serial.println(data[i]);
    Serial.println(p);
  }
  Serial.println();
}

void showMeasurement() {
  for (int i = 0; i < Np; i++) {
    Serial.print(i);
    Serial.print(' ');
    Serial.println(myByte[i]);
  }
}

void showDataArray() {
  for (int i = 0; i < Np; i++) {
    Serial.print(i);
    Serial.print(' ');
    Serial.println(data[i]);
  }
}

long findF() {
  uint16_t maxValue = 0;
  int maxIndex = 0;
  for (int i = 2; i < (Np / 4); i++) {
    // int p = data[i];
    int p = myByte[i];
    if (p > maxValue) {
      maxValue = p;
      maxIndex = i;
    }
  }
  if (maxValue > ThresholdValue) {
    return maxIndex * 1e6 / MeasureDelay / Np;
  } else {
    return 0;
  }
}

void AlarmSgnal() {
  //  Serial.println("Alarm");
  //  Serial.println(findF());
  digitalWrite(AlarmPin, HIGH);
  // Narcoleptic.delay(100);
  delay(100);
  digitalWrite(AlarmPin, LOW);
}

//  for (byte i = 0; i < Np; i++) {
//    myByte[i] = analogRead(A0);
//    // delayMicroseconds(20);
//    _delay_us(20);
//  };
