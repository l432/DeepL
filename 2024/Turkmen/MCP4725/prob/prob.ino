/**************************************************************************/
/*!
    @file     trianglewave.pde
    @author   Adafruit Industries
    @license  BSD (see license.txt)

    This example will generate a triangle wave with the MCP4725 DAC.

    This is an example sketch for the Adafruit MCP4725 breakout board
    ----> http://www.adafruit.com/products/935

    Adafruit invests time and resources providing this open source code,
    please support Adafruit and open-source hardware by purchasing
    products from Adafruit!
*/
/**************************************************************************/
#include <Wire.h>
#include <Adafruit_MCP4725.h>
#include <INA226.h>

Adafruit_MCP4725 dac;
INA226 ina;

#define KEYPIN 7

const float Rshunt = 55.09;
const float maxVoltage = 4.92625;
int State = 0;
float V = 5;
int StepCount = 1;

void SetVoltageValue(float V);
float MeasureCurrentInmkA(void);
void IVcharMeasurement(float maxV, int StepCount);

void setup(void) {
  pinMode(KEYPIN, INPUT_PULLUP);
  //  digitalWrite(KEYPIN,HIGH);
  Serial.begin(9600);
  Serial.println("Hello!");
  Serial.println("To begin push the button");

  // For Adafruit MCP4725A1 the address is 0x62 (default) or 0x63 (ADDR pin tied to VCC)
  // For MCP4725A0 the address is 0x60 or 0x61
  // For MCP4725A2 the address is 0x64 or 0x65
  dac.begin(0x61);

  //  Serial.println("Initialize INA226");
  Serial.println("-----------------------------------------------");

  // Default INA226 address is 0x40
  ina.begin(0x45);

  // Configure INA226
  //  ina.configure(INA226_AVERAGES_64, INA226_BUS_CONV_TIME_4156US, INA226_SHUNT_CONV_TIME_1100US, INA226_MODE_SHUNT_BUS_CONT);

  // Calibrate INA226. Rshunt = 0.01 ohm, Max excepted current = 4A
  //  ina.calibrate(55.09, 0.0012);


}

void loop(void) {
  while (digitalRead(KEYPIN) != HIGH) {
    switch (State) {
      case 0:
        Serial.println("Input high voltage value (high limit is 4.8 V)");
        Serial.println("Send value and push the button");
        State = 1;
        break;
      case 1:
        if (Serial.available() > 0) {

          V = Serial.parseFloat();
          Serial.print("You input ");
          Serial.print(V, 3);
          Serial.println(" V");
          Serial.println("To continue push the button");
          if ((V > 0) && (V <= 4.8)) {
            State = 2;
            Serial.println("------");
          } else {
            Serial.println("It is WRONG value!!!!");
            State = 0;
          }
        } else {
          State = 0;
        }
        break;
      case 2:
        Serial.println("Input step number ( >0 )");
        Serial.println("Send value and push the button");
        State = 3;
        break;
      case 3:
        if (Serial.available() > 0) {

          StepCount = Serial.parseInt();
          Serial.print("You input ");
          Serial.println(StepCount);
          Serial.println("To continue push the button");
          if (StepCount > 0) {
            State = 4;
            Serial.println("------");
          } else {
            Serial.println("It is WRONG value!!!!");
            State = 2;
            
          }
        } else {
          State = 2;
        }
        break;
      case 4:
        IVcharMeasurement(V, StepCount);
        State = 0;
        Serial.println("To continue push the button");
        break;
    }
    delay(500);
  }
  delay(10);
  //  IVcharMeasurement(4.5, 10);
  //  delay(5000);

  //  Serial.println("Input high voltage value (high limit is 4.8 V)");
  //  if (Serial.available()>0){
  //   float V=Serial.parseFloat();
  //   Serial.println(V,5);
  //  }
  //  delay(2000);
}

void SetVoltageValue(float V) {
  if ((V > maxVoltage) || (V > maxVoltage)) return;
  dac.setVoltage(round(V / maxVoltage * 4095), false);
}

float MeasureCurrentInmkA(void) {
  return ina.readShuntVoltage() / Rshunt * 1e6;
}

void IVcharMeasurement(float maxV, int StepCount) {
  float VoltageStep = maxV / StepCount;
  float Volt = 0;
  float CurrFon = 0;
  float Curr = 0;
  while (Volt < maxV * 1.01) {
    SetVoltageValue(Volt);
    delay(200);
    ina.configure(INA226_AVERAGES_16, INA226_BUS_CONV_TIME_1100US, INA226_SHUNT_CONV_TIME_1100US, INA226_MODE_BUS_CONT);
    delay(50);
    //    Serial.println(Volt);
    Serial.print("Voltage:   ");
    Serial.print(ina.readBusVoltage(), 3);
    Serial.println(" V");
    ina.configure(INA226_AVERAGES_16, INA226_BUS_CONV_TIME_1100US, INA226_SHUNT_CONV_TIME_1100US, INA226_MODE_SHUNT_CONT);
    delay(50);
    Curr = MeasureCurrentInmkA();
    if (Volt == 0) CurrFon = Curr;
    Serial.print("Current:   ");
    Serial.print(Curr - CurrFon, 3);
    Serial.println(" mkA");
    Serial.println("----------------------");
    delay(4000);
    Volt += VoltageStep;
  }
  SetVoltageValue(0);
  delay(50);
  Serial.println("Measurement is done!!!");
}



