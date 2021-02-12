
module pc_register(clk, rst, write_en, D, pc_out);

input clk, rst, write_en;
input [15:0] D;
output [15:0] pc_out;

dff dff0(.q(pc_out[0]), .d(D[0]), .wen(write_en), .clk(clk), .rst(rst));
dff dff1(.q(pc_out[1]), .d(D[1]), .wen(write_en), .clk(clk), .rst(rst));
dff dff2(.q(pc_out[2]), .d(D[2]), .wen(write_en), .clk(clk), .rst(rst));
dff dff3(.q(pc_out[3]), .d(D[3]), .wen(write_en), .clk(clk), .rst(rst));
dff dff4(.q(pc_out[4]), .d(D[4]), .wen(write_en), .clk(clk), .rst(rst));
dff dff5(.q(pc_out[5]), .d(D[5]), .wen(write_en), .clk(clk), .rst(rst));
dff dff6(.q(pc_out[6]), .d(D[6]), .wen(write_en), .clk(clk), .rst(rst));
dff dff7(.q(pc_out[7]), .d(D[7]), .wen(write_en), .clk(clk), .rst(rst));
dff dff8(.q(pc_out[8]), .d(D[8]), .wen(write_en), .clk(clk), .rst(rst));
dff dff9(.q(pc_out[9]), .d(D[9]), .wen(write_en), .clk(clk), .rst(rst));
dff dff10(.q(pc_out[10]), .d(D[10]), .wen(write_en), .clk(clk), .rst(rst));
dff dff11(.q(pc_out[11]), .d(D[11]), .wen(write_en), .clk(clk), .rst(rst));
dff dff12(.q(pc_out[12]), .d(D[12]), .wen(write_en), .clk(clk), .rst(rst));
dff dff13(.q(pc_out[13]), .d(D[13]), .wen(write_en), .clk(clk), .rst(rst));
dff dff14(.q(pc_out[14]), .d(D[14]), .wen(write_en), .clk(clk), .rst(rst));
dff dff15(.q(pc_out[15]), .d(D[15]), .wen(write_en), .clk(clk), .rst(rst));


endmodule

