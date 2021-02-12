
module p2_tb();

reg clk = 0;
reg rst;
wire we;
wire [15:0] instr = 16'hb151;
wire [15:0] instr_out;

p2 p2_test(.clk(clk), .rst(rst), .write_en(we), .instr(instr), .instr_out(instr_out));

assign we = 1;


initial begin

forever #5 clk = ~clk;

end

initial begin

rst = 1;
#5
rst = 0;

#20

$display("%h", instr_out);

end

endmodule 