# async-fifo-uvm-verfication

synchronous FIFO design in Verilog with a UVM-based SystemVerilog verification environment, featuring randomized testing, SVA assertions, functional coverage, and scoreboard-based checking.

## ## Project Overview

This project implements an asynchronous FIFO in Verilog and verifies the design using SystemVerilog and UVM, including randomized testing, SVA assertions, functional coverage, and scoreboard-based checking.

The verification environment includes :
 - Constrained-random stimulus generation
  - Interface -based communication
  - Driver
  - Monitor
  - Scorebaord
  - Systemverilog Assertions
  - Functional Coverage

## Design 

The FIFO design consists of :
 -Write Controller
 -Read Controller
 -Write Pointer Synchronizer
 -Read Pointer Synchronizer
 -Dual-clock FIFO Memory

 The write controller manages data writes and the write pointer, while the read controller manages data reads and the read pointer. The pointer synchronizers safely transfer pointer information between the independent write and read clock domains.

 ## Verification Environment 

 The SystemVerilog/UVM testbench contains:
  -Write and read interfaces
  -Write and read transactions
  -Write and read sequences
  -Write and read sequencers
  -Write and read drivers
  -Write and read monitors
  -Write and read agents
  -Reset controller
  -Scoreboard
  -UVM environment and test
  -SystemVerilog Assertions (SVA)
  -Functional coverage

  ## Verification Results 

  ### 1. Scoreboard

  All randomized write/read transactions passed successfully with correct FIFO ordering verified by the scoreboard.
  <img width="1834" height="378" alt="Screenshot 2026-09-20 173350" src="https://github.com/user-attachments/assets/1c8b33a6-04a3-4b39-acfb-589184b3e542" />

  ### 2. Assertion Coverage

  Write and read controller, pointer synchronization, and FIFO memory assertions achieved 100% coverage with 0 failures.
  <img width="1164" height="612" alt="Screenshot 2026-09-23 123219" src="https://github.com/user-attachments/assets/87feeebe-8380-49d3-9958-d97538656ea4" />
  <img width="1178" height="932" alt="Screenshot 2026-09-23 123231" src="https://github.com/user-attachments/assets/a7e65b03-9391-458b-b225-079aeca30b14" />
  <img width="1246" height="648" alt="Screenshot 2026-09-23 123241" src="https://github.com/user-attachments/assets/106f287b-ceed-433e-afd9-aec0b2f93428" />
  <img width="1248" height="870" alt="Screenshot 2026-09-23 123251" src="https://github.com/user-attachments/assets/b28d4ddc-e885-42e9-ab4f-6e3f92e8a486" />
  <img width="1162" height="670" alt="Screenshot 2026-09-23 123302" src="https://github.com/user-attachments/assets/f1fdc6e1-99f4-44ec-a008-acb72b281ad0" />
  <img width="1122" height="656" alt="Screenshot 2026-09-23 123323" src="https://github.com/user-attachments/assets/7ad764a5-fc31-447e-8ee1-a2078c7978ad" />

### 3. Functional Coverage 

Constrained-random testing was used to exercise both write and read operations. Coverage analysis identified uncovered corner cases, including write_enable = 1 while wr_full = 1 on the write side and read_enable = 1 while rd_empty = 1 on the read side. Since constrained-random stimulus did not naturally hit these combinations, directed stimulus was introduced to intentionally target the uncovered bins. This achieved 100% functional coverage across the write and read scenarios.
<img width="2382" height="350" alt="Screenshot 2026-09-20 192507" src="https://github.com/user-attachments/assets/2ab2995c-2c71-4ca9-820a-8a60380888e5" />
<img width="2386" height="176" alt="Screenshot 2026-09-20 193930" src="https://github.com/user-attachments/assets/1d7672db-1374-48c1-a4ba-b959b54fd880" />

Constrained-random testing achieved 91.67% functional coverage.
<img width="2414" height="642" alt="Screenshot 2026-09-20 194355" src="https://github.com/user-attachments/assets/6be09c5e-a7bf-4ad2-b6c5-31a410c59a28" />

### 4. FIFO Waveform

The one-cycle offset between raddr and rdata is due to the non-blocking assignment in the registered read logic; rdata is updated after the clock edge in the NBA region, so it corresponds to the previous read address while raddr may already reflect the next address.
<img width="2758" height="502" alt="Screenshot 2026-09-23 133225" src="https://github.com/user-attachments/assets/576ada84-d892-485d-a06d-7db9e0a54918" />








  

  



  
