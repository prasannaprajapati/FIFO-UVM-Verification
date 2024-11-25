
# FIFO UVM Verification Project

This repository contains a Universal Verification Methodology (UVM) environment for verifying a synchronous FIFO (First-In, First-Out) design. The FIFO circuit stores data in the order it is received and outputs it in the same order, ensuring smooth data flow between different parts of a system. This verification environment thoroughly tests all core functionalities of the FIFO, including read/write operations, full and empty conditions, and reset behavior.

---

## Project Overview

### FIFO Design Description
A FIFO is a memory-based circuit with the following characteristics:
- **Data Flow:** Data is stored and retrieved in a first-in, first-out order.
- **Synchronization:** Operations are synchronized using a clock signal.
- **Control Signals:**  
  - **Write Pointer:** Manages data entry.  
  - **Read Pointer:** Manages data retrieval.  
  - **Full/Empty Flags:** Indicate FIFO status.  
  - **Reset Signal:** Clears the memory and resets pointers.

This design is essential for managing data flow between different system modules, ensuring efficient and ordered data transfer.

## TB Architecture 

---

## Features Verified

1. **Basic Read/Write Operations:**  
   Ensure data integrity during standard operations.

2. **Full and Empty Conditions:**  
   Verify the correctness of `full` and `empty` flags under different conditions.

3. **Reset Behavior:**  
   Confirm that the FIFO resets correctly, clearing all data and resetting pointers.

4. **Pointer Management:**  
   Test correct functioning and wraparound of read/write pointers.

5. **Stress Testing:**  
   Assess performance and reliability during continuous read/write cycles.

---

## RTL Specifications

- **Data Width:** 8 bits  
- **Depth:** 16 entries  
- **Clock Domain:** Single, synchronous  
- **Control Signals:**  
  - **Read Enable (rd_en)**  
  - **Write Enable (wr_en)**  
- **Status Indicators:** Full and empty flags  
- **Pointer Size:** 5-bit read/write pointers (4-bit addressing, 1-bit wrap control)  

---

## Verification Environment Components

### Testbench Structure:
- **Driver & Sequencer:** Generates and sends test stimuli to the DUT (Design Under Test).  
- **Monitor:** Captures and logs transactions for analysis.  
- **Scoreboard:** Compares actual and expected outputs, ensuring data integrity.  
- **Coverage Collector:** Monitors functional and code coverage metrics.  

### Test Cases:
- Basic functionality checks
- Overflow and underflow conditions
- Reset verification
- Pointer wraparound testing
- Continuous operation (stress test)

---

## Getting Started

### Prerequisites:
- **UVM Framework:** Installed and configured in your simulation environment.  
- **Simulation Tools:** Mentor QuestaSim, Synopsys VCS, or any UVM-compatible simulator.  

### Running the Tests:
1. Clone the repository:
   ```bash
   git clone https://github.com/<your_username>/fifo_uvm_verification.git
   ```
2. Set up your UVM environment.
3. Compile the testbench and RTL files.
4. Run the simulation:
   ```bash
   make run
   ```

---

## Contributing
Contributions and feedback are welcome! Feel free to submit issues or pull requests.

---

## License
This project is licensed under the MIT License. See the LICENSE file for more information.

---

### Contact
For questions or support, please reach out to [your_email@example.com].
