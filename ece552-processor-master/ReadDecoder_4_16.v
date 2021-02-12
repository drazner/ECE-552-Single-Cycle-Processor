
module ReadDecoder_4_16(RegId, Wordline);

input [3:0] RegId;
output [15:0] Wordline;

assign Wordline[0] = (RegId == 4'b0000) ? 1 : 0;
assign Wordline[1] = (RegId == 4'b0001) ? 1 : 0;
assign Wordline[2] = (RegId == 4'b0010) ? 1 : 0;
assign Wordline[3] = (RegId == 4'b0011) ? 1 : 0;
assign Wordline[4] = (RegId == 4'b0100) ? 1 : 0;
assign Wordline[5] = (RegId == 4'b0101) ? 1 : 0;
assign Wordline[6] = (RegId == 4'b0110) ? 1 : 0;
assign Wordline[7] = (RegId == 4'b0111) ? 1 : 0;
assign Wordline[8] = (RegId == 4'b1000) ? 1 : 0;
assign Wordline[9] = (RegId == 4'b1001) ? 1 : 0;
assign Wordline[10] = (RegId == 4'b1010) ? 1 : 0;
assign Wordline[11] = (RegId == 4'b1011) ? 1 : 0;
assign Wordline[12] = (RegId == 4'b1100) ? 1 : 0;
assign Wordline[13] = (RegId == 4'b1101) ? 1 : 0;
assign Wordline[14] = (RegId == 4'b1110) ? 1 : 0;
assign Wordline[15] = (RegId == 4'b1111) ? 1 : 0;

endmodule 