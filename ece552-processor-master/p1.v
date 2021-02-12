
module p1(clk, rst, write_en, taken, taken_out, instr, instr_out, pc, pc_out, D_compute, D_compute_out, D_compute_imm, D_compute_imm_out, D_lw, D_lw_out, D_sw, D_sw_out, D_lhb, D_lhb_out,
		D_llb, D_llb_out, D_b, D_b_out, D_br, D_br_out, D_pcs, D_pcs_out, D_hlt, D_hlt_out);

input clk, rst;
input [15:0] instr, pc;
input taken, write_en, D_compute, D_compute_imm, D_lw, D_sw, D_lhb, D_llb, D_b, D_br, D_pcs, D_hlt;
output [15:0] instr_out, pc_out;
output taken_out, D_compute_out, D_compute_imm_out, D_lw_out, D_sw_out, D_lhb_out, D_llb_out, D_b_out, D_br_out, D_pcs_out, D_hlt_out;


//branch taken
dff taken_dff(.q(taken_out), .d(taken), .wen(write_en), .clk(clk), .rst(rst));

//instr
dff instr_dff0(.q(instr_out[0]), .d(instr[0]), .wen(write_en), .clk(clk), .rst(rst));
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