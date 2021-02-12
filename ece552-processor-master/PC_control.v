
module PC_control(B, C, I, F, PC_in, PC_out, taken);

input B;
input [2:0] C;
input [8:0] I;
input [2:0] F;
input [15:0] PC_in;
output [15:0] PC_out;
output taken;

//assign PC_out = PC_in + 2;
//add_16_bit adder1(.Sum(PC_out), .A(PC_in), .B(16'h0002));
//assign taken = 0;


wire [15:0] PC_twilight;
wire[15:0] PC_branch;
wire [15:0] shift;

wire N, V, Z_flag;
wire branch_taken;

assign N = F[0];
assign V = F[1];
assign Z_flag = F[2];

assign branch_taken = (C === 3'bz) ? 1'b0 : ( ((C == 3'b000) & ~Z_flag) 
                     | ((C == 3'b001) & Z_flag) 
                     | ((C == 3'b010) & ~Z_flag & ~N) 
                     | ((C == 3'b011) & N) 
                     | ((C == 3'b100) & (Z_flag | (~Z_flag & ~N))) 
                     | ((C == 3'b101) & (N | Z_flag)) 
                     | ((C == 3'b110) & V) 
                     | (C == 3'b111) ) ? 1'b1 : 1'b0;



//Sum, A, B
add_16_bit adder1(.Sum(PC_twilight), .A(PC_in), .B(16'h0002));

assign shift = {{6{I[8]}}, I[8:0], 1'b0};

add_16_bit adder2(.Sum(PC_branch), .A(PC_twilight), .B(shift));

assign PC_out = (branch_taken & B) ? PC_branch : PC_twilight;

assign taken = branch_taken;



endmodule
