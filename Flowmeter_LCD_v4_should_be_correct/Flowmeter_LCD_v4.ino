
volatile int NbTopsFan; //measuring the rising edges of the signal
int Calc;
int hallsensor = 2;    //The pin location of the sensor

float gpm;
float totaldispensed;

#include <LiquidCrystal.h>
// initialize the library with the numbers of the interface pins set for the Sainsmart 1602 16x2 LCD configuration
LiquidCrystal lcd(8, 9, 4, 5, 6, 7);


void rpm ()     //This is the function that the interupt calls 
{ 
  NbTopsFan++;  //This function measures the rising and falling edge of the hall effect sensors signal
} 




void setup() //
{ 
  Serial.begin(9600); //This is the setup function where the serial port is initialised,

  pinMode(hallsensor, INPUT); //initializes digital pin 2 as an input
  attachInterrupt(0, rpm, RISING); //and the interrupt is attached
} 
// the loop() method runs over and over again,
// as long as the Arduino has power
void loop ()    
{
  

     
  NbTopsFan = 0;   //Set NbTops to 0 ready for calculations
  sei();      //Enables interrupts
  delay (1000);   //Wait 
  cli();      //Disable interrupts
  Calc = (NbTopsFan / 4.9); //(Pulse frequency x 60) / 4.9Q, = flow rate in L/hour The 4.9 value was interpolated from the Q value for similar flowmeters
//Calc is flow in liters per hour


  gpm = (Calc * 0.264172052);
  
  lcd.begin(16, 2); 
  lcd.setCursor(0, 0 );
  lcd.print(gpm);
  lcd.print(" gpm  ");
  lcd.print(Calc);
  lcd.print(" lpm");
  
  
  lcd.setCursor (0, 1 );
  totaldispensed +=(gpm / 3600.0);
  int intValue = (int)totaldispensed;
  float diffValue = totaldispensed - (float)intValue;
  int anotherIntValue = (int)(diffValue * 1000.0);
  
  
  lcd.print (intValue);
  lcd.print (".");
  lcd.print (anotherIntValue);
  lcd.print (" gal total");
  
  }
  
  
  
  
  
  
  
  

//*********************************************************************************
// sort function
void isort(int *a, int n)
               //  *a is an array pointer function
{
  for (int i = 1; i < n; ++i)
  {
    int j = a[i];
    int k;
    for (k = i - 1; (k >= 0) && (j < a[k]); k--)
    {
      a[k + 1] = a[k];
    }
    a[k + 1] = j;
  }
}
//***********************************************************************************
//function to print array values
void printArray(int *a, int n)
{
  
  for (int i = 0; i < n; i++)
  {
    Serial.print(a[i], DEC);
    Serial.println(' ');
  }
  

}

