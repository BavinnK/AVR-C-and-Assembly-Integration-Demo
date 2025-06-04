#include "avr/io.h"
.global Sub
.global Add
.global Mul
.global Set_LED
.global PinModeASMset
.global PinModeASMclear


;add function 
Add:
  add r24,r22
  adc r25,r23
  ret
;end of add func


;sub func
Sub:
  sub r24,r22
  sbc r25,r23
  ret
;enf of sub func


;Mutiplication func
Mul:
  mul r24,r22
  movw r24,r0
  ret
;end of mult

Set_LED:
  push r19
  ldi r19,(1<<PINB5)
  out _SFR_IO_ADDR(DDRB),r17
  cpi r24,0x01
  brne Set_LEDOff
Set_LEDOn:
  out _SFR_IO_ADDR(PORTB),r17
  rjmp Set_LEDEnd

Set_LEDOff:
  ldi r17,0x00
  out _SFR_IO_ADDR(PORTB),r17

Set_LEDEnd:
  pop r17
  ret


PinModeASMset:
  push r1
  push r0


  adiw r24,0x20
  clr XH
  mov XL,r24

WriteOne: 
  ld r20,X
  or r20,r22
  st X,r20  
  pop r0
  pop r1
  ret

PinModeASMclear:
  push r0
  push r1
  adiw r24,0x20
  clr XH
  mov XL,r24

  writeZero:
  ld r20,X
  com r22
  and r20,r22
  st X,r20
  pop r1
  pop r0
  ret