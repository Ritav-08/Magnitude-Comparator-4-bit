# 📘 4-bit Magnitude Comparator – Verilog

## 🔹 Overview

This project implements a **4-bit Magnitude Comparator** in Verilog along with its testbench.
The comparator compares two 4-bit inputs and determines whether:

* A > B
* A < B
* A = B

It also includes **robust unknown (`X`) state handling**, making it reliable during simulation.

---

## 🔹 Features

* Compares two 4-bit inputs
* Outputs three comparison conditions:

  * Greater than (A > B)
  * Less than (A < B)
  * Equal to (A = B)
* Detects unknown (`X`) values using reduction XOR (`^`)
* Fully combinational logic (`always @(*)`)

---

## 🔹 Module Description

### 📌 Inputs

* `a_i [3:0]` → First 4-bit operand
* `b_i [3:0]` → Second 4-bit operand

### 📌 Outputs

* `A_o` → High when A > B
* `B_o` → High when B > A
* `AB_o` → High when A = B

---

## 🔹 Working Principle

The comparator operates as follows:

### 🔸 X Detection

* Uses reduction XOR:

  ```
  ^a_i or ^b_i
  ```
* If any bit is unknown (`X`), outputs become:

  ```
  A_o = X, B_o = X, AB_o = X
  ```

### 🔸 Comparison Logic

* **A > B**

  ```
  A_o = 1, B_o = 0, AB_o = 0
  ```
* **B > A**

  ```
  A_o = 0, B_o = 1, AB_o = 0
  ```
* **A = B**

  ```
  A_o = 0, B_o = 0, AB_o = 1
  ```

---

## 🔹 Testbench Details

The testbench (`tb_magComp4b`) verifies multiple scenarios:

| Test Case | A    | B    | Description             |
| --------- | ---- | ---- | ----------------------- |
| 1         | 0000 | 0000 | All zeros               |
| 2         | 0000 | 1000 | A < B                   |
| 3         | 0100 | 0000 | A > B                   |
| 4         | 0010 | 0010 | Equal                   |
| 5         | 1000 | 0110 | A > B                   |
| 6         | 0011 | 0100 | A < B                   |
| 7         | xxxx | 1101 | A unknown               |
| 8         | 00x0 | 0010 | Partial unknown in A    |
| 9         | 00x0 | xx00 | Unknowns in both inputs |
| 10        | 0x00 | 0x00 | Same unknown pattern    |
| 11        | 1111 | 1111 | Maximum equal           |

---

## 🔹 Simulation

### ▶️ Tools

* ModelSim / QuestaSim
* Xilinx Vivado
* Icarus Verilog + GTKWave

### ▶️ Run (Icarus Verilog Example)

```bash
iverilog -o magComp4b.vvp magComp4b.v tb_magComp4b.v
vvp magComp4b.vvp
gtkwave magComp4b.vcd
```

---

## 🔹 Output

* Console output using `$monitor`
* Waveform dump file:

  ```
  magComp4b.vcd
  ```

---

## 🔹 Sample Output Format

```
Time: 10 | A: 8, B: 6 | A>B: 1, A=B: 0, A<B: 0
```

> ⚠️ Note: Some simulators may not display unknown (`X`) values correctly with `%d`.
> Use `%b` if needed for accurate bit-level visualization.

---

## 🔹 Applications

* Digital comparators in ALUs
* Sorting and priority circuits
* Decision-making logic in processors
* Control systems and data path operations

---

## 🔹 File Structure

```
├── magComp4b.v        # Comparator Design
├── tb_magComp4b.v     # Testbench
├── magComp4b.vcd      # Waveform output (generated)
└── README.txt         # Documentation
```
