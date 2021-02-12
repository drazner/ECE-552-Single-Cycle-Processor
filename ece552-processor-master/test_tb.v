
module test_tb();


reg clk = 0;
reg rst;

wire [2:0] counter_in;
wire [2:0] counter_out;
test test_DUT(.clk(clk), .rst(rst), .counter_in(counter_in), .counter_out(counter_out));



initial begin

forever #5 clk = ~clk;

end

initial begin

rst = 1;
#15
rst = 0;

#100

$monitor("%h", counter_out);

end



endmodule
