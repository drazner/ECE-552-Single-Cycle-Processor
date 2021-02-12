
module FLAG(clk, rst, D, flag_out);

input clk, rst;
input [2:0] D;
inout [2:0] flag_out;


dff dff0(.q(flag_out[0]), .d(D[0]), .wen(1'b1), .clk(clk), .rst(rst));
dff dff1(.q(flag_out[1]), .d(D[1]), .wen(1'b1), .clk(clk), .rst(rst));
dff dff2(.q(flag_out[2]), .d(D[2]), .wen(1'b1), .clk(clk), .rst(rst));

//clk, rst, D, WriteEnable, ReadEnable1, ReadEnable2, Bitline1, Bitline2
//BitCell FLAG_bc0(.clk(clk), .rst(rst), .D(D[0]), .WriteEnable(WriteReg), .ReadEnable1(ReadEnable1), .ReadEnable2(ReadEnable2), .Bitline1(Bitline1[0]), .Bitline2(Bitline2[0]));
//BitCell FLAG_bc1(.clk(clk), .rst(rst), .D(D[1]), .WriteEnable(WriteReg), .ReadEnable1(ReadEnable1), .ReadEnable2(ReadEnable2), .Bitline1(Bitline1[1]), .Bitline2(Bitline2[1]));
//BitCell FLAG_bc2(.clk(clk), .rst(rst), .D(D[2]), .WriteEnable(WriteReg), .ReadEnable1(ReadEnable1), .ReadEnable2(ReadEnable2), .Bitline1(Bitline1[2]), .Bitline2(Bitline2[2]));

endmodule
