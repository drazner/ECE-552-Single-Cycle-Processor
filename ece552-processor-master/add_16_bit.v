
module add_16_bit(Sum, A, B);

input [15:0] A, B;
output [15:0] Sum;
wire[15:0] CO;

full_adder_1bit FA0 (.A(A[0]), .B(B[0]), .CI(1'b0), .S(Sum[0]), .CO(CO[0]));
full_adder_1bit FA1 (.A(A[1]), .B(B[1]), .CI(CO[0]), .S(Sum[1]), .CO(CO[1]));
full_adder_1bit FA2 (.A(A[2]), .B(B[2]), .CI(CO[1]), .S(Sum[2]), .CO(CO[2]));
full_adder_1bit FA3 (.A(A[3]), .B(B[3]), .CI(CO[2]), .S(Sum[3]), .CO(CO[3]));

full_adder_1bit FA4 (.A(A[4]), .B(B[4]), .CI(CO[3]), .S(Sum[4]), .CO(CO[4]));
full_adder_1bit FA5 (.A(A[5]), .B(B[5]), .CI(CO[4]), .S(Sum[5]), .CO(CO[5]));
full_adder_1bit FA6 (.A(A[6]), .B(B[6]), .CI(CO[5]), .S(Sum[6]), .CO(CO[6]));
full_adder_1bit FA7 (.A(A[7]), .B(B[7]), .CI(CO[6]), .S(Sum[7]), .CO(CO[7]));

full_adder_1bit FA8 (.A(A[8]), .B(B[8]), .CI(CO[7]), .S(Sum[8]), .CO(CO[8]));
full_adder_1bit FA9 (.A(A[9]), .B(B[9]), .CI(CO[8]), .S(Sum[9]), .CO(CO[9]));
full_adder_1bit FA10 (.A(A[10]), .B(B[10]), .CI(CO[9]), .S(Sum[10]), .CO(CO[10]));
full_adder_1bit FA11 (.A(A[11]), .B(B[11]), .CI(CO[10]), .S(Sum[11]), .CO(CO[11]));

full_adder_1bit FA12 (.A(A[12]), .B(B[12]), .CI(CO[11]), .S(Sum[12]), .CO(CO[12]));
full_adder_1bit FA13 (.A(A[13]), .B(B[13]), .CI(CO[12]), .S(Sum[13]), .CO(CO[13]));
full_adder_1bit FA14 (.A(A[14]), .B(B[14]), .CI(CO[13]), .S(Sum[14]), .CO(CO[14]));
full_adder_1bit FA15 (.A(A[15]), .B(B[15]), .CI(CO[14]), .S(Sum[15]), .CO(CO[15]));

endmodule
