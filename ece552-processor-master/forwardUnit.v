
module forwardUnit(compute, l_type, lw, P2_Rs, P2_Rt, P3_Rd, P4_Rd, P3_WB, P4_WB, forwardA, forwardB);

// Registers input for comparison
input [3:0] P2_Rs; //p2_instr[7:4]
input [3:0] P2_Rt; //p2_instr[3:0]
input [3:0] P3_Rd; //p3_instr[11:8]
input [3:0] P4_Rd; //p4_instr[11:8]

// Know if rt is valid
input compute;
input l_type;
input lw;


// Determines if the data will be written to a register
input P3_WB; //p3_compute | p3_compute_imm | p3_lw | p3_lhb | p3_llb | p3_pcs
input P4_WB; //p4_compute | p4_compute_imm | p4_lw | p4_lhb | p4_llb | p4_pcs

// 2 bit output that serves as mux select line for each ALU input
output [1:0] forwardA;
output [1:0] forwardB;

wire [3:0] P2_Rt_new;

assign P2_Rt_new = (~compute) ? 4'b0 : P2_Rt;

// forward signal is 01 when p3 ALU_Out is fowarded, and 10 when p4 DM_out is forwarded
assign forwardA = (l_type) ? 2'b00 : (~lw & P3_WB & (P2_Rs == P3_Rd)) ? 2'b01 : (P4_WB && (P2_Rs == P4_Rd)) ? 2'b10 : 2'b00;
assign forwardB = (l_type) ? 2'b00 : (~lw & P3_WB & (P2_Rt_new == P3_Rd)) ? 2'b01 : (P4_WB && (P2_Rt_new == P4_Rd)) ? 2'b10 : 2'b00;


endmodule 