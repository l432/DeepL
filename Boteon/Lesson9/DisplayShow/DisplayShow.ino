#include <Wire.h>
#include <LiquidCrystal_I2C.h>

LiquidCrystal_I2C lcd(0x3F, 2, 1, 0, 4, 5, 6, 7, 3, POSITIVE);
String text1 = "LCD performance";
String text2 = "capabilities";

byte charD[8] = {0x04,
                 0x0A,
                 0x0A,
                 0x0A,
                 0x0A,
                 0x0A,
                 0x1F,
                 0x11
                };
byte charI[8] = {0x11,
                 0x13,
                 0x13,
                 0x15,
                 0x15,
                 0x19,
                 0x19,
                 0x11
                };
byte charII[8] = {0x0A,
                  0x00,
                  0x04,
                  0x04,
                  0x04,
                  0x04,
                  0x04,
                  0x04
                 };

byte charSmile[8] = {0x00,
                     0x0A,
                     0x00,
                     0x04,
                     0x04,
                     0x11,
                     0x0E,
                     0x00
                    };



void setup() {
  lcd.begin (16, 2);
  lcd.createChar(0, charD);
  lcd.createChar(1, charI);
  lcd.createChar(2, charII);
  lcd.createChar(3, charSmile);
}

void loop() {
  lcd.setCursor(0, 0);
  lcd.print(text1);
  lcd.setCursor(4, 1);
  lcd.print(text2);
  delay(1000);
  lcd.noDisplay();
  delay(3000);
  lcd.display();
  delay(3000);
  lcd.clear();
  lcd.leftToRight();
  lcd.cursor();
  lcd.setCursor(0, 0);
  for (int i = 0; i < text1.length(); i++)
  {
    lcd.write(text1[i]);
    delay(300);
  }
  lcd.blink();
  lcd.setCursor(4, 1);
  for (int i = 0; i < text2.length(); i++)
  {
    lcd.write(text2[i]);
    delay(300);
  }
  lcd.clear();
  lcd.autoscroll();
  lcd.setCursor(15, 0);
  for (int i = 0; i < text1.length(); i++)
  {
    lcd.write(text1[i]);
    delay(300);
  }
  lcd.noAutoscroll();
  lcd.clear();
  lcd.noCursor();
  lcd.noBlink();

  lcd.setCursor(0, 1);
  lcd.print(text2);

  for (int i = 0; i < 16; i++)
  {
    lcd.scrollDisplayRight();
    delay(300);
  }
  lcd.clear();


  lcd.setCursor(2, 0);
  lcd.write((uint8_t)0);
  lcd.write((uint8_t)1);
  lcd.print("HAMO K");
  lcd.write((uint8_t)1);
  lcd.write((uint8_t)2);
  lcd.write("B");

  lcd.setCursor(2, 1);
  lcd.write((uint8_t)3);
  lcd.print("  ");
  lcd.write((uint8_t)3);
  lcd.print("   ");
  lcd.write((uint8_t)3);
  lcd.print("  ");
  lcd.write((uint8_t)3);

  delay(3000);
  for (int i = 0; i < 5; i++)
  {
    lcd.noDisplay();
    delay(300);
    lcd.display();
    delay(300);
  }
 lcd.clear();

}
