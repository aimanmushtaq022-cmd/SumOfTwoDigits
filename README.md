# Sum of Two Decimal Digits

This repository contains an **8086 Assembly language program** that accepts two decimal digits from the user, adds them, and displays the sum.

---

## Program Objective

1. Display prompt: `"Enter two digits:"`
2. Accept **two decimal digits** from the keyboard
3. Convert ASCII input to numeric values
4. Add the two digits
5. Display the result in the format:  

---

## Registers Used

| Register | Purpose |
|----------|---------|
| AX       | Accumulator (16-bit) for arithmetic and DOS functions |
| AH       | High byte of AX; stores DOS function number |
| AL       | Low byte of AX; stores input/output characters |
| CL       | Stores first digit (numeric) |
| CH       | Stores second digit (numeric) |
| BL       | Stores numeric sum |
| DX       | Holds address of string for display |
| DL       | Character to output |
| DS       | Data segment pointer |

---

## DOS Functions Used (INT 21H)

| AH | Function |
|----|----------|
| 01H | Input single character |
| 02H | Display single character |
| 09H | Display string (ends with `$`) |
| 4CH | Terminate program |

---

## File

- `xxyz.asm` – Main program file containing the 8086 Assembly code

---

## How to Run

1. Open the `xxyz.asm` file in **EMU8086** emulator
2. Compile and run the program
3. Follow on-screen prompts to enter two digits
4. Program displays the sum of the digits

---

