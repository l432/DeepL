#define But_Pin 5
#define Led_Pin 7

int val = 0;

void setup() {
  pinMode(But_Pin, INPUT);
  pinMode(Led_Pin, OUTPUT);
}

void loop() {
  val = digitalRead(But_Pin);
  digitalWrite(Led_Pin, val);
  delay(100);
}
