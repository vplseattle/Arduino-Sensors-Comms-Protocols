#include <NewSoftSerial.h>
#include <LiquidCrystal.h>                 

NewSoftSerial mySerial =  NewSoftSerial(3, 2);
LiquidCrystal lcd(11, NULL, 12, 7, 8, 9, 10);

char stamp_data[15];          
//this is where the data from the stamp is stored. The array is 15 char long because
//if no pH probe is connected, the message "check probe" is transmitted.
 //Having an array that is too small will cause data corruption and could cause the Arduino to crash. 
byte holding;                       
//used to tell us the number of bytes that have been received by the Arduino and are
//holding in the buffer holding
byte i;                  


void setup()

{
  
    // set up the LCD's number of columns and rows: 
  lcd.begin(16, 2);
  // Print a message to the LCD.
  lcd.print("pH meter");
  delay(200);
  
  mySerial.begin(38400);   
  Serial.begin(38400);  
delay(1000);
  mySerial.print("l0");           //the command "c" will tell the stamp to take continues readings
  mySerial.print(13,BYTE);       //ALWAYS end a command with <CR> (which is simply the number 13) or//(print("/r")
delay(1000);
  mySerial.print("c");           //the command "c" will tell the stamp to take continues readings
  mySerial.print(13,BYTE);       //ALWAYS end a command with <CR> (which is simply the number 13) or//(print("/r")
  
}

          
void loop() {                                       //main loop


 if(mySerial.available() > 0) {        //if we see the more than three bytes have been received by the Arduino
    holding=mySerial.available();      //lets read how many bytes have been received
    for(i=0; i <= holding;i++){       //we make a loop that will read each byte we received
        stamp_data[i]= mySerial.read();     //and load that byte into the stamp_data array
        stamp_data[i+1] = '\0'; // <== add this line
    }

    Serial.println(stamp_data);    
    lcd.begin(16, 2);
    lcd.print(stamp_data);
    delay(500);

    }
}
