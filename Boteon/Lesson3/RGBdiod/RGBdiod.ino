#define RED_PIN 11
#define GREEN_PIN 10
#define BLUE_PIN 9

void setup() {
}

void loop() {
  analogWrite(RED_PIN, 255);
 analogWrite(GREEN_PIN, 0);
  analogWrite(BLUE_PIN, 0);
  delay(1000);

  analogWrite(RED_PIN, 0);
  analogWrite(GREEN_PIN, 255);
  analogWrite(BLUE_PIN, 0);
  delay(1000);

  analogWrite(RED_PIN, 0);
  analogWrite(GREEN_PIN, 0);
  analogWrite(BLUE_PIN, 255);
  delay(1000);

  //red
  analogWrite(RED_PIN, 245);
  analogWrite(GREEN_PIN, 50);
  analogWrite(BLUE_PIN, 11);
  delay(1000);

  //orange
  analogWrite(RED_PIN, 252);
  analogWrite(GREEN_PIN, 158);
  analogWrite(BLUE_PIN, 4);
  delay(1000);

  //yellow
  analogWrite(RED_PIN, 255);
  analogWrite(GREEN_PIN, 255);
  analogWrite(BLUE_PIN, 0);
  delay(1000);

  //green
  analogWrite(RED_PIN, 33);
  analogWrite(GREEN_PIN, 245);
  analogWrite(BLUE_PIN, 11);
  delay(1000);

  //blue
  analogWrite(RED_PIN, 31);
  analogWrite(GREEN_PIN, 15);
  analogWrite(BLUE_PIN, 241);
  delay(1000);

  //violent
  analogWrite(RED_PIN, 153);
  analogWrite(GREEN_PIN, 0);
  analogWrite(BLUE_PIN, 255);
  delay(1000);

}
