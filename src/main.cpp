#include <Arduino.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


char buff[80];
volatile uint16_t x=19,y=7;
extern "C"{
uint16_t Add(uint16_t x,uint16_t y);
uint16_t Sub(uint16_t x,uint16_t y);
uint16_t Mul(uint16_t x,uint16_t y);
void Set_LED(uint8_t set);
}
void setup() {
  
  Serial.begin(115200);
  sprintf(buff,"%d + %d = %d",x,y,Add(x,y));
  Serial.println(buff);
  sprintf(buff,"%d - %d = %d",x,y,Sub(x,y));
  Serial.println(buff);
  sprintf(buff,"%d * %d = %d",x,y,Mul(x,y));
  Serial.println(buff);
  //pinMode(13,OUTPUT);

}

void loop() {
  // set LED is the same as digitalWrite function but the one i used is pure ASM  :)
  //digitalWrite(13,HIGH);
  Set_LED(HIGH);
  delay(100);
  //digitalWrite(13,LOW);
  Set_LED(LOW);
  delay(100);

}
