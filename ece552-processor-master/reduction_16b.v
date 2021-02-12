
module reduction_16b ( A, B, Out);

input [15:0] A, B;
output [15:0] Out;

wire [3:0] ae, bf, cg, dh, abef, cdgh, final_red;
wire c1, c2, c3, c4, c5, c6, c7;
wire CSA1_c, CSA1_s, CSA2_c, CSA2_s, CSA3_c, CSA3_s, CSA4_c, CSA4_s;

wire [2:0] CSA_out;

// Sum, Ovfl, A, B, sub, carry
cla_4b a_e(.Sum(ae), .A(A[3:0]), .B(B[3:0]), .sub(1'b0), .carry(c1), .Cin(1'b0));

cla_4b b_f(.Sum(bf), .A(A[7:4]), .B(B[7:4]), .sub(1'b0), .carry(c2), .Cin(1'b0));

cla_4b c_g(.Sum(cg), .A(A[11:8]), .B(B[11:8]), .sub(1'b0), .carry(c3), .Cin(1'b0));

cla_4b d_h(.Sum(dh), .A(A[15:12]), .B(B[15:12]), .sub(1'b0), .carry(c4), .Cin(1'b0));

cla_4b ab_ef(.Sum(abef), .A(ae), .B(bf), .sub(1'b0), .carry(c5), .Cin(1'b0));

cla_4b cd_gh(.Sum(cdgh), .A(cg), .B(dh), .sub(1'b0), .carry(c6), .Cin(1'b0));

cla_4b abcd_efgh(.Sum(final_red), .A(abef), .B(cdgh), .carry(c7), .sub(1'b0), .Cin(1'b0));

// Add together carries using a series of full adders that make up a carry save adder
//full_adder_1bit(A, B, CI, S, CO)
full_adder_1bit FA1(.A(c1), .B(c2), .CI(c3), .S(CSA1_s), .CO(CSA1_c));

full_adder_1bit FA2(.A(c4), .B(c5), .CI(c6), .S(CSA2_s), .CO(CSA2_c));

full_adder_1bit FA3(.A(c7), .B(CSA1_s), .CI(CSA2_s), .S(CSA3_s), .CO(CSA3_c));

full_adder_1bit FA4(.A(CSA1_c), .B(CSA2_c), .CI(CSA3_c), .S(CSA4_s), .CO(CSA4_c));

assign CSA_out = {CSA4_c, CSA4_s, CSA3_s};

// Sign extend to 16 bits
  assign Out = {{9{1'b0}},CSA_out[2:0],final_red[3:0]};

endmodule