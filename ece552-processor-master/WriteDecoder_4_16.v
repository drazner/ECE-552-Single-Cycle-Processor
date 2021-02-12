
module WriteDecoder_4_16(RegId, WriteReg, Wordline);

input [3:0] RegId;
input WriteReg;
output [15:0] Wordline;

assign Wordline[0] = (WriteReg) ? ((RegId == 4'b0000) ? 1 : 0) : 0;
assign Wordline[1] = (WriteReg) ? ((RegId == 4'b0001) ? 1 : 0) : 0;
assign Wordline[2] = (WriteReg) ? ((RegId == 4'b0010) ? 1 : 0) : 0;
assign Wordline[3] = (WriteReg) ? ((RegId == 4'b0011) ? 1 : 0) : 0;
assign Wordline[4] = (WriteReg) ? ((RegId == 4'b0100) ? 1 : 0) : 0;
assign Wordline[5] = (WriteReg) ? ((RegId == 4'b0101) ? 1 : 0) : 0;
assign Wordline[6] = (WriteReg) ? ((RegId == 4'b0110) ? 1 : 0) : 0;
assign Wordline[7] = (WriteReg) ? ((RegId == 4'b0111) ? 1 : 0) : 0;
assign Wordline[8] = (WriteReg) ? ((RegId == 4'b1000) ? 1 : 0) : 0;
assign Wordline[9] = (WriteReg) ? ((RegId == 4'b1001) ? 1 : 0) : 0;
assign Wordline[10] = (WriteReg) ? ((RegId == 4'b1010) ? 1 : 0) : 0;
assign Wordline[11] = (WriteReg) ? ((RegId == 4'b1011) ? 1 : 0) : 0;
assign Wordline[12] = (WriteReg) ? ((RegId == 4'b1100) ? 1 : 0) : 0;
assign Wordline[13] = (WriteReg) ? ((RegId == 4'b1101) ? 1 : 0) : 0;
assign Wordline[14] = (WriteReg) ? ((RegId == 4'b1110) ? 1 : 0) : 0;
assign Wordline[15] = (WriteReg) ? ((RegId == 4'b1111) ? 1 : 0) : 0;


endmodule 