
module full_adder_1bit(A, B, CI, S, CO);

input A, B, CI;
output S, CO;
wire n1, n2, n4;

//S = A or B or CI;
//CO = (A and B) or (B and CI) or (A and CI);

xor xor1(n1, A, B);
xor xor2(S, CI, n1);
and a1(n3, A, B);
and a2(n2, CI, n1);
or or1(CO, n3, n2);

endmodule


