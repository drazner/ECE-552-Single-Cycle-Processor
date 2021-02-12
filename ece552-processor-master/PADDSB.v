module PADDSB(Sum, A, B); 

input[15:0] A, B; 

output[15:0] Sum; 

//Temp wires for carrying out logic
wire[3:0] sum0, sum1, sum2, sum3; 
wire overflow0, overflow1, overflow2, overflow3; 
wire [3:0] sat0, sat1, sat2, sat3; 

//Four half byte additions in parallel
//Saturate negative overflow of each to -2^3  =  0x8 
//Saturate positive overflow of each to 2^3-1 =  0x7


//use cla_4b to perform parallel additions
cla_4b add0(.Sum(sum0), .Ovfl(overflow0), .A(A[3:0]), .B(B[3:0]), .sub(1'b0), .Cin(1'b0));
cla_4b add1(.Sum(sum1), .Ovfl(overflow1), .A(A[7:4]), .B(B[7:4]), .sub(1'b0), .Cin(1'b0));
cla_4b add2(.Sum(sum2), .Ovfl(overflow2), .A(A[11:8]), .B(B[11:8]), .sub(1'b0), .Cin(1'b0));
cla_4b add3(.Sum(sum3), .Ovfl(overflow3), .A(A[15:12]), .B(B[15:12]), .sub(1'b0), .Cin(1'b0));

//Saturate each addition
//If there is overflow -> (if positive, set to 0x7, else set to 0x8) else keep as is
assign sat0 = overflow0 ? (sum0[3] == 1'b0 ? 4'b0111 : 4'b1000): sum0; 
assign sat1 = overflow1 ? (sum1[3] == 1'b0 ? 4'b0111 : 4'b1000): sum1; 
assign sat2 = overflow2 ? (sum2[3] == 1'b0 ? 4'b0111 : 4'b1000): sum2; 
assign sat3 = overflow3 ? (sum3[3] == 1'b0 ? 4'b0111 : 4'b1000): sum3; 


//return sat(sum3),sat(sum2),sat(sum1),sat(sum0)
assign Sum = {sat3, sat2, sat1, sat0};


endmodule 
