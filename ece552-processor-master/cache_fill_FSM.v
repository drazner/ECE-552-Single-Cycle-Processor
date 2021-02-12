
module cache_fill_FSM(clk, rst_n, miss_detected, miss_address, fsm_busy, write_data_array, write_tag_array,memory_address, memory_data, memory_data_valid, cache_data, mem_output, counter_e2);
input clk, rst_n;
input miss_detected; // active high when tag match logic detects a miss KEEP HIGH
input [15:0] miss_address; // address that missed the cache
output fsm_busy; // asserted while FSM is busy handling the miss (can be used as pipeline stall signal)
output write_data_array; // write enable to cache data array to signal when filling with memory_data
output write_tag_array; // write enable to cache tag array to write tag and valid bit once all words are filled in to data array
output [15:0] memory_address; // address to read from memory
input [15:0] memory_data; // data returned by memory (after  delay)
input memory_data_valid; // active high indicates valid data returning on memory bus
output [15:0] cache_data; //output to cache ADDED
output [15:0] mem_output;
output counter_e2;

wire rst = ~rst_n;

//state -- IDLE (0) or WAIT (1)
wire state_d;
wire state_q;
wire state_en;

dff state(.q(state_q), .d(state_d), .wen(state_en), .clk(clk), .rst(rst));


//counter -- counts to 8
wire [3:0] counter_in;
wire [3:0] counter_out;
wire counter_en;
wire [3:0] cla_out;
assign counter_in = (counter_out == 4'b0111) ? 4'b0000 : cla_out[3:0];

dff counter0(.q(counter_out[0]), .d(counter_in[0]), .wen(counter_en), .clk(clk), .rst(rst));
dff counter1(.q(counter_out[1]), .d(counter_in[1]), .wen(counter_en), .clk(clk), .rst(rst));
dff counter2(.q(counter_out[2]), .d(counter_in[2]), .wen(counter_en), .clk(clk), .rst(rst));
dff counter3(.q(counter_out[3]), .d(counter_in[3]), .wen(counter_en), .clk(clk), .rst(rst));

cla_4b adder(.Sum(cla_out), .Ovfl(), .A({counter_out}), .B(4'b0001), .sub(1'b0), .carry(), .P(), .G(), .Cin(1'b0));


wire [15:0] inc_addr_out;
wire [15:0] inc_addr_in;
wire [15:0] cla_addr_out;

assign inc_addr_in = (~memory_data_valid) ? miss_address : cla_addr_out;

dff mem_addr0(.q(inc_addr_out[0]), .d(inc_addr_in[0]), .wen(counter_en), .clk(clk), .rst(rst));
dff mem_addr1(.q(inc_addr_out[1]), .d(inc_addr_in[1]), .wen(counter_en), .clk(clk), .rst(rst));
dff mem_addr2(.q(inc_addr_out[2]), .d(inc_addr_in[2]), .wen(counter_en), .clk(clk), .rst(rst));
dff mem_addr3(.q(inc_addr_out[3]), .d(inc_addr_in[3]), .wen(counter_en), .clk(clk), .rst(rst));
dff mem_addr4(.q(inc_addr_out[4]), .d(inc_addr_in[4]), .wen(counter_en), .clk(clk), .rst(rst));
dff mem_addr5(.q(inc_addr_out[5]), .d(inc_addr_in[5]), .wen(counter_en), .clk(clk), .rst(rst));
dff mem_addr6(.q(inc_addr_out[6]), .d(inc_addr_in[6]), .wen(counter_en), .clk(clk), .rst(rst));
dff mem_addr7(.q(inc_addr_out[7]), .d(inc_addr_in[7]), .wen(counter_en), .clk(clk), .rst(rst));
dff mem_addr8(.q(inc_addr_out[8]), .d(inc_addr_in[8]), .wen(counter_en), .clk(clk), .rst(rst));
dff mem_addr9(.q(inc_addr_out[9]), .d(inc_addr_in[9]), .wen(counter_en), .clk(clk), .rst(rst));
dff mem_addr10(.q(inc_addr_out[10]), .d(inc_addr_in[10]), .wen(counter_en), .clk(clk), .rst(rst));
dff mem_addr11(.q(inc_addr_out[11]), .d(inc_addr_in[11]), .wen(counter_en), .clk(clk), .rst(rst));
dff mem_addr12(.q(inc_addr_out[12]), .d(inc_addr_in[12]), .wen(counter_en), .clk(clk), .rst(rst));
dff mem_addr13(.q(inc_addr_out[13]), .d(inc_addr_in[13]), .wen(counter_en), .clk(clk), .rst(rst));
dff mem_addr14(.q(inc_addr_out[14]), .d(inc_addr_in[14]), .wen(counter_en), .clk(clk), .rst(rst));
dff mem_addr15(.q(inc_addr_out[15]), .d(inc_addr_in[15]), .wen(counter_en), .clk(clk), .rst(rst));

cla_16b cla_mem_addr(.Sum(cla_addr_out), .Ovfl(), .A(inc_addr_out), .B(16'h2), .sub(1'b0));




//counter 2
wire [3:0] counter_in2;
wire [3:0] counter_out2;
wire counter_en2;
wire [3:0] cla_out2;
assign counter_in2 = (counter_out2 == 4'b1100) ? 4'b0000 : cla_out2[3:0];

dff counter2_0(.q(counter_out2[0]), .d(counter_in2[0]), .wen(counter_en2), .clk(clk), .rst(rst));
dff counter2_1(.q(counter_out2[1]), .d(counter_in2[1]), .wen(counter_en2), .clk(clk), .rst(rst));
dff counter2_2(.q(counter_out2[2]), .d(counter_in2[2]), .wen(counter_en2), .clk(clk), .rst(rst));
dff counter2_3(.q(counter_out2[3]), .d(counter_in2[3]), .wen(counter_en2), .clk(clk), .rst(rst));

cla_4b adder2(.Sum(cla_out2), .Ovfl(), .A({counter_out2}), .B(4'b0001), .sub(1'b0), .carry(), .P(), .G(), .Cin(1'b0));

assign counter_en2 = (memory_data_valid & (state_d | counter_e2)) ? 1'b1 : 1'b0;

///////////////////////////

//incrementer2
wire [15:0] inc_addr_out2;
wire [15:0] inc_addr_in2;
wire [15:0] cla_addr_out2;

assign inc_addr_in2 = (~memory_data_valid) ? 16'h0000 : cla_addr_out2;

dff mem_addr2_0(.q(inc_addr_out2[0]), .d(inc_addr_in2[0]), .wen(counter_e2), .clk(clk), .rst(rst));
dff mem_addr2_1(.q(inc_addr_out2[1]), .d(inc_addr_in2[1]), .wen(counter_e2), .clk(clk), .rst(rst));
dff mem_addr2_2(.q(inc_addr_out2[2]), .d(inc_addr_in2[2]), .wen(counter_e2), .clk(clk), .rst(rst));
dff mem_addr2_3(.q(inc_addr_out2[3]), .d(inc_addr_in2[3]), .wen(counter_e2), .clk(clk), .rst(rst));
dff mem_addr2_4(.q(inc_addr_out2[4]), .d(inc_addr_in2[4]), .wen(counter_e2), .clk(clk), .rst(rst));
dff mem_addr2_5(.q(inc_addr_out2[5]), .d(inc_addr_in2[5]), .wen(counter_e2), .clk(clk), .rst(rst));
dff mem_addr2_6(.q(inc_addr_out2[6]), .d(inc_addr_in2[6]), .wen(counter_e2), .clk(clk), .rst(rst));
dff mem_addr2_7(.q(inc_addr_out2[7]), .d(inc_addr_in2[7]), .wen(counter_e2), .clk(clk), .rst(rst));
dff mem_addr2_8(.q(inc_addr_out2[8]), .d(inc_addr_in2[8]), .wen(counter_e2), .clk(clk), .rst(rst));
dff mem_addr2_9(.q(inc_addr_out2[9]), .d(inc_addr_in2[9]), .wen(counter_e2), .clk(clk), .rst(rst));
dff mem_addr2_10(.q(inc_addr_out2[10]), .d(inc_addr_in2[10]), .wen(counter_e2), .clk(clk), .rst(rst));
dff mem_addr2_11(.q(inc_addr_out2[11]), .d(inc_addr_in2[11]), .wen(counter_e2), .clk(clk), .rst(rst));
dff mem_addr2_12(.q(inc_addr_out2[12]), .d(inc_addr_in2[12]), .wen(counter_e2), .clk(clk), .rst(rst));
dff mem_addr2_13(.q(inc_addr_out2[13]), .d(inc_addr_in2[13]), .wen(counter_e2), .clk(clk), .rst(rst));
dff mem_addr2_14(.q(inc_addr_out2[14]), .d(inc_addr_in2[14]), .wen(counter_e2), .clk(clk), .rst(rst));
dff mem_addr2_15(.q(inc_addr_out2[15]), .d(inc_addr_in2[15]), .wen(counter_e2), .clk(clk), .rst(rst));

cla_16b cla_mem_addr2(.Sum(cla_addr_out2), .Ovfl(), .A(inc_addr_out2), .B(16'h2), .sub(1'b0));

/*
assign counter_e2 = ((fsm_busy) & ~(memory_data === 16'hxxxx) & ((counter_out2 === 4'b0100) | (counter_out2 === 4'b0101) | (counter_out2 === 4'b0110) | 
			(counter_out2 === 4'b0111) | (counter_out2 === 4'b1000) | (counter_out2 === 4'b1001) | 
			(counter_out2 === 4'b1010) | (counter_out2 === 4'b1011) | (counter_out2 === 4'b1100))) ? 1'b1 : 1'b0;
*/
assign counter_e2 = ((fsm_busy) & ((counter_out2 === 4'b0100) | (counter_out2 === 4'b0101) | (counter_out2 === 4'b0110) | 
			(counter_out2 === 4'b0111) | (counter_out2 === 4'b1000) | (counter_out2 === 4'b1001) | 
			(counter_out2 === 4'b1010) | (counter_out2 === 4'b1011) | (counter_out2 === 4'b1100))) ? 1'b1 : 1'b0;

/////////////////


assign state_en = (miss_detected) ? 1'b1 : 1'b0;
assign state_d = (~miss_detected | counter_out == 4'b0111) ? 1'b0 : 1'b1;
assign counter_en = ((miss_detected === 1'b1) & memory_data_valid) ? 1'b1 : 1'b0;

wire write_data_array_logic;
assign write_data_array_logic = (memory_data_valid & (state_d | counter_e2)) ? (counter_in2 == 4'b0000) ? 1'b0 : 1'b1 : 1'b0;

assign write_data_array = (write_data_array_logic) ? 1'b1 : 1'b0;
//assign write_tag_array = (miss_detected & counter_out == 3'b111) ? 1'b1 : 1'b0;
assign write_tag_array = (counter_out == 4'b0111) ? 1'b1 : 1'b0;


//assign fsm_busy = (state_q) ? 1'b1 : 1'b0;
assign fsm_busy = (miss_detected | state_q | counter_en2) ? 1'b1 : 1'b0;

//assign memory_address = (state_q) ? inc_addr_out : 16'hzzzz; 
assign memory_address = (state_d | state_q) ? inc_addr_out : 16'hzzzz;

assign mem_output = (state_q) ? inc_addr_out2 : 16'hzzzz;



assign cache_data = (counter_en2 & memory_data_valid) ? memory_data : 16'hzzzz;
//assign cache_data = (state_q & memory_data_valid) ? memory_data : 16'hzzzz;


endmodule
