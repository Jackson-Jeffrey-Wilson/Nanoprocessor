# 4-bit Nanoprocessor — CS1050 Digital Design Project

A 4-bit nanoprocessor designed and implemented in **VHDL**, deployed on the **Digilent BASYS3** FPGA board.  
Developed as part of the *CS1050 Computer Organization and Digital Design* lab at the University of Moratuwa.

---

## 📌 Overview

This project implements a simple but complete nanoprocessor capable of:
- Fetching instructions from ROM  
- Decoding instructions  
- Executing operations via ALU  

Two versions are included:
- **Basic Version** — core lab requirements  
- **Advanced Version** — includes 4 additional hardware features  

---

## 🧠 Instruction Set

| Opcode | Instruction | Operation |
|--------|------------|----------|
| `10` | MOVI R, d | Load immediate value into register |
| `00` | ADD Ra, Rb | Add registers → store in Ra |
| `01` | NEG R | 2's complement negation |
| `11` | JZR R, d | Jump if register = 0 |

- Instruction width: **12 bits**
- Stored in: **Program ROM**

---

## 🧩 Components

| Component | Description |
|----------|------------|
| Program_ROM | 8 × 12-bit instruction memory |
| Program_Counter | 3-bit counter with reset |
| Adder_3_Bit | PC increment logic |
| Instruction_Decoder | Generates control signals |
| Register_Bank | 8 × 4-bit registers (R0 = 0) |
| Add_Sub_Unit | 4-bit ALU (Add/Sub + flags) |
| MUX_8_way_4_Bit | Operand selection |
| MUX_2_way_4_Bit | ALU vs Immediate |
| MUX_2_way_3_Bit | PC vs Jump |
| LUT_16_7 | Hex → 7-segment decoder |
| Slow_Clk | Clock divider (~0.67s per instruction) |

---

## 🧪 Basic Version — Lab Task

### Program
```assembly
MOVI R7, 1
MOVI R5, 2
MOVI R4, 3
ADD  R7, R5
ADD  R7, R4
````

### Execution Flow

```
1 → 3 → 6 → (repeat)
```

### Final Result

* **R7 = 6**
* Displayed on:

  * LEDs (binary)
  * 7-segment display (hex)

---

## 🔌 BASYS3 Mapping (Basic)

### LEDs

| LED     | Function           |
| ------- | ------------------ |
| LD0–LD3 | R7 (binary output) |
| LD14    | Zero flag          |
| LD15    | Overflow flag      |

### 7-Segment

* Displays **R7 value**
* Active digit: rightmost
* Active LOW configuration

---

## 🚀 Advanced Version — Additional Features

### Features

| Feature            | Description                         |
| ------------------ | ----------------------------------- |
| Comparator         | Equal / Less / Greater              |
| Multiplier         | 4-bit multiplication + overflow     |
| Parity Generator   | Even / Odd detection                |
| Magnitude Detector | Zero / Small / Large classification |

---

## 🧪 Advanced Demo Program

| Addr | Instruction | Result |
| ---- | ----------- | ------ |
| 0    | MOVI R7,3   | 3      |
| 1    | MOVI R2,3   | 3      |
| 2    | MUL R7,R2   | 9      |
| 3    | MOVI R3,5   | 9      |
| 4    | MOVI R4,2   | 9      |
| 5    | ADD R3,R4   | 9      |
| 6    | NEG R7      | 7      |
| 7    | JZR R0,0    | Loop   |

### Execution Cycle

```
3 → 9 → 7 → repeat
```

### Key Observations

* **3 → 9** → Multiplier works (3 × 3 = 9)
* **9 → 7** → NEG works (−9 in 4-bit = 7)

---

## 🔌 BASYS3 Mapping (Advanced)

| LEDs    | Description               |
| ------- | ------------------------- |
| LD0–LD3 | R7 value                  |
| LD4     | ALU Overflow              |
| LD5     | ALU Zero                  |
| LD6–LD8 | Comparator (Eq / Lt / Gt) |
| LD9     | Even Parity               |
| LD10    | Odd Parity                |
| LD11    | Is Zero                   |
| LD12    | Is Small (1–7)            |
| LD13    | Is Large (8–15)           |
| LD14    | Multiplier Overflow       |
| LD15    | Multiplier Result (bit 0) |

---

## 🔍 Feature Verification

### Comparator

* Example: `5 > 2`
* LD8 (Greater) ON

### Multiplier

* `3 × 3 = 9`
* LD15 ON (bit0 = 1)

### Parity

* 9 (1001) → Even
* 7 (0111) → Odd

### Magnitude

* 0 → Zero
* 3 → Small
* 9 → Large

---

## 🛠 Tools

* **Vivado 2025.2**
* **VHDL**
* **Digilent BASYS3**

---

## 👥 Team

| Member               | 
| -----------------    | 
| Jayasekara J.P.D.N.R |
| Jackson J.W.         |
| Isaiyalan K.         |
| Jathursanan S.       |

---

## 📎 Notes

* All operations are **4-bit limited**
* Overflow and wrapping may occur
* Program runs in an **infinite loop** (no HALT instruction)

---

## ⭐ Summary

This project demonstrates a complete working nanoprocessor with:

* Instruction execution pipeline
* ALU operations
* Hardware extensions
* Real FPGA deployment

---
