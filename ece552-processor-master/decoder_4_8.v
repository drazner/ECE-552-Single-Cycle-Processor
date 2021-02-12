
module decoder_4_8(Datain, Word_enable);

input[3:0] Datain; 
output[7:0] Word_enable;

assign Word_enable[7] = ((Datain == 4'hE) | (Datain == 4'hF)) ? 1'b1 : 1'b0; 
assign Word_enable[6] = ((Datain == 4'hC) | (Datain == 4'hD)) ? 1'b1 : 1'b0; 
assign Word_enable[5] = ((Datain == 4'hA) | (Datain == 4'hB)) ? 1'b1 : 1'b0; 
assign Word_enable[4] = ((Datain == 4'h8) | (Datain == 4'h9)) ? 1'b1 : 1'b0; 
assign Word_enable[3] = ((Datain == 4'h6) | (Datain == 4'h7)) ? 1'b1 : 1'b0; 
assign Word_enable[2] = ((Datain == 4'h4) | (Datain == 4'h5)) ? 1'b1 : 1'b0; 
assign Word_enable[1] = ((Datain == 4'h2) | (Datain == 4'h3)) ? 1'b1 : 1'b0; 
assign Word_enable[0] = ((Datain == 4'h0) | (Datain == 4'h1)) ? 1'b1 : 1'b0;  

endmodule 