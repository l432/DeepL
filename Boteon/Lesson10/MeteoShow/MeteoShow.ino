#include <DHT.h>
#include <Wire.h>
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x3F, 2, 1, 0, 4, 5, 6, 7, 3, POSITIVE);
DHT dht(2, DHT11);
String text1 = "Temperature: ";
String text2 = "Humidity: ";

byte Degree[8] = {0x06,
                  0x09,
                  0x09,
                  0x06,
                  0x00,
                  0x00,
                  0x00,
                  0x00
                 };


void setup() {
  lcd.begin (16, 2);
  dht.begin();

  lcd.createChar(0, Degree);
}

void loop() {
  lcd.setCursor(16, 0);
  lcd.print(text1);
  lcd.print((int)dht.readTemperature());
  lcd.write((uint8_t)0);
  lcd.print("C");

  lcd.setCursor(16, 1);
  lcd.print(text2);
  lcd.print("   ");
  lcd.print((int)dht.readHumidity());
  lcd.print(" %");

  for (int i = 0; i < 32; i++)
  {
    lcd.scrollDisplayLeft();
    delay(500);
  }
 
  lcd.clear();

}
