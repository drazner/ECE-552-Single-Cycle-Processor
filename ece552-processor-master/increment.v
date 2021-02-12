
module increment(clk, rst, start, out, pcr);

input clk, rst, start;
output [3:0] out;
input [3:0] pcr;

wire [3:0] inc_addr_out2;
wire [3:0] inc_addr_in2;
wire [3:0] cla_addr_out2;
wire [3:0] dec_pcr;

//subract by 1
cla_16b cla_mem_addr(.Sum(dec_pcr), .Ovfl(), .A(pcr), .B(16'h2), .sub(1'b1));

assign inc_addr_in2 = (start === 1'b1) ? cla_addr_out2 : dec_pcr;

dff mem_addr2_0(.q(inc_addr_out2[0]), .d(inc_addr_in2[0]), .wen(1'b1), .clk(clk), .rst(rst));
dff mem_addr2_1(.q(inc_addr_out2[1]), .d(inc_addr_in2[1]), .wen(1'b1), .clk(clk), .rst(rst));
dff mem_addr2_2(.q(inc_addr_out2[2]), .d(inc_addr_in2[2]), .wen(1'b1), .clk(clk), .rst(rst));
dff mem_addr2_3(.q(inc_addr_out2[3]), .d(inc_addr_in2[3]), .wen(1'b1), .clk(clk), .rst(rst));


cla_16b cla_mem_addr2(.Sum(cla_addr_out2), .Ovfl(), .A(inc_addr_out2), .B(16'h2), .sub(1'b0));

assign out = inc_addr_in2;

endmodule 