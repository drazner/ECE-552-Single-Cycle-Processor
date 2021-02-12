
module cla_16b(Sum, Ovfl, A, B, sub);

input [15:0] A;
input [15:0] B;
input sub;
output [15:0] Sum;
output Ovfl;

//negating 15:4 && asserting sub for least significant cla
wire [15:4] B_mod_upper;
assign B_mod_upper = (sub) ? ~B[15:4] : B[15:4];

wire P0, G0, P1, G1, P2, G2, P3, G3;
wire Cin0, Cin1, Cin2, Cin3;

assign Cin0 = 1'b0;
assign Cin1 = (G0) ? 1'b1 : (P0 & sub) ? 1'b1 : 1'b0;
assign Cin2 = (G1) ? 1'b1 : (P1 & G0) ? 1'b1 : (P1 & P0 & sub) ? 1'b1 : 1'b0;
assign Cin3 = (G2) ? 1'b1 : (P2 & G1) ? 1'b1 : (P2 & P1 & G0) ? 1'b1 : (P2 & P2 & P1 & P0 & sub) ? 1'b1 : 1'b0;

//cla_4b(Sum, Ovfl, A, B, sub, carry, P, G);
cla_4b cla0(.Sum(Sum[3:0]), .A(A[3:0]), .B(B[3:0]), .sub(sub), .P(P0), .G(G0), .Cin(Cin0));
cla_4b cla1(.Sum(Sum[7:4]), .A(A[7:4]), .B(B_mod_upper[7:4]), .sub(1'b0), .P(P1), .G(G1), .Cin(Cin1));
cla_4b cla2(.Sum(Sum[11:8]), .A(A[11:8]), .B(B_mod_upper[11:8]), .sub(1'b0), .P(P2), .G(G2), .Cin(Cin2));
cla_4b cla3(.Sum(Sum[15:12]), .A(A[15:12]), .B(B_mod_upper[15:12]), .sub(1'b0), .P(P3), .G(G3), .Cin(Cin3));

assign Ovfl = (~sub) ? ((A[15] & B[15] & ~Sum[15]) | (~A[15] & ~B[15] & Sum[15])) ? 1'b1 : 1'b0 :
		((A[15] & ~B[15] & ~Sum[15]) | (~A[15] & B[15] & Sum[15])) ? 1'b1 : 1'b0;


endmodule
