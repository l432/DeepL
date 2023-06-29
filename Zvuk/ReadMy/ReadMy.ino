#include <fix_fft.h>
#include  <Narcoleptic.h>

//#include <avr/delay.h>
//#include <TimerOne.h>


//#define F_CPU 16000000UL;

const byte analogPin = A0;
const byte AlarmPin = 13;
const long GAIN = 10;


const byte PS_128 = (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0);
const byte PS_16 = (1 << ADPS2);


const byte MeasureDelay = 50;
//time between measuring, us
const int Np = 128;
volatile uint16_t myByte[Np];
volatile int ArrayIndex;
int8_t im[Np];
int8_t data[Np];
const byte ThresholdValue = 5;

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
  sampleWindowFull();
  fix_fft(data, im, 7, 0);
  updateData();

  //  showSpectrum();
    // showMeasurement();
    // Serial.println(millis()-myTimer);

  //  Serial.println(findF());
  if (findF() > 0) {
    AlarmSgnal();
  }
  delay(10);
  Narcoleptic.delay(200);
   Serial.println(' ');
   delay(5000);
}

void MeasureSignal()
{
  cli();
  TCCR1B |= (1 << WGM12);
  TCCR1B |= (1 << CS10);
  sei();
  ArrayIndex = 0;
  while (ArrayIndex < Np) {
  };
  TCCR1B = 0;
}

ISR(TIMER1_COMPA_vect)
{
  myByte[ArrayIndex] = analogRead(analogPin);
  ArrayIndex++;
}

void sampleWindowFull()
{
  for (int i = 0; i < Np; i++)
  {
    //    int val = (analogRead(analogPin) - 512) * GAIN;
    data[i] = myByte[i] * GAIN / 4;
    im[i] = 0;
  }
}

void updateData()
{
  for (int i = 0; i < (Np / 2 ); i++)
  {
//    data[i] = sqrt(data[i] * data[i] + im[i] * im[i]);
    data[i] = (data[i] * data[i] + im[i] * im[i]);
  }
}

void showSpectrum()
{
  for (int i = 1; i < (Np / 2 ); i++)
  {
    Serial.print(i);
    Serial.print(' ');
    //    Serial.println(myByte[i]);
    //    int p = data[i];
    Serial.println(data[i]);
  }
  Serial.println();
}

void showMeasurement()
{
  for (int i = 0; i < Np; i++) {
    Serial.print(i);
    Serial.print(' ');
    Serial.println(myByte[i]);
  }
}

long  findF()
{
  int8_t maxValue = 0;
  int maxIndex = 0;
  for (int i = 1; i < (Np / 2 ); i++)
  {
    int p = data[i];
    if (p > maxValue)
    {
      maxValue = p;
      maxIndex = i;
    }
  }
  if (maxValue > ThresholdValue) {
    return maxIndex * 1e6 / MeasureDelay / Np;
  } else {
    return 0 ;
  }
}

void AlarmSgnal() {
  //  Serial.println("Alarm");
//  Serial.println(findF());
  digitalWrite(AlarmPin, HIGH);
  Narcoleptic.delay(100);
  digitalWrite(AlarmPin, LOW);
}

//  for (byte i = 0; i < Np; i++) {
//    myByte[i] = analogRead(A0);
//    // delayMicroseconds(20);
//    _delay_us(20);
//  };


