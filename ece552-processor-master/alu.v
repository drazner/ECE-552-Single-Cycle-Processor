
module alu(opcode, A, B, ALU_out, flags);

input [3:0] opcode;
input [15:0] A;
input [15:0] B;
output [15:0] ALU_out;
output [2:0] flags;

localparam ADD = 4'b0000;
localparam SUB = 4'b0001;
localparam RED = 4'b0010;
localparam XOR = 4'b0011;
localparam SLL = 4'b0100;
localparam SRA = 4'b0101;
localparam ROR = 4'b0110;
localparam PADDSB_op = 4'b0111;

localparam LW = 4'b1000;
localparam SW = 4'b1001;

//flags
wire N, V, Z_flag;
assign flags[0] = N;
assign flags[1] = V;
assign flags[2] = Z_flag;


//ADD
//cla_16b(Sum, Ovfl, A, B, sub);
wire [15:0] cla_output;
wire [15:0] ADD_sum;
wire ADD_Ovfl;
wire ADD_sub;
assign ADD_sub = (opcode == SUB) ? 1'b1 : 1'b0;
//add_16_bit add_sub_add(.Sum(ADD_sum), .A(A), .B(B));
cla_16b add_sub_cla(.Sum(cla_output), .Ovfl(ADD_Ovfl), .A(A), .B(B), .sub(ADD_sub));

assign ADD_sum = (~ADD_sub) ? ADD_Ovfl ? (cla_output[15] == 1'b0 ? 16'h7FFF : 16'h8000): cla_output :
			ADD_Ovfl ? (cla_output[15] == 1'b1 ? 16'h7FFF : 16'h8000): cla_output; //overflow saturation

//shifter SH 
wire [15:0] SH_out;
wire SH_mode;
assign SH_mode = (opcode == SRA) ? 1'b0 : 1'b1; //mode 1 => SLL ; mode 0 => SRA

//instantiate shifter
Shifter alu_shifter(.Shift_Out(SH_out), .Shift_In(A), .Shift_Val(B[3:0]), .Mode(SH_mode));

//Parallel Add PA
//PADDSB(Sum, Overflow, A, B); 
wire [15:0] PA_result;
PADDSB PA(.Sum(PA_result), .A(A), .B(B));

//Reduction RED
//reduction_16b (A, B, Out)
wire [15:0] RED_result;
reduction_16b alu_RED(.A(A), .B(B), .Out(RED_result));


//ROR
//ROR(result, A, imm)
wire [15:0] ROR_result;
ROR alu_ROR(.result(ROR_result), .A(A), .imm(B[3:0]));


//set flags
assign V = ((opcode == ADD) | (opcode == SUB)) ? ADD_Ovfl : 1'bz;
assign N = ((opcode == ADD) | (opcode == SUB)) ? (ADD_sum[15] == 1) ? 1'b1 : 1'b0 : 1'bz;
assign Z_flag = ((opcode == ADD) | (opcode == SUB)) ? (ADD_sum == 0) ? 1'b1 : 1'b0 : (opcode == XOR) ? ((A ^ B) == 0) ? 1'b1 : 1'b0 : 
	   (opcode == SLL) ? (SH_out == 0) ? 1'b1 : 1'b0 : (opcode == SRA) ? (SH_out == 0) ? 1'b1 : 1'b0 : 
	   (opcode == ROR) ? (ROR_result == 0) ? 1'b1 : 1'b0 : 1'bz;


//set ALU_out
assign ALU_out = (opcode == ADD) ? ADD_sum : (opcode == SUB) ? ADD_sum : 
		 (opcode == SW) ? ADD_sum : (opcode == LW) ? ADD_sum :
		 (opcode == RED) ? RED_result : (opcode == XOR) ? (A ^ B) : 
		 (opcode == SLL) ? SH_out : (opcode == SRA) ? SH_out :
		 (opcode == ROR) ? ROR_result : (opcode == PADDSB_op) ? PA_result : 16'b0;

		 


endmodule