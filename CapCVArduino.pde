// Sound Experiments - Capactive CV
// For more information, including schematics and other projects, please go to:
// http://www.jimmymhughes.com/projects/capacitive-paint-controller/
// Sketch informed by Paul Badger's "CapitiveSense Library Demo Sketch" 2008
// This sketch was tested in Arduino Alpha 22
#include <CapSense.h>

const int analogOutPinL = 9; // analaog out pin for CVLeft -> modular synth
const int analogOutPinR = 10; // analog out pin for CVRight -> modular synth
CapSense   cs_4_2 = CapSense(4,2);  // 22 megohm resistor between pins 4 & 2, pin 2 is connected to conductive surface 1
CapSense   cs_4_5 = CapSense(4,5);  // 22 megohm resistor between pins 4 & 6, pin 6 is connected to conductive surface 2

int outputCVLeft = 0; // variables for scaled CV output data
int outputCVRight = 0; // 

void setup()                 
{
   cs_4_2.set_CS_AutocaL_Millis(0xFFFFFFFF); // turn off autocalibrate on input channels 
   cs_4_5.set_CS_AutocaL_Millis(0xFFFFFFFF);
   Serial.begin(9600);
}

void loop()                    

{    
long start = millis();    
long total1 =  cs_4_2.capSense(10);  // variables for printing to serial monitor
long total2 =  cs_4_5.capSense(10);  

Serial.println(total1);  // Prints total values to serial monitor - useful for determining sensor read range
Serial.print(" ");                
Serial.print(total2); 
Serial.print(" ");  

outputCVLeft = map(total1, 0, 5000, 0, 255); // scales total ranges to CV1 and CV2 output voltage
outputCVRight = map(total2, 0, 5000, 0, 255); // I chose my scaling values through trial and error with the serial monitor

analogWrite(analogOutPinL, outputCVLeft);  // writes outputCV to PWM outputs
analogWrite(analogOutPinR, outputCVRight);

delay(10);  // playing with this delay can change your perception of the effect and give you different S&H/quantized effects 
} 

 
