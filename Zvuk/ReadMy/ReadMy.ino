// the setup routine runs once when you press reset:

#include <avr/delay.h>
#define F_CPU 16000000UL;

const byte PS_128=(1<<ADPS2)|(1<<ADPS1)|(1<<ADPS0);
const byte PS_16=(1<<ADPS2);

const byte Np=100;
int myByte[Np];

void setup() {
  // initialize serial communication at 9600 bits per second:
  ADCSRA &= -PS_128;
  ADCSRA |= PS_16;
  Serial.begin(9600);
  while(!Serial){};
  Serial.println(PS_128,2);
  Serial.println(PS_16,2);
}

// the loop routine runs over and over again forever:
void loop() {
  for (byte i = 0; i < Np; i++) {
    myByte[i] = analogRead(A0);
    // delayMicroseconds(20);
    _delay_us(20);
  };
  for (byte i = 0; i < Np; i++) {
    Serial.print(i);
    Serial.print(' ');
    Serial.println(myByte[i]);
  };
  Serial.println(' ');
  delay(3000);
}
