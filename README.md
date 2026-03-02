# 32bit-fifo_synchronous-verilog
Verilog HDL implementation of a 32-bit FIFO (First-In First-Out) buffer with testbench and waveform verification. Includes parameterized depth, collision handling, and simulation results.
# FIFO Verilog Design

A Verilog HDL implementation of a 32-bit FIFO (First-In First-Out) buffer with testbench and waveform verification.

## 🧩 Project Overview
This project implements a synchronous FIFO design that allows data buffering between producer and consumer systems. The FIFO is 32 bits wide and includes full and empty flag handling, as well as collision protection.

## ⚙️ Features
- 32-bit data width
- Configurable FIFO depth
- Write and read enable controls
- Full and empty status flags
- Testbench included for simulation
- Compatible with ModelSim, Vivado, and EDA Playground

## 🧠 Design Files
| File | Description |
|------|--------------|
| `fifo.v` | Verilog module for FIFO logic |
| `fifo_tb.v` | Testbench for verifying FIFO behavior |
| `waveform.png` | Example waveform output |

## 🚀 How to Run Simulation
1. Open ModelSim or EDA Playground.
2. Add both `fifo.v` and `fifo_tb.v` files.
3. Compile and run the simulation.
4. Observe the waveform to verify correct FIFO operation.

## 🧾 Example Output
- When writing to FIFO, data is stored until full.
- When reading, the oldest data is output first.
- `full` and `empty` flags indicate buffer status.

## 👩‍💻 Author
**Vaishnavi G H**  
Electronics & Communication Engineering  
Design and Verification Engineer aspirant  

---

🟢 *This project demonstrates core concepts of digital design and verification using Verilog HDL.*
