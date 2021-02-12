
module decoder_7_128(Datain, Wordline);

input[6:0] Datain; 
output[127:0] Wordline;

wire[7:0] RegId = {1'b0,Datain}; 

//Decoder outputs 1 for the selected ID and 0 for everything else 
assign Wordline[127] = (RegId == 8'h7F) ? 1'b1 : 1'b0; 
assign Wordline[126] = (RegId == 8'h7E) ? 1'b1 : 1'b0;
assign Wordline[125] = (RegId == 8'h7D) ? 1'b1 : 1'b0;
assign Wordline[124] = (RegId == 8'h7C) ? 1'b1 : 1'b0;
assign Wordline[123] = (RegId == 8'h7B) ? 1'b1 : 1'b0;
assign Wordline[122] = (RegId == 8'h7A) ? 1'b1 : 1'b0;
assign Wordline[121] = (RegId == 8'h79) ? 1'b1 : 1'b0;
assign Wordline[120] = (RegId == 8'h78) ? 1'b1 : 1'b0;
assign Wordline[119] = (RegId == 8'h77) ? 1'b1 : 1'b0;
assign Wordline[118] = (RegId == 8'h76) ? 1'b1 : 1'b0;
assign Wordline[117] = (RegId == 8'h75) ? 1'b1 : 1'b0;
assign Wordline[116] = (RegId == 8'h74) ? 1'b1 : 1'b0;
assign Wordline[115] = (RegId == 8'h73) ? 1'b1 : 1'b0;
assign Wordline[114] = (RegId == 8'h72) ? 1'b1 : 1'b0;
assign Wordline[113] = (RegId == 8'h71) ? 1'b1 : 1'b0;
assign Wordline[112] = (RegId == 8'h70) ? 1'b1 : 1'b0;
assign Wordline[111] = (RegId == 8'h6F) ? 1'b1 : 1'b0; 
assign Wordline[110] = (RegId == 8'h6E) ? 1'b1 : 1'b0;
assign Wordline[109] = (RegId == 8'h6D) ? 1'b1 : 1'b0;
assign Wordline[108] = (RegId == 8'h6C) ? 1'b1 : 1'b0;
assign Wordline[107] = (RegId == 8'h6B) ? 1'b1 : 1'b0;
assign Wordline[106] = (RegId == 8'h6A) ? 1'b1 : 1'b0;
assign Wordline[105] = (RegId == 8'h69) ? 1'b1 : 1'b0;
assign Wordline[104] = (RegId == 8'h68) ? 1'b1 : 1'b0;
assign Wordline[103] = (RegId == 8'h67) ? 1'b1 : 1'b0;
assign Wordline[102] = (RegId == 8'h66) ? 1'b1 : 1'b0;
assign Wordline[101] = (RegId == 8'h65) ? 1'b1 : 1'b0;
assign Wordline[100] = (RegId == 8'h64) ? 1'b1 : 1'b0;
assign Wordline[99]  = (RegId == 8'h63) ? 1'b1 : 1'b0;
assign Wordline[98]  = (RegId == 8'h62) ? 1'b1 : 1'b0;
assign Wordline[97]  = (RegId == 8'h61) ? 1'b1 : 1'b0;
assign Wordline[96]  = (RegId == 8'h60) ? 1'b1 : 1'b0;
assign Wordline[95]  = (RegId == 8'h5F) ? 1'b1 : 1'b0; 
assign Wordline[94]  = (RegId == 8'h5E) ? 1'b1 : 1'b0;
assign Wordline[93]  = (RegId == 8'h5D) ? 1'b1 : 1'b0;
assign Wordline[92]  = (RegId == 8'h5C) ? 1'b1 : 1'b0;
assign Wordline[91]  = (RegId == 8'h5B) ? 1'b1 : 1'b0;
assign Wordline[90]  = (RegId == 8'h5A) ? 1'b1 : 1'b0;
assign Wordline[89]  = (RegId == 8'h59) ? 1'b1 : 1'b0;
assign Wordline[88]  = (RegId == 8'h58) ? 1'b1 : 1'b0;
assign Wordline[87]  = (RegId == 8'h57) ? 1'b1 : 1'b0;
assign Wordline[86]  = (RegId == 8'h56) ? 1'b1 : 1'b0;
assign Wordline[85]  = (RegId == 8'h55) ? 1'b1 : 1'b0;
assign Wordline[84]  = (RegId == 8'h54) ? 1'b1 : 1'b0;
assign Wordline[83]  = (RegId == 8'h53) ? 1'b1 : 1'b0;
assign Wordline[82]  = (RegId == 8'h52) ? 1'b1 : 1'b0;
assign Wordline[81]  = (RegId == 8'h51) ? 1'b1 : 1'b0;
assign Wordline[80]  = (RegId == 8'h50) ? 1'b1 : 1'b0;
assign Wordline[79]  = (RegId == 8'h4F) ? 1'b1 : 1'b0; 
assign Wordline[78]  = (RegId == 8'h4E) ? 1'b1 : 1'b0;
assign Wordline[77]  = (RegId == 8'h4D) ? 1'b1 : 1'b0;
assign Wordline[76]  = (RegId == 8'h4C) ? 1'b1 : 1'b0;
assign Wordline[75]  = (RegId == 8'h4B) ? 1'b1 : 1'b0;
assign Wordline[74]  = (RegId == 8'h4A) ? 1'b1 : 1'b0;
assign Wordline[73]  = (RegId == 8'h49) ? 1'b1 : 1'b0;
assign Wordline[72]  = (RegId == 8'h48) ? 1'b1 : 1'b0;
assign Wordline[71]  = (RegId == 8'h47) ? 1'b1 : 1'b0;
assign Wordline[70]  = (RegId == 8'h46) ? 1'b1 : 1'b0;
assign Wordline[69]  = (RegId == 8'h45) ? 1'b1 : 1'b0;
assign Wordline[68]  = (RegId == 8'h44) ? 1'b1 : 1'b0;
assign Wordline[67]  = (RegId == 8'h43) ? 1'b1 : 1'b0;
assign Wordline[66]  = (RegId == 8'h42) ? 1'b1 : 1'b0;
assign Wordline[65]  = (RegId == 8'h41) ? 1'b1 : 1'b0;
assign Wordline[64]  = (RegId == 8'h40) ? 1'b1 : 1'b0;
assign Wordline[63]  = (RegId == 8'h3F) ? 1'b1 : 1'b0; 
assign Wordline[62]  = (RegId == 8'h3E) ? 1'b1 : 1'b0;
assign Wordline[61]  = (RegId == 8'h3D) ? 1'b1 : 1'b0;
assign Wordline[60]  = (RegId == 8'h3C) ? 1'b1 : 1'b0;
assign Wordline[59]  = (RegId == 8'h3B) ? 1'b1 : 1'b0;
assign Wordline[58]  = (RegId == 8'h3A) ? 1'b1 : 1'b0;
assign Wordline[57]  = (RegId == 8'h39) ? 1'b1 : 1'b0;
assign Wordline[56]  = (RegId == 8'h38) ? 1'b1 : 1'b0;
assign Wordline[55]  = (RegId == 8'h37) ? 1'b1 : 1'b0;
assign Wordline[54]  = (RegId == 8'h36) ? 1'b1 : 1'b0;
assign Wordline[53]  = (RegId == 8'h35) ? 1'b1 : 1'b0;
assign Wordline[52]  = (RegId == 8'h34) ? 1'b1 : 1'b0;
assign Wordline[51]  = (RegId == 8'h33) ? 1'b1 : 1'b0;
assign Wordline[50]  = (RegId == 8'h32) ? 1'b1 : 1'b0;
assign Wordline[49]  = (RegId == 8'h31) ? 1'b1 : 1'b0;
assign Wordline[48]  = (RegId == 8'h30) ? 1'b1 : 1'b0;
assign Wordline[47]  = (RegId == 8'h2F) ? 1'b1 : 1'b0; 
assign Wordline[46]  = (RegId == 8'h2E) ? 1'b1 : 1'b0;
assign Wordline[45]  = (RegId == 8'h2D) ? 1'b1 : 1'b0;
assign Wordline[44]  = (RegId == 8'h2C) ? 1'b1 : 1'b0;
assign Wordline[43]  = (RegId == 8'h2B) ? 1'b1 : 1'b0;
assign Wordline[42]  = (RegId == 8'h2A) ? 1'b1 : 1'b0;
assign Wordline[41]  = (RegId == 8'h29) ? 1'b1 : 1'b0;
assign Wordline[40]  = (RegId == 8'h28) ? 1'b1 : 1'b0;
assign Wordline[39]  = (RegId == 8'h27) ? 1'b1 : 1'b0;
assign Wordline[38]  = (RegId == 8'h26) ? 1'b1 : 1'b0;
assign Wordline[37]  = (RegId == 8'h25) ? 1'b1 : 1'b0;
assign Wordline[36]  = (RegId == 8'h24) ? 1'b1 : 1'b0;
assign Wordline[35]  = (RegId == 8'h23) ? 1'b1 : 1'b0;
assign Wordline[34]  = (RegId == 8'h22) ? 1'b1 : 1'b0;
assign Wordline[33]  = (RegId == 8'h21) ? 1'b1 : 1'b0;
assign Wordline[32]  = (RegId == 8'h20) ? 1'b1 : 1'b0;
assign Wordline[31]  = (RegId == 8'h1F) ? 1'b1 : 1'b0; 
assign Wordline[30]  = (RegId == 8'h1E) ? 1'b1 : 1'b0;
assign Wordline[29]  = (RegId == 8'h1D) ? 1'b1 : 1'b0;
assign Wordline[28]  = (RegId == 8'h1C) ? 1'b1 : 1'b0;
assign Wordline[27]  = (RegId == 8'h1B) ? 1'b1 : 1'b0;
assign Wordline[26]  = (RegId == 8'h1A) ? 1'b1 : 1'b0;
assign Wordline[25]  = (RegId == 8'h19) ? 1'b1 : 1'b0;
assign Wordline[24]  = (RegId == 8'h18) ? 1'b1 : 1'b0;
assign Wordline[23]  = (RegId == 8'h17) ? 1'b1 : 1'b0;
assign Wordline[22]  = (RegId == 8'h16) ? 1'b1 : 1'b0;
assign Wordline[21]  = (RegId == 8'h15) ? 1'b1 : 1'b0;
assign Wordline[20]  = (RegId == 8'h14) ? 1'b1 : 1'b0;
assign Wordline[19]  = (RegId == 8'h13) ? 1'b1 : 1'b0;
assign Wordline[18]  = (RegId == 8'h12) ? 1'b1 : 1'b0;
assign Wordline[17]  = (RegId == 8'h11) ? 1'b1 : 1'b0;
assign Wordline[16]  = (RegId == 8'h10) ? 1'b1 : 1'b0;
assign Wordline[15]  = (RegId == 8'h0F) ? 1'b1 : 1'b0; 
assign Wordline[14]  = (RegId == 8'h0E) ? 1'b1 : 1'b0;
assign Wordline[13]  = (RegId == 8'h0D) ? 1'b1 : 1'b0;
assign Wordline[12]  = (RegId == 8'h0C) ? 1'b1 : 1'b0;
assign Wordline[11]  = (RegId == 8'h0B) ? 1'b1 : 1'b0;
assign Wordline[10]  = (RegId == 8'h0A) ? 1'b1 : 1'b0;
assign Wordline[9]   = (RegId == 8'h09) ? 1'b1 : 1'b0;
assign Wordline[8]   = (RegId == 8'h08) ? 1'b1 : 1'b0;
assign Wordline[7]   = (RegId == 8'h07) ? 1'b1 : 1'b0;
assign Wordline[6]   = (RegId == 8'h06) ? 1'b1 : 1'b0;
assign Wordline[5]   = (RegId == 8'h05) ? 1'b1 : 1'b0;
assign Wordline[4]   = (RegId == 8'h04) ? 1'b1 : 1'b0;
assign Wordline[3]   = (RegId == 8'h03) ? 1'b1 : 1'b0;
assign Wordline[2]   = (RegId == 8'h02) ? 1'b1 : 1'b0;
assign Wordline[1]   = (RegId == 8'h01) ? 1'b1 : 1'b0;
assign Wordline[0]   = (RegId == 8'h00) ? 1'b1 : 1'b0;
 

endmodule 