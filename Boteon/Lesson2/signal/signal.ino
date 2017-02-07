#define LED_Pin 7
#define Buzzer_Pin 6
#define Sensor_Pin 5

int sensor_value;

void setup() {
  pinMode(LED_Pin, OUTPUT);
  pinMode(Sensor_Pin, INPUT);
  digitalWrite(LED_Pin, LOW);
  noTone(Buzzer_Pin);
}

void loop() {
  sensor_value = digitalRead(Sensor_Pin);
  if (sensor_value == LOW) {
    digitalWrite(LED_Pin, HIGH);
    tone(Buzzer_Pin, 5000);
    delay(100);
    digitalWrite(LED_Pin, LOW);
    noTone(Buzzer_Pin);
  }
  delay(100);
}
