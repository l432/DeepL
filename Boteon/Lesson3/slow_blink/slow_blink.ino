#define PWM_Pin 11

void setup() {

}

void loop() {
    for (int i=0; i <= 255; i++){
      analogWrite(PWM_Pin, i);
      delay(10);
   }
    for (int i=255; i >= 0; i--){
      analogWrite(PWM_Pin, i);
      delay(10);
   }
}
