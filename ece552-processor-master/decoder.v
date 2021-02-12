
module decoder(opcode, compute, compute_imm, LW, SW, LHB, LLB, B, BR, PCS, HLT);

input [3:0] opcode;
output compute, compute_imm, LW, SW, LHB, LLB, B, BR, PCS, HLT;

localparam ADD_op = 4'b0000;
localparam SUB_op = 4'b0001;
localparam RED_op = 4'b0010;
localparam XOR_op = 4'b0011;
localparam SLL_op = 4'b0100; //compute_imm
localparam SRA_op = 4'b0101; //compute_imm
localparam ROR_op = 4'b0110; //compute_imm
localparam PADDSB_op = 4'b0111;

localparam LW_op = 4'b1000;
localparam SW_op = 4'b1001;
localparam LHB_op = 4'b1010;
localparam LLB_op = 4'b1011;
localparam B_op = 4'b1100;
localparam BR_op = 4'b1101;
localparam PCS_op = 4'b1110;
localparam HLT_op = 4'b1111;

assign compute = ((opcode == ADD_op) | (opcode == SUB_op) | (opcode == RED_op) | (opcode == XOR_op) | (opcode == PADDSB_op)) ? 1'b1 : 1'b0;
assign compute_imm = ((opcode == SLL_op) | (opcode == SRA_op) | (opcode == ROR_op)) ? 1'b1 : 1'b0;
assign LW = (opcode == LW_op) ? 1'b1 : 1'b0;
assign SW = (opcode == SW_op) ? 1'b1 : 1'b0;
assign LHB = (opcode == LHB_op) ? 1'b1 : 1'b0;
assign LLB = (opcode == LLB_op) ? 1'b1 : 1'b0;
assign B = (opcode == B_op) ? 1'b1 : 1'b0;
assign BR = (opcode == BR_op) ? 1'b1 : 1'b0;
assign PCS = (opcode == PCS_op) ? 1'b1 : 1'b0;
assign HLT = (opcode == HLT_op) ? 1'b1 : 1'b0;


endmodule
