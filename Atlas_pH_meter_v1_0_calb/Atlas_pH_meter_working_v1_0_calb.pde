#include <NewSoftSerial.h> 
#include <LiquidCrystal.h>

LiquidCrystal lcd(11, NULL, 12, 7, 8, 9, 10);
NewSoftSerial mySerial (2,3);

char stamp_data[12];
byte holding; 
byte i;
byte startup=0;
float ph;

int HOLD_DELAY = 10000;    // Sets the hold delay of switch for LED state change
int ledPin     = 9;      // LED is connected to pin x
int switchPin  = 5;      // Switch is connected to pin x

unsigned long start_hold;
boolean allow = false;
int sw_state;
int sw_laststate = LOW;
int led_state = LOW;

void setup(){
mySerial.begin(38400);
Serial.begin(38400);
   // set up the LCD's number of columns and rows: 
  lcd.begin(16, 2);
  // Print a message to the LCD.
  lcd.print("    pH meter");
  delay(200);
  
pinMode(ledPin, OUTPUT);      // Set the LED pin as output
pinMode(switchPin, INPUT);    // Set the switch pin as input


}



void loop() { 
if(startup==0){
for(i=1; i <= 2;i++){
delay(1000);
mySerial.print("l0");
mySerial.print(13,BYTE);
delay(1000);
mySerial.print("l1");
mySerial.print(13,BYTE);
}
startup=1; 
delay(1000);
mySerial.print("c");
mySerial.print(13,BYTE);
}
if(mySerial.available() > 3) {
holding=mySerial.available();
for(i=0; i <= holding;i++){
stamp_data[i]= mySerial.read();
}
}
stamp_data[holding]='\0';
ph=atof(stamp_data);


lcd.begin(16, 2);
lcd.print("    pH ");
lcd.print(ph);

delay(500);


sw_state = digitalRead(switchPin);             // read input value
if (sw_state == HIGH && sw_laststate == LOW){  // for button pressing
start_hold = millis();                       // mark the time
allow = true;                                // allow LED state changes

}


if (allow == true && sw_state == HIGH && sw_laststate == HIGH){  // if button remains pressed
if ((millis() - start_hold) >= HOLD_DELAY){                   // for longer than x/1000 sec(s)
lcd.begin(16, 2);
lcd.print("Calibration Mode");
delay(5000);
lcd.clear();

lcd.clear();
lcd.print("Here we go...");
delay(5000);

lcd.clear();
lcd.print("Place probe into");
lcd.setCursor(0, 1);
lcd.print("YELLOW pH 7.00");
delay(5000);
lcd.clear();
lcd.print("pH 7 calibration");
lcd.setCursor(0, 1);
lcd.print("about to begin");
delay(5000);
mySerial.print("c");
mySerial.print(13,BYTE);
lcd.clear();
lcd.setCursor(0, 1);
lcd.print("Measuring pH7");
delay(60000);
mySerial.print("S");
mySerial.print(13,BYTE);
lcd.clear();
lcd.setCursor(0, 1);
lcd.print("pH 7 CALIBRATED");
delay (5000);

lcd.clear();
lcd.print("Rinse probe");
delay(15000);

lcd.clear();
lcd.print("Place probe into");
lcd.setCursor(0, 1);
lcd.print("RED pH 4.00");
delay(5000);
lcd.clear();
lcd.print("pH 4 calibration");
lcd.setCursor(0, 1);
lcd.print("about to begin");
delay(5000);
mySerial.print("c");
mySerial.print(13,BYTE);
lcd.clear();
lcd.setCursor(0, 1);
lcd.print("Measuring pH4");
delay(60000);
mySerial.print("F");
mySerial.print(13,BYTE);
lcd.clear();
lcd.setCursor(0, 1);
lcd.print("pH 4 CALIBRATED");
delay (5000);

lcd.clear();
lcd.print("Rinse probe");
delay(15000);

lcd.clear();
lcd.print("Place probe into");
lcd.setCursor(0, 1);
lcd.print("BLUE pH 10.00");
delay(5000);
lcd.clear();
lcd.print("pH 10 calib.");
lcd.setCursor(0, 1);
lcd.print("about to begin");
delay(5000);
mySerial.print("c");
mySerial.print(13,BYTE);
lcd.clear();
lcd.setCursor(0, 1);
lcd.print("Measuring pH10");
delay(60000);
mySerial.print("T");
mySerial.print(13,BYTE);
lcd.clear();
lcd.setCursor(0, 1);
lcd.print("pH 10 CALIBRATED");
delay (5000);
mySerial.print("E");
mySerial.print(13,BYTE);


lcd.clear();
lcd.print("Rinse probe");
delay(10000);

lcd.clear();
lcd.setCursor(0, 1);
lcd.print("UNIT CALIBRATED");
delay (2000);

mySerial.print("C");
mySerial.print(13,BYTE);

lcd.clear();

led_state = !led_state;                                   // change state of LED
allow = false;                                            // prevent multiple state changes

}

}

sw_laststate = sw_state;  
digitalWrite(ledPin, led_state);



}
