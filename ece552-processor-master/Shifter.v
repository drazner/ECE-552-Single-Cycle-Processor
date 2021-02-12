
module Shifter(Shift_Out, Shift_In, Shift_Val, Mode);

input [15:0] Shift_In;
input [3:0] Shift_Val;
input Mode;
output [15:0] Shift_Out;

wire [15:0] inter1, inter2, inter3;

//mode 1 => SLL ; mode 0 => SRA

assign inter1 = (Mode & Shift_Val[0]) ? {Shift_In[14:0], 1'b0} : (~Mode & Shift_Val[0]) ? {Shift_In[15], Shift_In[15:1]} : Shift_In;

assign inter2 = (Mode & Shift_Val[1]) ? {inter1[13:0], 2'b0} : (~Mode & Shift_Val[1]) ? {inter1[15], inter1[15], inter1[15:2]} : inter1;

assign inter3 = (Mode & Shift_Val[2]) ? {inter2[11:0], 4'b0} : (~Mode & Shift_Val[2]) ? {inter2[15], inter1[15], inter1[15], inter1[15], inter2[15:4]} : inter2; 

assign Shift_Out = (Mode & Shift_Val[3]) ? {inter3[7:0], 8'b0} : (~Mode & Shift_Val[3]) ? {inter3[15], inter3[15], inter3[15], inter3[15], 
							inter3[15], inter3[15], inter3[15], inter3[15], inter3[15:8]} : inter3;

endmodule
