
module cache_fill_FSM_tb();
  // Inputs to DUT
  reg clk, rst, miss_detected,memory_data_valid;
  reg [15:0] miss_address, memory_data; 

  wire rst_n;
  assign rst_n = ~rst;


  // For monitoring outputs of DUT
  wire fsm_busy, write_data_array, write_tag_array; 
  wire [15:0] memory_address, cache_data; 



/*
input miss_detected; // active high when tag match logic detects a miss KEEP HIGH
input [15:0] miss_address; // address that missed the cache
output fsm_busy; // asserted while FSM is busy handling the miss (can be used as pipeline stall signal)
output write_data_array; // write enable to cache data array to signal when filling with memory_data
output write_tag_array; // write enable to cache tag array to write tag and valid bit once all words are filled in to data array
output [15:0] memory_address; // address to read from memory
input [15:0] memory_data; // data returned by memory (after  delay)
input memory_data_valid; // active high indicates valid data returning on memory bus
output [15:0] cache_data; //output to cache ADDED
*/

  // DUT instantiation
  cache_fill_FSM iDUT(.clk(clk), .rst_n(rst_n), .miss_detected(miss_detected), 
			.miss_address(miss_address), .fsm_busy(fsm_busy), 
			.write_data_array(write_data_array), .write_tag_array(write_tag_array),
			.memory_address(memory_address), .memory_data(memory_data), 
			.memory_data_valid(memory_data_valid), .cache_data(cache_data));

  // Clock stimuli
  always #5 clk = ~clk;

  // Simulate effects of interacting with register file
  initial begin
    clk = 1'b0;  // Initialize clock
    rst = 1'b1;  // Reset DUT

    #15;

    @(negedge clk) rst = 1'b0;

    // Test 1
    miss_detected = 1'b1;
    memory_data_valid = 1'b0;
    miss_address = 16'hBEEF;
    memory_data = 16'hzzzz;

    
    //wait 4 clk cycles
    repeat(4) @(posedge clk);

    memory_data_valid = 1'b1;
    memory_data = 16'hABCD;
    

    
    repeat(8) @(posedge clk);

    miss_detected = 1'b0;

    #15;

    // END TEST 1

    // Advance to next negative clock edge
    @(negedge clk);

    // Test 2
    miss_detected = 1'b1;
    memory_data_valid = 1'b0;
    miss_address = 16'hCAFE;
    memory_data = 16'hzzzz;

    //wait 4 clk cycles
    repeat(4) @(posedge clk);

    memory_data_valid = 1'b1;
    memory_data = 16'h0123;
    
    
    repeat(8) @(posedge clk);

    miss_detected = 1'b0;


    #15;
    
    // END TEST 2

    $stop;
  end

  // Constantly display DUT outputs
  initial $monitor("fsm_busy: %h, write_data_array: %h, write_tag_array: %h", fsm_busy, write_data_array, write_tag_array);
endmodule