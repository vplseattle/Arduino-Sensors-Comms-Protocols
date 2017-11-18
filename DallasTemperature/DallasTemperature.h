	#ifndef DallasTemperature_h
#define DallasTemperature_h

//#define REQUIRESNEW

// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.

#include <inttypes.h>
#include <OneWire.h>

class DallasTemperature
{
  private:
  // parasite power on or off
  bool parasite;

  // used to determine the delay amount needed to allow for the
  // temperature conversion to take place
  int conversionDelay;

  // count of devices on the bus
  uint8_t devices;
  
  // Take a pointer to one wire instance
  OneWire* _wire;
  
  public:

  DallasTemperature(OneWire*);

  // initalize bus
  void begin(void);

  // returns the number fo devices found on the bus
  uint8_t getDeviceCount(void);

  // returns true if address is valid
  bool validAddress(uint8_t []);

  // finds an address at a given index on the bus 
  bool getAddress(uint8_t [], uint8_t);

  // attempt to determine if the device at the given address is connected to the bus
  bool isConnected(uint8_t []);

  // attempt to determine if the device at the given address is connected to the bus
  // also allows for updating the read scratchpad
  bool isConnected(uint8_t [], uint8_t []);

  // read device's scratchpad
  void readScratchPad(uint8_t [], uint8_t []);

  // write device's scratchpad
  void writeScratchPad(uint8_t [], uint8_t []);

  // read device's power requirements
  bool readPowerSupply(uint8_t []);

  // returns the current resolution, 9-12
  uint8_t getResolution(uint8_t []);

  // set resolution of a device to 9, 10, 11, or 12 bits
  void setResolution(uint8_t[], uint8_t);

  // sends command for all devices on the bus to perform a temperature conversion
  void requestTemperatures(void);

  // returns temperature in degrees C
  float getTempC(uint8_t []);

  // returns temperature in degrees F
  float getTempF(uint8_t []);

  // Get tempature for device index (slow)
  float getTempCByIndex(uint8_t );
  
  // Get tempature for device index (slow)
  float getTempFByIndex(uint8_t );
  
  // returns true if the bus requires parasite power
  bool isParasitePowerMode(void);

  // sets the high alarm temperature for a device
  // accepts a char.  valid range is -55C - 125C
  void setHighAlarmTemp(uint8_t [], char);

  // sets the low alarm temperature for a device
  // accepts a char.  valid range is -55C - 125C
  void setLowAlarmTemp(uint8_t [], char);

  // returns a signed char with the current high alarm temperature for a device
  // in the range -55C - 125C
  char getHighAlarmTemp(uint8_t []);

  // returns a signed char with the current low alarm temperature for a device
  // in the range -55C - 125C
  char getLowAlarmTemp(uint8_t []);

  // resets internal variables used for the alarm search
  //void resetAlarmSearch(void);

  // search the wire for devices with active alarms
  bool alarmSearch(uint8_t []);

  // convert from celcius to farenheit
  static float toFahrenheit(const float);

  // convert from farenheit to celsius
  static float toCelsius(const float);

  #ifdef REQUIRESNEW
  // initalize memory area
  void* operator new (unsigned int);

  // delete memory reference
  void operator delete(void*);
  
  #endif

};
#endif
