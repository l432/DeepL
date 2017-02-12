#define RED_PIN 11
#define GREEN_PIN 10
#define BLUE_PIN 9

void setup() {
}

void loop() {
  digitalWrite(RED_PIN, 255);
  digitalWrite(GREEN_PIN, 0);
  digitalWrite(BLUE_PIN, 0);
  delay(1000);

  digitalWrite(RED_PIN, 0);
  digitalWrite(GREEN_PIN, 255);
  digitalWrite(BLUE_PIN, 0);
  delay(1000);

  digitalWrite(RED_PIN, 0);
  digitalWrite(GREEN_PIN, 0);
  digitalWrite(BLUE_PIN, 255);
  delay(1000);

  //red
  digitalWrite(RED_PIN, 245);
  digitalWrite(GREEN_PIN, 50);
  digitalWrite(BLUE_PIN, 11);
  delay(1000);

  //orange
  digitalWrite(RED_PIN, 252);
  digitalWrite(GREEN_PIN, 158);
  digitalWrite(BLUE_PIN, 4);
  delay(1000);

  //yellow
  digitalWrite(RED_PIN, 255);
  digitalWrite(GREEN_PIN, 255);
  digitalWrite(BLUE_PIN, 0);
  delay(1000);

  //green
  digitalWrite(RED_PIN, 33);
  digitalWrite(GREEN_PIN, 245);
  digitalWrite(BLUE_PIN, 11);
  delay(1000);

  //blue
  digitalWrite(RED_PIN, 31);
  digitalWrite(GREEN_PIN, 15);
  digitalWrite(BLUE_PIN, 241);
  delay(1000);

  //violent
  digitalWrite(RED_PIN, 153);
  digitalWrite(GREEN_PIN, 0);
  digitalWrite(BLUE_PIN, 255);
  delay(1000);

}
