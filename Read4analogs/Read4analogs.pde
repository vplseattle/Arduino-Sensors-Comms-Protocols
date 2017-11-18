/*
  AnalogReadSerial
 Reads an analog input on pin 0, prints the result to the serial monitor 
 
 This example code is in the public domain.
 */

void setup() {
  Serial.begin(9600);
}

void loop() {
  int sensorValue0 = analogRead(A0);
  Serial.print(sensorValue0, DEC);
  Serial.print(" ");
  
  int sensorValue1 = analogRead(A1);
  Serial.print(sensorValue1, DEC);
    Serial.print(" ");
  
  int sensorValue2 = analogRead(A2);
  Serial.print(sensorValue2, DEC);
    Serial.print(" ");
  
  int sensorValue3 = analogRead(A3);
  Serial.print(sensorValue3, DEC);
    Serial.print(" ");
      Serial.println(" ");
      
      delay (1000);
}
