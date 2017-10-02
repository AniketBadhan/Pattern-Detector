# Pattern-Detector
Understanding the different styles of FSMs for pattern detection.

A single FSM module to find the a pattern of an 8-bit input stream – the characters “bomb” (98,111,109, 98) – and produce an output signal when an end ’b’ is found within an instance the pattern. 
Once an end ’b’ in the a pattern is found, the output signal stays high until the input ack signal goes from low to high.
FSM should not start searching for the pattern again, until ack signal goes low.

a) Two always block style with combinational outputs. Files - PatternDetector1.sv, PatternDetector1_tb.sv, input_data.txt
b) One sequential always block style with registered outputs. Files - PatternDetector2.sv, PatternDetector2_tb.sv, input_data2.txt
c) Three always block style with registered outputs. Files - PatternDetector3.sv, PatternDetector3_tb.sv, input_data3.txt
d) Two always block style with combinational outputs. Files - PatternDetector4.sv, PatternDetector4_tb.sv, input_data4.txt
