
module p2(clk, rst, write_en, pc, pc_out, instr, instr_out, rf1, rf1_out, rf2, rf2_out, D_compute, D_compute_out, D_compute_imm, D_compute_imm_out, D_lw, D_lw_out, D_sw, D_sw_out, D_lhb, D_lhb_out,
		D_llb, D_llb_out, D_b, D_b_out, D_br, D_br_out, D_pcs, D_pcs_out, D_hlt, D_hlt_out);

input clk, rst;
input [15:0] rf1, rf2, pc;
input [15:0] instr;
input write_en, D_compute, D_compute_imm, D_lw, D_sw, D_lhb, D_llb, D_b, D_br, D_pcs, D_hlt;
output [15:0] rf1_out, rf2_out, pc_out;
output [15:0] instr_out;
output D_compute_out, D_compute_imm_out, D_lw_out, D_sw_out, D_lhb_out, D_llb_out, D_b_out, D_br_out, D_pcs_out, D_hlt_out;

//pc
dff pc_dff0(.q(pc_out[0]), .d(pc[0]), .wen(write_en), .clk(clk), .rst(rst));
dff pc_dff1(.q(pc_out[1]), .d(pc[1]), .wen(write_en), .clk(clk), .rst(rst));
dff pc_dff2(.q(pc_out[2]), .d(pc[2]), .wen(write_en), .clk(clk), .rst(rst));
dff pc_dff3(.q(pc_out[3]), .d(pc[3]), .wen(write_en), .clk(clk), .rst(rst));
dff pc_dff4(.q(pc_out[4]), .d(pc[4]), .wen(write_en), .clk(clk), .rst(rst));
dff pc_dff5(.q(pc_out[5]), .d(pc[5]), .wen(write_en), .clk(clk), .rst(rst));
dff pc_dff6(.q(pc_out[6]), .d(pc[6]), .wen(write_en), .clk(clk), .rst(rst));
dff pc_dff7(.q(pc_out[7]), .d(pc[7]), .wen(write_en), .clk(clk), .rst(rst));
dff pc_dff8(.q(pc_out[8]), .d(pc[8]), .wen(write_en), .clk(clk), .rst(rst));
dff pc_dff9(.q(pc_out[9]), .d(pc[9]), .wen(write_en), .clk(clk), .rst(rst));
dff pc_dff10(.q(pc_out[10]), .d(pc[10]), .wen(write_en), .clk(clk), .rst(rst));
dff pc_dff11(.q(pc_out[11]), .d(pc[11]), .wen(write_en), .clk(clk), .rst(rst));
dff pc_dff12(.q(pc_out[12]), .d(pc[12]), .wen(write_en), .clk(clk), .rst(rst));
dff pc_dff13(.q(pc_out[13]), .d(pc[13]), .wen(write_en), .clk(clk), .rst(rst));
dff pc_dff14(.q(pc_out[14]), .d(pc[14]), .wen(write_en), .clk(clk), .rst(rst));
dff pc_dff15(.q(pc_out[15]), .d(pc[15]), .wen(write_en), .clk(clk), .rst(rst));

//instr
dff instr_dff0(.q(instr_out[0]), .d(instr[0]), .wen(write_en), .clk(clk), .rst(rst)); //instr[0] instr_out[0]
dff instr_dff1(.q(instr_out[1]), .d(instr[1]), .wen(write_en), .clk(clk), .rst(rst));
dff instr_dff2(.q(instr_out[2]), .d(instr[2]), .wen(write_en), .clk(clk), .rst(rst));
dff instr_dff3(.q(instr_out[3]), .d(instr[3]), .wen(write_en), .clk(clk), .rst(rst));
dff instr_dff4(.q(instr_out[4]), .d(instr[4]), .wen(write_en), .clk(clk), .rst(rst));
dff instr_dff5(.q(instr_out[5]), .d(instr[5]), .wen(write_en), .clk(clk), .rst(rst));
dff instr_dff6(.q(instr_out[6]), .d(instr[6]), .wen(write_en), .clk(clk), .rst(rst));
dff instr_dff7(.q(instr_out[7]), .d(instr[7]), .wen(write_en), .clk(clk), .rst(rst));
dff instr_dff8(.q(instr_out[8]), .d(instr[8]), .wen(write_en), .clk(clk), .rst(rst));
dff instr_dff9(.q(instr_out[9]), .d(instr[9]), .wen(write_en), .clk(clk), .rst(rst));
dff instr_dff10(.q(instr_out[10]), .d(instr[10]), .wen(write_en), .clk(clk), .rst(rst));
dff instr_dff11(.q(instr_out[11]), .d(instr[11]), .wen(write_en), .clk(clk), .rst(rst));
dff instr_dff12(.q(instr_out[12]), .d(instr[12]), .wen(write_en), .clk(clk), .rst(rst));
dff instr_dff13(.q(instr_out[13]), .d(instr[13]), .wen(write_en), .clk(clk), .rst(rst));
dff instr_dff14(.q(instr_out[14]), .d(instr[14]), .wen(write_en), .clk(clk), .rst(rst));
dff instr_dff15(.q(instr_out[15]), .d(instr[15]), .wen(write_en), .clk(clk), .rst(rst));

//assign instr_out[0] = 1'b1;


//rf1
dff rf1_0(.q(rf1_out[0]), .d(rf1[0]), .wen(write_en), .clk(clk), .rst(rst));
dff rf1_1(.q(rf1_out[1]), .d(rf1[1]), .wen(write_en), .clk(clk), .rst(rst));
dff rf1_2(.q(rf1_out[2]), .d(rf1[2]), .wen(write_en), .clk(clk), .rst(rst));
dff rf1_3(.q(rf1_out[3]), .d(rf1[3]), .wen(write_en), .clk(clk), .rst(rst));
dff rf1_4(.q(rf1_out[4]), .d(rf1[4]), .wen(write_en), .clk(clk), .rst(rst));
dff rf1_5(.q(rf1_out[5]), .d(rf1[5]), .wen(write_en), .clk(clk), .rst(rst));
dff rf1_6(.q(rf1_out[6]), .d(rf1[6]), .wen(write_en), .clk(clk), .rst(rst));
dff rf1_7(.q(rf1_out[7]), .d(rf1[7]), .wen(write_en), .clk(clk), .rst(rst));
dff rf1_8(.q(rf1_out[8]), .d(rf1[8]), .wen(write_en), .clk(clk), .rst(rst));
dff rf1_9(.q(rf1_out[9]), .d(rf1[9]), .wen(write_en), .clk(clk), .rst(rst));
dff rf1_10(.q(rf1_out[10]), .d(rf1[10]), .wen(write_en), .clk(clk), .rst(rst));
dff rf1_11(.q(rf1_out[11]), .d(rf1[11]), .wen(write_en), .clk(clk), .rst(rst));
dff rf1_12(.q(rf1_out[12]), .d(rf1[12]), .wen(write_en), .clk(clk), .rst(rst));
dff rf1_13(.q(rf1_out[13]), .d(rf1[13]), .wen(write_en), .clk(clk), .rst(rst));
dff rf1_14(.q(rf1_out[14]), .d(rf1[14]), .wen(write_en), .clk(clk), .rst(rst));
dff rf1_15(.q(rf1_out[15]), .d(rf1[15]), .wen(write_en), .clk(clk), .rst(rst));

//rf2
dff rf2_0(.q(rf2_out[0]), .d(rf2[0]), .wen(write_en), .clk(clk), .rst(rst));
dff rf2_1(.q(rf2_out[1]), .d(rf2[1]), .wen(write_en), .clk(clk), .rst(rst));
dff rf2_2(.q(rf2_out[2]), .d(rf2[2]), .wen(write_en), .clk(clk), .rst(rst));
dff rf2_3(.q(rf2_out[3]), .d(rf2[3]), .wen(write_en), .clk(clk), .rst(rst));
dff rf2_4(.q(rf2_out[4]), .d(rf2[4]), .wen(write_en), .clk(clk), .rst(rst));
dff rf2_5(.q(rf2_out[5]), .d(rf2[5]), .wen(write_en), .clk(clk), .rst(rst));
dff rf2_6(.q(rf2_out[6]), .d(rf2[6]), .wen(write_en), .clk(clk), .rst(rst));
dff rf2_7(.q(rf2_out[7]), .d(rf2[7]), .wen(write_en), .clk(clk), .rst(rst));
dff rf2_8(.q(rf2_out[8]), .d(rf2[8]), .wen(write_en), .clk(clk), .rst(rst));
dff rf2_9(.q(rf2_out[9]), .d(rf2[9]), .wen(write_en), .clk(clk), .rst(rst));
dff rf2_10(.q(rf2_out[10]), .d(rf2[10]), .wen(write_en), .clk(clk), .rst(rst));
dff rf2_11(.q(rf2_out[11]), .d(rf2[11]), .wen(write_en), .clk(clk), .rst(rst));
dff rf2_12(.q(rf2_out[12]), .d(rf2[12]), .wen(write_en), .clk(clk), .rst(rst));
dff rf2_13(.q(rf2_out[13]), .d(rf2[13]), .wen(write_en), .clk(clk), .rst(rst));
dff rf2_14(.q(rf2_out[14]), .d(rf2[14]), .wen(write_en), .clk(clk), .rst(rst));
dff rf2_15(.q(rf2_out[15]), .d(rf2[15]), .wen(write_en), .clk(clk), .rst(rst));

//DECODE SIGNALS
dff D_compute_dff(.q(D_compute_out), .d(D_compute), .wen(write_en), .clk(clk), .rst(rst));
dff D_compute_imm_dff(.q(D_compute_imm_out), .d(D_compute_imm), .wen(write_en), .clk(clk), .rst(rst));
dff D_lw_dff(.q(D_lw_out), .d(D_lw), .wen(write_en), .clk(clk), .rst(rst));
dff D_sw_dff(.q(D_sw_out), .d(D_sw), .wen(write_en), .clk(clk), .rst(rst));
dff D_lhb_dff(.q(D_lhb_out), .d(D_lhb), .wen(write_en), .clk(clk), .rst(rst));
dff D_llb_dff(.q(D_llb_out), .d(D_llb), .wen(write_en), .clk(clk), .rst(rst));
dff D_b_dff(.q(D_b_out), .d(D_b), .wen(write_en), .clk(clk), .rst(rst));
dff D_br_dff(.q(D_br_out), .d(D_br), .wen(write_en), .clk(clk), .rst(rst));
dff D_pcs_dff(.q(D_pcs_out), .d(D_pcs), .wen(write_en), .clk(clk), .rst(rst));
dff D_hlt_dff(.q(D_hlt_out), .d(D_hlt), .wen(write_en), .clk(clk), .rst(rst));






endmodule