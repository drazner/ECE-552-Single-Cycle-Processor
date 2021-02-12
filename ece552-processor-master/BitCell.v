
module BitCell(clk, rst, D, WriteEnable, ReadEnable1, ReadEnable2, Bitline1, Bitline2);


input clk;
input rst;
input D;
input WriteEnable;
input ReadEnable1;
input ReadEnable2;
inout Bitline1;
inout Bitline2;


wire q;

//q, d, wen, clk, rst
dff FFcell(.q(q), .d(D), .wen(WriteEnable), .clk(clk), .rst(rst));


//assign Bitline1 = (ReadEnable1) ? ((WriteEnable) ? D : q) : 1'bz; //with bypassing
//assign Bitline2 = (ReadEnable2) ? ((WriteEnable) ? D : q) : 1'bz; //with bypassing
assign Bitline1 = (ReadEnable1) ? q : 1'bz;
assign Bitline2 = (ReadEnable2) ? q : 1'bz;


endmodule
