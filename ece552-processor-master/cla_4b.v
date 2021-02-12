
module cla_4b(Sum, Ovfl, A, B, sub, carry, P, G, Cin);

input [3:0] A, B;
input sub;
input Cin;
output [3:0] Sum;
output Ovfl;
output carry; //unnecessary?
output P; //propogate
output G; //generate

wire [3:0] B_mod;
wire [3:0] CO;


assign B_mod = (sub) ? ~B : B;


assign CO[0] = (sub) ? sub : Cin;
//g0 + p0co
assign CO[1] = ((A[0] & B_mod[0]) | ((A[0] ^ B_mod[0]) & CO[0])) ? 1'b1 : 1'b0;
//g1 + p1g0 + p1p0c0
assign CO[2] = ((A[1] & B_mod[1]) | ((A[1] ^ B_mod[1]) & CO[1])) ? 1'b1 : 1'b0;
//g2 + p2g1 + p2p1g0 + p2p1p0c0
assign CO[3] = ((A[2] & B_mod[2]) | ((A[2] ^ B_mod[2]) & CO[2])) ? 1'b1 : 1'b0;
//g3 + p3g2 + p3p2g1 + p3p2p1g0 + p3p2p1p0c0
assign carry = ((A[3] & B_mod[3]) | ((A[3] ^ B_mod[3]) & CO[3])) ? 1'b1 : 1'b0;

assign P = (A[3] ^ B_mod[3]) & (A[2] ^ B_mod[2]) & (A[1] ^ B_mod[1]) & (A[0] ^ B_mod[0]); //p3p2p1p0
//g3 + p3g2 + p3p2g1 + p3p2p1g0
assign G = ((A[3] & B_mod[3]) | ((A[3] ^ B_mod[3]) & ((A[2] & B_mod[2]) | ((A[2] ^ B_mod[2]) & ((A[1] & B_mod[1]) | ((A[1] ^ B_mod[1]) & (A[0] & B_mod[0]))))))) ? 1'b1 : 1'b0;

//full_adder_1bit(A, B, CI, S, CO)
full_adder_1bit FA0(.A(A[0]), .B(B_mod[0]), .CI(CO[0]), .S(Sum[0]), .CO());
full_adder_1bit FA1(.A(A[1]), .B(B_mod[1]), .CI(CO[1]), .S(Sum[1]), .CO());
full_adder_1bit FA2(.A(A[2]), .B(B_mod[2]), .CI(CO[2]), .S(Sum[2]), .CO());
full_adder_1bit FA3(.A(A[3]), .B(B_mod[3]), .CI(CO[3]), .S(Sum[3]), .CO());

assign Ovfl = ((A[3] & B_mod[3] & ~Sum[3]) | (~A[3] & ~B_mod[3] & Sum[3])) ? 1'b1 : 1'b0;


endmodule
