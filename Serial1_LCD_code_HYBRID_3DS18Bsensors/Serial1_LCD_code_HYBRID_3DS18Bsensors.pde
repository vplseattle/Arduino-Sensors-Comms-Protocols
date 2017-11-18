
#include <OneWire.h>
#include <DallasTemperature.h>

// Data wire is plugged into port 2 on the Arduino
#define ONE_WIRE_BUS 2

// Setup a oneWire instance to communicate with any OneWire devices (not just Maxim/Dallas temperature ICs)
OneWire oneWire(ONE_WIRE_BUS);

// Pass our oneWire reference to Dallas Temperature. 
DallasTemperature sensors(&oneWire);

// Set this to whatever text you want to print on LCD as static text
char line1[] = "0_";
char line2[] = "2_";

#define line1Length (sizeof(line1)-1)
#define line2Length (sizeof(line2)-1)


void setup() {

  Serial.begin(9600);
  Serial1.begin(9600);
  backlightOn();
  clearLCD();
  
    // Start up the data aquisition from 1 wire devices
  sensors.begin();
}

void loop() {
  
   // call sensors.requestTemperatures() to issue a global temperature 
  // request to all devices on the bus
  delay(60000);
  sensors.requestTemperatures(); // Send the command to get temperatures
  
  Serial.print(millis()/60000);
  Serial.print(",");
  Serial.print(sensors.getTempCByIndex(0));
  Serial.print(",");
  Serial.print(sensors.getTempCByIndex(1));
  Serial.print(",");
  Serial.println(sensors.getTempCByIndex(2));
  
  // write line 1 to LCD
  for(int i=0;i<line1Length;i++) {
    goTo(i);
    if (line1[i] != ' ') {
      Serial1.print(line1[i]);
      Serial1.print(sensors.getTempCByIndex(0));
      Serial1.print(" ");
      Serial1.print("1_");
      Serial1.print(sensors.getTempCByIndex(1));
      Serial1.print(" ");

    }
    
  }
  
  // write line 2 to LCD
  for(int i=0;i<line2Length;i++) {
    goTo(i+16);
    if (line2[i] != ' ') {
      Serial1.print(line2[i]);
      Serial1.print(sensors.getTempCByIndex(2));
      Serial1.print(" ");
      Serial1.print(millis()/60000);
      

    }
 
} 

}


// LCD Display routines


// Scrolls the display left by the number of characters passed in, and waits a given
// number of milliseconds between each step
void scrollLeft(int num, int wait) {
  for(int i=0;i<num;i++) {
    serCommand();
    Serial1.print(0x18, BYTE);
    delay(wait);
  }
}

// Scrolls the display right by the number of characters passed in, and waits a given
// number of milliseconds between each step
void scrollRight(int num, int wait) {
  for(int i=0;i<num;i++) {
    serCommand();
    Serial1.print(0x1C, BYTE);
    delay(wait);
  }
}

// Starts the cursor at the beginning of the first line (convienence method for goTo(0))
void selectLineOne() {  //puts the cursor at line 0 char 0.
   serCommand();   //command flag
   Serial1.print(128, BYTE);    //position
}

// Starts the cursor at the beginning of the second line (convienence method for goTo(16))
void selectLineTwo() {  //puts the cursor at line 0 char 0.
   serCommand();   //command flag
   Serial1.print(192, BYTE);    //position
}

// Sets the cursor to the given position
// line 1: 0-15, line 2: 16-31, 31+ defaults back to 0
void goTo(int position) {
  if (position < 16) { 
    serCommand();   //command flag
    Serial1.print((position+128), BYTE);
  } else if (position < 32) {
    serCommand();   //command flag
    Serial1.print((position+48+128), BYTE);
  } else { 
    goTo(0); 
  }
}

// Resets the display, undoing any scroll and removing all text
void clearLCD() {
   serCommand();
   Serial1.print(0x01, BYTE);
}

// Turns the backlight on
void backlightOn() {
    serCommand();
    Serial1.print(157, BYTE);
}

// Turns the backlight off
void backlightOff() {
    serCommand();
    Serial1.print(128, BYTE);
}

// Initiates a function command to the display
void serCommand() {
  Serial1.print(0xFE, BYTE);
}
