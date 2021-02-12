
module hazard_detection(p4_reg_cont, p1_lhb_llb, p1_taken, p1_br, read, compute, p1_rs, p1_rt, p2_lw, p2_rt, hazard_stall, hazard_flush);

//rd = IM_instr[11:8]; 
//rs = IM_instr[7:4]; 
//rt = IM_instr[3:0]; 

input [3:0] p1_rs, p1_rt, p2_rt;
input p2_lw, read, compute, p1_taken, p1_br, p4_reg_cont, p1_lhb_llb;
output hazard_stall, hazard_flush;

//for compute instr check both p1_rs and p1_rt
assign hazard_stall = (p2_lw & read) ? (compute) ? ((p1_rs == p2_rt) | (p1_rt == p2_rt)) ? 1'b1 : 1'b0 : (p1_rs == p2_rt) ? 1'b1 : 1'b0 : 
		(p4_reg_cont & p1_lhb_llb) ? 1'b1 : 1'b0;
assign hazard_flush = (p1_taken & p1_br) ? 1'b1 : 1'b0;

endmodule
