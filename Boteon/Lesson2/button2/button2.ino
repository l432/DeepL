#define But_Pin 5
#define Led_Pin 7

int val = 0;
boolean lighting = false;

void setup() {
  //  Serial.begin(9600);
  pinMode(But_Pin, INPUT);
  pinMode(Led_Pin, OUTPUT);
}

void loop() {

  val = digitalRead(But_Pin);
  if (val == HIGH)
  {
    lighting = !lighting;
    if (lighting)
    {
      digitalWrite(Led_Pin, HIGH);
    }
    else
    {
      digitalWrite(Led_Pin, LOW);
    };
    delay(300);
  };

  delay(100);

  // Serial.print(val);
  // Serial.print(" \n");
  // delay(400);

}
