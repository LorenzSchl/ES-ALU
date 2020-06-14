# Kennzahlen
Im Folgenden werden verschiedene Kennzahlen der ALU dargestellt. 

## Timing Results
Das Xilinx ISE produziert nach dem Implementieren des Designs eine Übersicht über einige Timing-Werte des Moduls. Diese sind:

|Beschreibung|Wert|
|------------|----|
|Minimum period|1.721 ns|
|Maximum Frequency|581.125 MHz|
|Minimum input arrival time before clock|6.145 ns|
|Maximum output required time after clock|3.806 ns|
|Maximum combinational path delay|6.567 ns|

## Design Summary
|Beschreibung|Wert|
|-|-|
|Target Device|xc4vfx12-12sf363|
|Speed|-12|

### Device Utilization Summary
|Logic Utilization|Used|Available|Utilization|
|-|-|-|-|
|Total Number Slice Registers|25|10,944|1%|
|Number used as Flip Flops|9|
|Number used as Latches|16|
|Number of 4 input LUTs|132|10,944|1%|
|Number of occupied Slices|69|5,472|1%|
|Number of Slices containing only related logic|69|69|100%|
|Number of Slices containing unrelated logic|0|69|0%|
|Total Number of 4 input LUTs|132|10,944|1%|
|Number of bonded IOBs|39|240|16%|
|IOB Flip Flops|8|
|Number of BUFG/BUFGCTRLs|1|32|3%|
|Number used as BUFGs|1|
|Number of DSP48s|1|32|3%|
|Average Fanout of Non-Clock Nets|3.24|

## Power Summary
|On-Chip|Power(W)|Used|Available|Utilization(%)|
|-|-|-|-|-|
|Clocks|0.006|3|--|--|
|Logic|0.000|132|10944|1|
|Signals|0.000|163|--|--|
|DSPs|0.000|1|32|3|
|DCMs|0.000|0|4|0|
|IOs|0.000|39|240|16|
|Leakage|0.167|
> Total Power 0.173W

## Temperatur-Eigenschaften
* Effective TJA (C/W): 14.7
* Max Ambient (C): 82.5
* Junction Temp: 52.5