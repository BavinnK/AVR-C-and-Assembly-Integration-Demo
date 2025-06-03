# AVR C++ and Assembly Integration Demo

## Project Overview

This project is a learning exercise demonstrating the integration of C++ and external Assembly language (ASM) routines on an AVR microcontroller (such as those found on Arduino boards for UNO it's Atmel Atmega328p). It showcases how to call custom-written Assembly functions from C++ code for tasks including basic arithmetic operations and direct hardware control (LED blinking).

The primary goals of this project were to:
*   Understand the fundamentals of C++/Assembly interfacing.
*   Learn basic AVR Assembly instructions and the AVR GCC calling convention.
*   Explore direct hardware manipulation (port registers) as an alternative to higher-level library functions.


## Features

*   **C++ Main Application:** Drives the logic and calls Assembly functions.
*   **External Assembly Functions:**
    *   `Add(uint16_t x, uint16_t y)`: Performs 16-bit addition.
    *   `Sub(uint16_t x, uint16_t y)`: Performs 16-bit subtraction.
    *   `Mul(uint16_t x, uint16_t y)`: Performs 8-bit x 8-bit multiplication (current implementation multiplies the lower 8-bits of the 16-bit inputs).
    *   `Set_LED(uint8_t state)`: Controls the state of an LED (typically Digital Pin 13 / PB5) using direct port manipulation.
*   **Linkage:** Utilizes `extern "C"` in C++ for correct name mangling and linking with Assembly object code.
*   **Output:** Uses `Serial.println()` to display the results of arithmetic operations.

## Technologies Used

*   **Languages:** C++ (Arduino framework), AVR Assembly (GNU AS syntax)
*   **Platform:** AVR Microcontroller, Arduino Uno
*   **Toolchain:** avr-gcc (as used by the Arduino IDE or PlatformIO)

## Code Structure

### C++ (`.ino` / `.cpp` file)

*   Includes necessary headers (`Arduino.h`, `stdio.h`).
*   Declares the external Assembly functions using `extern "C"`.
*   **`setup()` function:**
    *   Initializes serial communication (`Serial.begin()`).
    *   Calls the `Add`, `Sub`, and `Mul` Assembly functions with sample values.
    *   Prints the results to the Serial Monitor.
*   **`loop()` function:**
    *   Continuously toggles an LED connected to Digital Pin 13 (PB5) using the custom `Set_LED` Assembly function.
    *   Includes `delay()` calls for visible blinking.

### Assembly (`.S` file)

*   Uses `.global` directive to export function symbols for linking.
*   **`Add:`**
    *   Implements 16-bit addition using `add` and `adc` (add with carry) instructions, following AVR GCC calling conventions for argument passing (R24:R25, R22:R23) and return value (R24:R25).
*   **`Sub:`**
    *   Implements 16-bit subtraction using `sub` and `sbc` (subtract with carry/borrow) instructions.
*   **`Mul:`**
    *   Implements 8-bit x 8-bit multiplication using the `mul` instruction. *Note: Currently, this takes two `uint16_t` arguments from C++ but only multiplies their lower 8-bit portions (r24 * r22). The 16-bit result is returned in R24:R25.*
*   **`Set_LED:`**
    *   Takes a `uint8_t` argument (HIGH/LOW) in `r24`.
    *   Sets the Data Direction Register (DDRB) for Pin PB5 (Digital Pin 13) to configure it as an output.
    *   Manipulates the `PORTB` register to set the pin HIGH or LOW.
    *   This function demonstrates direct port manipulation, which can be more efficient than the standard `digitalWrite()` abstraction by avoiding its overhead. Care is taken to use read-modify-write operations (implicitly, or should be explicitly for robustness) when setting/clearing specific bits to avoid affecting other pins on the same port.

## A Note on Register Saving

In the Assembly routines, a conservative approach to register saving (e.g., pushing and popping a wide range of registers) might be observed. While not always necessary for caller-saved registers or if a register isn't clobbered, this habit can be a safe practice during the learning phase to prevent unintended side effects, at the cost of a few extra clock cycles. As familiarity with the AVR ABI (Application Binary Interface) and calling conventions grows, register usage can be further optimized.

## Building and Running

1.  **Hardware:** An AVR-based microcontroller board (Arduino Uno).
2.  **Software:**
    *   PlatformIO with the avr-gcc toolchain.
    *   Ensure both the C++ (`.ino`) file and the Assembly (`.S`) file are part of the project and compiled/linked together.
3.  **Connection:** Connect the Arduino to your computer via USB.
4.  **Upload:** Compile and upload the sketch to the Arduino.
5.  **Monitor:** Open the Serial Monitor (baud rate 115200) to see the output from the arithmetic functions. The onboard LED (Pin 13) should blink.

## Future Considerations / Learning Path

*   Implement full 16-bit x 16-bit multiplication in Assembly.
*   Add an Assembly function for division.
*   Explore further optimizations in the Assembly code.
*   Conduct benchmarks to compare the performance of custom ASM functions versus their C++/Arduino library equivalents.

## Disclaimer

This project is for educational and learning purposes. The code is provided as-is, and while developed with the aim of correctness, it should be reviewed and tested thoroughly if considered for use in any critical applications.

---
