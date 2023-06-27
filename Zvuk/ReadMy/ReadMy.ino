//#include <avr/delay.h>
//#include <TimerOne.h>

//#define F_CPU 16000000UL;

const byte PS_128 = (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0);
const byte PS_16 = (1 << ADPS2);


const byte MeasureDelay = 50;
//time between measuring, us
const byte Np = 100;
volatile uint16_t myByte[Np];
volatile byte ArrayIndex;

void setup() {
  // initialize serial communication at 9600 bits per second:
  ADCSRA &= -PS_128;
  ADCSRA |= PS_16;
  Serial.begin(9600);

  cli();
  TCCR1B = 0;
  TCCR1A = 0;
  OCR1A = MeasureDelay / 1e6 * F_CPU -1;
  TIMSK1 |= (1 << OCIE1A);
  sei();
}

// the loop routine runs over and over again forever:
void loop() {
  cli();
  TCCR1B |= (1 << WGM12);
  TCCR1B |= (1 << CS10);
  sei();
  ArrayIndex = 0;
  while (ArrayIndex < Np) {
  };
  TCCR1B = 0;

  //  for (byte i = 0; i < Np; i++) {
  //    myByte[i] = analogRead(A0);
  //    // delayMicroseconds(20);
  //    _delay_us(20);
  //  };

  for (byte i = 0; i < Np; i++) {
    Serial.print(i);
    Serial.print(' ');
    Serial.println(myByte[i]);
  };
  Serial.println(' ');
  delay(3000);
}

ISR(TIMER1_COMPA_vect)
{
  myByte[ArrayIndex] = analogRead(A0);
  ArrayIndex++;
}


