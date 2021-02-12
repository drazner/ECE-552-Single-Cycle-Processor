
module cpu(clk, rst_n, hlt, pc);

input clk, rst_n;
output hlt;
output [15:0] pc;

wire rst; 
assign rst = ~rst_n;

//pc register PCR
wire [15:0] PCR_D; 
wire [15:0] PCR_out; 
wire PCR_we; //write enable

assign pc = PCR_out; //set cpu.v output pc

//FLAG register FLAG
wire [2:0] FLAG_D; // [2]= Z, [1]= V, [0]= N
wire [2:0] FLAG_out; // [2]= Z, [1]= V, [0]= N


//PC control PC
wire [2:0] PC_condition;
wire [8:0] PC_offset;
wire [2:0] PC_flags; // [N, V, Z]
wire [15:0] PC_out;
wire PC_taken;


//instruction memory IM
wire [15:0] IM_instr; //IM_instr[15:12]= opcode, IM_instr[11:8]= rd, IM_instr[7:4]= rs, IM_instr[3:0]= rt
//wire [15:0] IM_instr_hack;
//assign IM_instr_hack = (IM_instr === 16'hXXXX) ? 16'hC202 : IM_instr;
wire [15:0] IM_addr;
wire IM_en = 1;
wire IM_wr = 0;



//I-CACHE
//I-Cache Controller ICC
wire ICC_miss_detected;
wire [15:0] ICC_miss_address;
wire ICC_fsm_busy;
wire ICC_write_data_array;
wire ICC_write_tag_array;
wire [15:0] ICC_memory_address;
wire [15:0] ICC_memory_data;
wire ICC_memory_data_valid;
wire [15:0] ICC_cache_data;
wire [15:0] ICC_mem_out;
wire ICC_counter_e2;

//assign IM_addr = PCR_out; //stage3 removed
assign ICC_miss_address = PCR_out; //stage3 added


//3 to 8 Decoder Instr
wire [7:0] I_4_8_out; 

//3 to 8 Decoder Data
wire [7:0] D_4_8_out;

//MetaDataArray IMD
wire [4:0] IMD_tagbits; 
wire IMD_validbit; 
wire IMD_Write; 
wire [127:0] IMD_BlockEnable; 
wire [7:0] IMD_DataOut; 

//DataArray IDA
wire [15:0] IDA_DataIn;
wire IDA_Write;
wire [127:0] IDA_Block_Enable;
wire [7:0] IDA_WordEnable;
wire [15:0] IDA_DataOut;



//Decoder 1:128 ID
wire [6:0] ID_Datain;
wire [127:0] ID_Wordline;
assign ID_Datain = PCR_out[10:4]; // switches block enable 1 too early (because PC starts at 2)
//assign ID_Datain = (PCR_out[4] & (PCR_out[3:0] == 4'b0)) ? {PCR_out[10:5], 1'b0} : PCR_out[10:4];


//decoder D
wire [3:0] D_opcode;
wire D_compute, D_compute_imm, D_LW, D_SW, D_LHB, D_LLB, D_B, D_BR, D_PCS, D_HLT;

//reg file RF
wire [3:0] RF_read1; //address for read1 port
wire [3:0] RF_read2; //address for read2 port
wire [3:0] RF_write; //address for write port
wire RF_write_en; //write enable
wire [15:0] RF_out1; //read1 output
wire [15:0] RF_out2; //read2 output
wire [15:0] RF_in; //write input

//ALU
wire [3:0] ALU_opcode;
wire [15:0] ALU_A;
wire [15:0] ALU_B;
wire [15:0] ALU_out;
wire [2:0] ALU_flags; // [2]= Z, [1]= V, [0]= N

//data memory DM
wire [15:0] DM_out;
wire [15:0] DM_in;
wire [15:0] DM_addr;
wire DM_en;
wire DM_wr;

//D-CACHE
//D-Cache Controller DCC
wire DCC_miss_detected;
wire DCC_miss_detected_correction; //only high if READ not Write
wire [15:0] DCC_miss_address;
wire DCC_fsm_busy;
wire DCC_write_data_array;
wire DCC_write_tag_array;
wire [15:0] DCC_memory_address;
wire [15:0] DCC_memory_data;
wire DCC_memory_data_valid;
wire [15:0] DCC_cache_data;

//MetaDataArray DMD
wire [4:0] DMD_tagbits; 
wire DMD_validbit; 
wire DMD_Write; 
wire [127:0] DMD_BlockEnable; 
wire [7:0] DMD_DataOut; 

//DataArray DDA
wire [15:0] DDA_DataIn;
wire DDA_Write;
wire [127:0] DDA_Block_Enable;
wire [7:0] DDA_WordEnable;
wire [15:0] DDA_DataOut;

assign DDA_WordEnable = D_4_8_out;

//Multicycle Mem DMM
//data memory DM
//wire [15:0] DMM_out;
//wire [15:0] DMM_in;
//wire [15:0] DMM_addr;
//wire DMM_en;
//wire DMM_wr;
//wire DMM_data_valid;

//Multicycle Mem MM
//memory4c mem4c(.data_out(), .data_in(), .addr(), .enable(), .wr(), .clk(clk), .rst(rst), .data_valid());
wire [15:0] MM_data;
wire [15:0] MM_addr;
wire MM_en = 1;
wire MM_wr;
wire MM_data_valid;
wire [15:0] MM_in;


//assign MM_addr = (DCC_miss_detected === 1'b1) ? DCC_memory_address : (ICC_miss_detected === 1'b1) ? ICC_memory_address : (p3_sw) ? ALU_out : 16'hzzzz; //put lower down

//Decoder 7:128
wire [6:0] DD_Datain;
wire [127:0] DD_Wordline;


//forwardUnit FU
//P2_Rs, P2_Rt, P3_Rd, P4_Rd, P3_WB, P4_WB, forwardA, forwardB
wire [1:0] FU_A;
wire [1:0] FU_B;
wire [3:0] FU_rs;

//hazard detection HD
wire HD_read;
wire HD_stall;
//wire HD_stall_branch;
wire HD_flush;

//PIPELINE SIGNALS//////////

//p1
wire [15:0] p1_instr;
wire [15:0] p1_pc;
wire p1_taken; //branch taken for pc control
wire p1_compute, p1_compute_imm, p1_lw, p1_sw, p1_lhb, p1_llb, p1_b, p1_br, p1_pcs, p1_hlt;
wire p1_we; //write enable for stalls


//p2
wire [15:0] p2_instr;
wire [15:0] p2_rf1;
wire [15:0] p2_rf2;
wire [15:0] p2_pc;
wire p2_compute, p2_compute_imm, p2_lw, p2_sw, p2_lhb, p2_llb, p2_b, p2_br, p2_pcs, p2_hlt;
wire p2_we; //write enable for stalls
wire [15:0] p2_nop; //determines whether a noop occurs

//p3
wire [15:0] p3_alu;
wire [15:0] p3_instr;
wire [15:0] p3_rf1;
wire [15:0] p3_rf2;
wire [15:0] p3_pc;
wire p3_we; //write enable for DMM stalls
wire p3_compute, p3_compute_imm, p3_lw, p3_sw, p3_lhb, p3_llb, p3_b, p3_br, p3_pcs, p3_hlt;

//p4
wire [15:0] p4_dm;
wire [15:0] p4_instr;
wire [15:0] p4_alu;
wire [15:0] p4_pc;
wire [15:0] p4_rf1;
wire [15:0] p4_rf2;
wire p4_we; //write enable for DMM stalls
wire p4_compute, p4_compute_imm, p4_lw, p4_sw, p4_lhb, p4_llb, p4_b, p4_br, p4_pcs, p4_hlt;

//assign MM_addr = ((DCC_miss_detected === 1'b1) & ~DDA_Write) ? DCC_memory_address : (ICC_miss_detected === 1'b1) ? ICC_memory_address : (p3_sw) ? ALU_out : 16'hzzzz;
assign MM_addr = ((DCC_miss_detected === 1'b1) & ~DDA_Write) ? DCC_miss_address : (ICC_miss_detected === 1'b1) ? ICC_memory_address : (p3_sw) ? ALU_out : 16'hzzzz;

////////////////////////////


// CONTROL ///////////////////////////////////////////////////////////////////////////////////////

// IM_instr = opcode, rd, rs, rt
// IM_instr[15:12]= opcode, IM_instr[11:8]= rd, IM_instr[7:4]= rs, IM_instr[3:0]= rt

//wire [3:0] opcode = IM_instr[15:12]; //phase3 removed
//wire [3:0] rd = IM_instr[11:8]; // p1_instr[11:8] //phase3 removed
//wire [3:0] rs = IM_instr[7:4]; // p1_instr[7:4] //phase3 removed
//wire [3:0] rt = IM_instr[3:0]; // p1_instr[3:0] //phase3 removed

wire [3:0] opcode = IDA_DataOut[15:12]; //phase3 added
wire [3:0] rd = IDA_DataOut[11:8]; // p1_instr[11:8] //phase3 added
wire [3:0] rs = IDA_DataOut[7:4]; // p1_instr[7:4] //phase3 added
wire [3:0] rt = IDA_DataOut[3:0]; // p1_instr[3:0] //phase3 added



//reg file CONTROL
//wire [15:0] LW_data; //from data mem to reg file
//assign RF_read1 = (p1_compute | p1_compute_imm | p1_lw | p1_sw | D_BR) ? p1_instr[7:4] : 4'bz; //address for read1 port -- comes from p1 //p1_br
assign RF_read1 = (p1_compute | p1_compute_imm | p1_lw | p1_sw) ? p1_instr[7:4] : (D_BR) ? IDA_DataOut[7:4] : 4'bz;//changed D_BR to come form instr_out directly
assign RF_read2 = (p1_compute) ? p1_instr[3:0] : (p1_sw | p1_lhb | p1_llb) ? p1_instr[11:8] : 4'bz; //address for read2 port -- comes from p1
assign RF_write_en = (p4_compute | p4_compute_imm | p4_lw | p1_lhb | p1_llb | p4_pcs) ? 1'b1 : 1'b0; //all signals that write to RF -- comes from p4
assign RF_write = (p4_pcs | p4_compute | p4_compute_imm | p4_lw) ? p4_instr[11:8] : (p1_lhb | p1_llb) ? p1_instr[11:8] : 4'bz; //address for write port -- comes from p1 //phase3 removed
//assign RF_write = (p1_lhb | p1_llb) ? p1_instr[11:8] : (p4_pcs | p4_compute | p4_compute_imm | p4_lw) ? p4_instr[11:8] : 4'bz;//phase3 change priority
assign RF_in = (p4_pcs) ? p4_pc : (p4_compute | p4_compute_imm) ? p4_alu : (p4_lw) ? p4_dm : (p1_lhb) ? {p1_instr[7:4], p1_instr[3:0], RF_out2[7:0]} : (p1_llb) ? {RF_out2[15:8], p1_instr[7:4], p1_instr[3:0]} : 16'bz; //write input
//////////////////////////^^ might be wrong? p1_pc should come from PCR_out? not PC_out?


//I-Meta Data Array
assign IMD_BlockEnable = ID_Wordline;
assign IMD_tagbits = PCR_out[15:11]; 
assign IMD_validbit = 1'b1; 
assign IMD_Write = ICC_write_tag_array; 


//I-Cache Data Array
assign IDA_Write = ICC_write_data_array; 
assign IDA_DataIn = ICC_cache_data; 
assign IDA_Block_Enable = ID_Wordline; 
assign IDA_WordEnable = I_4_8_out; 

//I-Cache FSM
assign ICC_miss_detected = (IMD_DataOut[0] === 1'b0) ? 1'b1: (IMD_DataOut[5:1] === PCR_out[15:11]) ? 1'b0: 1'b1;
assign ICC_memory_data_valid = MM_data_valid; 
assign ICC_memory_data = MM_data;

//if IMD_DataOut LSB is 0, miss detected = 1

//ALU CONTROL opcode,rd,rs,rt
assign ALU_opcode = (p2_compute | p2_compute_imm | p2_lw | p2_sw) ? p2_instr[15:12] : 4'bz;
//              A <= RF[rs]read1                              A <= RF[rs](read1) & 0xFFFE
assign ALU_A = ((FU_A == 2'b10) & (p4_compute | p4_compute_imm)) ? p4_alu : ((FU_A == 2'b10) & p4_lw) ? p4_dm : (FU_A == 2'b01) ? p3_alu : (p2_compute | p2_compute_imm) ? p2_rf1 : (p2_lw | p2_sw) ? (p2_rf1 & 16'hFFFE) : 16'bz; //comes from p2
//              B <= RF[rt]read2                         B <= sign extended rt                                B <= left shift rt and sign extend
assign ALU_B = ((FU_B == 2'b10) & (p4_compute | p4_compute_imm)) ? p4_alu : ((FU_B == 2'b10) & p4_lw) ? p4_dm : (FU_B == 2'b01) ? p3_alu : (p2_compute) ? p2_rf2 : (p2_compute_imm) ? {{12{p2_instr[3]}}, p2_instr[3:0]} : (p2_lw | p2_sw) ? {{11{p2_instr[3]}}, p2_instr[3:0], 1'b0} : 16'bz; //comes from p2
//write FLAGs
assign FLAG_D = (p2_compute | p2_compute_imm) ? ALU_flags : FLAG_out; //should be FLAG_out (instead of ...: FLAG_D;)?
 

//D-Meta Data Array
assign DMD_BlockEnable = DD_Wordline;
assign DMD_tagbits = ALU_out[15:11];
assign DMD_validbit = 1'b1;
assign DMD_Write = DCC_write_tag_array;

//D_Cache FSM
//assign DCC_miss_detected = (p3_lw) ? (DMD_DataOut[0] === 1'b0) ? 1'b1 : (DMD_DataOut[5:1] === ALU_out[15:11]) ? 1'b0 : 1'b1 : 1'b0; //triple equal; added p3_lw check; 
assign DCC_miss_detected = (p3_lw) ? (DMD_DataOut[5:1] === ALU_out[15:11]) ? 1'b0 : 1'b1 : 1'b0; //take out valid bit check
assign DCC_memory_data_valid = MM_data_valid; 
assign DCC_memory_data = MM_data;

//D-Cache Data Array
//assign DDA_Write = DCC_write_data_array; 
assign DDA_Write = p3_sw;
//assign DDA_DataIn = (p3_lw) ? (DCC_miss_detected) ? DCC_cache_data : p3_alu : DCC_cache_data;
assign DDA_DataIn = p3_rf2;
assign DDA_Block_Enable = DD_Wordline; 
assign DDA_WordEnable = D_4_8_out; 

//DataArray decoder
assign DD_Datain = (p3_sw | p3_lw) ? ALU_out[10:4] : 7'bzzzzzzz; //phase3 try these 7 bits

assign DCC_miss_detected_correction = (DDA_Write) ? 1'b0 : DCC_miss_detected; //phase3


//PC CONTROL
assign PC_flags = (~rst_n) ? 3'b0 : FLAG_D; //FLAG_out
assign PCR_D = (~rst_n) ? 16'b0 : ((PC_taken === 1'b1) & D_BR) ? RF_read1 : (D_HLT) ? PCR_out : PC_out; //p1_br //ADD STALL mux from HAZARD DETECTION -- nope, disabling wr en instead //(p1_taken & p1_br) //(PC_taken & D_BR) //(p1_taken & p1_br) p2_rf1
assign PC_condition = (D_B | D_BR) ? rd[3:1] : 3'bz; //(D_B | D_BR) ? rd[3:1] : 3'bz; //(p1_b | p1_br) ? p1_instr[11:9] : 3'bz;

//assign PC_offset = IM_instr[8:0]; //IM_instr[8:0]; //p1_instr[8:0]; //phase3 removed
assign PC_offset = IDA_DataOut[8:0]; //phase3 added

assign PCR_we = ((HD_stall === 1'b1) | (ICC_fsm_busy === 1'b1) | (DCC_fsm_busy === 1'b1)) ? 1'b0 : 1'b1; //HD_stall


// Decoder control
assign D_opcode = opcode; // p1_instr[15:12]; CHANGED BACK
assign hlt = p4_hlt;

//data memory CONTROL
//assign DM_en = (p3_lw | p3_sw); //read or write en //phase3 removed
//assign MM_en = (p3_lw | p3_sw); //phase3 added
//assign DM_wr = p3_sw; //1 for write, 0 for read //phase3 removed
assign MM_wr = p3_sw; //phase3 added

//assign DM_in = (p3_sw) ? p3_rf2 : 16'bz; //phase3 removed
assign MM_in = (p3_sw) ? p3_rf2 : 16'bz; //phase3 added

//assign LW_data = (D_LW) ? DM_out : 16'bz;

//assign DM_addr = (p3_lw | p3_sw) ? p3_alu : 16'bz; //stage3 removed
assign DCC_miss_address = (p3_lw | p3_sw) ? p3_alu : 16'bz; //stage3 added

//forward unit CONTROL
assign FU_rs = (p2_llb & p2_lhb) ? p2_instr[11:8] : p2_instr[7:4];

//hazard detection CONTROL
assign HD_read = ((p1_compute | p1_compute_imm | p1_lw | p1_sw | p1_br)) ? (RF_write === 4'bz) ? 1'b1 : ~((RF_write == p1_instr[7:4]) | (RF_write == p1_instr[3:0])) ? 1'b1 : 1'b0 : 1'b0; //stall should go away eventually // & ~((RF_write == p1_instr[7:4]) | (RF_write == p1_instr[3:0]))
assign p1_we = ((HD_stall === 1'b1) | (ICC_fsm_busy === 1'b1) | (DCC_fsm_busy === 1'b1)) ? 1'b0 : 1'b1;
assign p2_we = ((HD_stall === 1'b1) | (ICC_fsm_busy === 1'b1) | (DCC_fsm_busy === 1'b1)) ? 1'b0 : 1'b1;
assign p2_nop = (HD_flush === 1'b1) ? 16'h7000 : p1_instr; //nop is PADDSB to R0
assign p3_we = ((ICC_fsm_busy === 1'b1) | (DCC_fsm_busy === 1'b1)) ? 1'b0 : 1'b1;
assign p4_we = ((ICC_fsm_busy === 1'b1) | (DCC_fsm_busy === 1'b1)) ? 1'b0 : 1'b1;
//assign HD_stall_branch = (D_B | D_BR) ? (p2_b | p2_br) ? 1'b0 : 1'b1 : 1'b0; //(PC_condition === 3'bz) ? 1'b1 : (PC_condition == IM_instr[11:9]) ? 1'b0 : 1'b1 : 1'b0;



//SW    addr[rs + offset] <= RF[rd]
//wire [15:0] SW_data; //data comes from RF[rd](read2)
//assign SW_data = (D_SW) ? RF_out2 : 16'bz;


// ^^CONTROL^^ ///////////////////////////////////////////////////////////////////////////////////////


//instantiate pc register
pc_register cpu_pc(.clk(clk), .rst(rst), .write_en(PCR_we), .D(PCR_D), .pc_out(PCR_out));

//instantiate FLAG reg
FLAG flag_reg(.clk(clk), .rst(rst), .D(FLAG_D), .flag_out(FLAG_out));

//instantiate PC control
PC_control pc_cntrl(.B(D_B | D_BR), .C(PC_condition), .I(PC_offset), .F(PC_flags), .PC_in(PCR_out), .PC_out(PC_out), .taken(PC_taken)); //.B(p1_b | p1_br), .C(PC_condition), .I(PC_offset), .F(PC_flags), .PC_in(PCR_out), .PC_out(PC_out), .taken(PC_taken)

//B(D_B | D_BR), .C(PC_condition), .I(PC_offset)

//instantiate instr mem
memory1c instr_mem(.data_out(IM_instr), .data_in(), .addr(IM_addr), .enable(IM_en), .wr(IM_wr), .clk(clk), .rst(rst));


//instantiate deconder_7_128 INSTR
decoder_7_128 i_decoder_7_128(.Datain(ID_Datain), .Wordline(ID_Wordline));

//I-CACHE
//instantiate cache_fill_FSM for INSTR
cache_fill_FSM i_contrl(.clk(clk), .rst_n(rst_n), .miss_detected(ICC_miss_detected), .miss_address(ICC_miss_address), 
			.fsm_busy(ICC_fsm_busy), .write_data_array(ICC_write_data_array), .write_tag_array(ICC_write_tag_array), 
			.memory_address(ICC_memory_address), .memory_data(ICC_memory_data), .memory_data_valid(ICC_memory_data_valid), .cache_data(ICC_cache_data), 
			.mem_output(ICC_mem_out), .counter_e2(ICC_counter_e2));

//instantiate incrementer
wire [3:0] inc_out;
increment incrementer(.clk(clk), .rst(rst), .start(ICC_counter_e2), .out(inc_out), .pcr(PCR_out));


//instantiate MetaDataArray for INSTR
MetaDataArray i_metaData(.clk(clk), .rst(rst), .DataIn({2'b00,IMD_tagbits,IMD_validbit}), .Write(IMD_Write), .BlockEnable(IMD_BlockEnable), .DataOut(IMD_DataOut));

//3 to 8 decoder
//decoder_4_8 i_decoder_4_8(.Datain(PCR_out[3:0]), .Word_enable(I_4_8_out));
//decoder_4_8 i_decoder_4_8(.Datain(ICC_mem_out[3:0]), .Word_enable(I_4_8_out));
wire [3:0] array_select;
assign array_select = (ICC_counter_e2) ? inc_out : PCR_out[3:0];
decoder_4_8 i_decoder_4_8(.Datain(array_select), .Word_enable(I_4_8_out));


//instantiate DataArray for INSTR
DataArray i_dataArray(.clk(clk), .rst(rst), .DataIn(IDA_DataIn), .Write(IDA_Write), .BlockEnable(IDA_Block_Enable), .WordEnable(IDA_WordEnable), .DataOut(IDA_DataOut));

//instantiate multicycle_memory for INSTR
memory4c mem4c(.data_out(MM_data), .data_in(MM_in), .addr(MM_addr), .enable(MM_en), .wr(MM_wr), .clk(clk), .rst(rst), .data_valid(MM_data_valid));




//instantiate PIPELINE 1 -- ADD STALL FROM HAZARD DETECTION
p1 pipeline1(.clk(clk), .rst(rst), .write_en(p1_we), .taken(PC_taken), .taken_out(p1_taken), .instr(IDA_DataOut), .instr_out(p1_instr), .pc(PC_out), .pc_out(p1_pc),
	.D_compute(D_compute), .D_compute_out(p1_compute), .D_compute_imm(D_compute_imm), .D_compute_imm_out(p1_compute_imm), 
	.D_lw(D_LW), .D_lw_out(p1_lw), .D_sw(D_SW), .D_sw_out(p1_sw), .D_lhb(D_LHB), .D_lhb_out(p1_lhb), 
	.D_llb(D_LLB), .D_llb_out(p1_llb), .D_b(D_B), .D_b_out(p1_b), .D_br(D_BR), .D_br_out(p1_br), 
	.D_pcs(D_PCS), .D_pcs_out(p1_pcs), .D_hlt(D_HLT), .D_hlt_out(p1_hlt)); //phase3 IM_instr replaced with IDA_DataOut
							

//instantiate decoder
decoder opcode_decoder(.opcode(D_opcode), .compute(D_compute), .compute_imm(D_compute_imm), .LW(D_LW), .SW(D_SW), .LHB(D_LHB), .LLB(D_LLB), .B(D_B), .BR(D_BR), .PCS(D_PCS), .HLT(D_HLT));

//instantiate reg file
RegisterFile reg_file(.clk(clk), .rst(rst), .SrcReg1(RF_read1), .SrcReg2(RF_read2), .DstReg(RF_write), .WriteReg(RF_write_en), .DstData(RF_in), .SrcData1(RF_out1), .SrcData2(RF_out2));


//instantiate PIPELINE 2 //p2_nop
p2 pipeline2(.clk(clk), .rst(rst), .write_en(p2_we), .pc(p1_pc), .pc_out(p2_pc), .instr(p2_nop), .instr_out(p2_instr), .rf1(RF_out1), 
	.rf1_out(p2_rf1), .rf2(RF_out2), .rf2_out(p2_rf2), .D_compute(p1_compute), 
	.D_compute_out(p2_compute), .D_compute_imm(p1_compute_imm), .D_compute_imm_out(p2_compute_imm), 
	.D_lw(p1_lw), .D_lw_out(p2_lw), .D_sw(p1_sw), .D_sw_out(p2_sw), .D_lhb(p1_lhb), .D_lhb_out(p2_lhb), 
	.D_llb(p1_llb), .D_llb_out(p2_llb), .D_b(p1_b), .D_b_out(p2_b), .D_br(p1_br), .D_br_out(p2_br), 
	.D_pcs(p1_pcs), .D_pcs_out(p2_pcs), .D_hlt(p1_hlt), .D_hlt_out(p2_hlt));



//insantiate ALU
alu cpu_alu(.opcode(ALU_opcode), .A(ALU_A), .B(ALU_B), .ALU_out(ALU_out), .flags(ALU_flags));


//intantiate PIPELINE 3
p3 pipeline3(.clk(clk), .rst(rst), .write_en(p3_we), .pc(p2_pc), .pc_out(p3_pc), .alu(ALU_out), .alu_out(p3_alu), .instr(p2_instr), .instr_out(p3_instr), .rf1(p2_rf1), 
	.rf1_out(p3_rf1), .rf2(p2_rf2), .rf2_out(p3_rf2), .D_compute(p2_compute), 
	.D_compute_out(p3_compute), .D_compute_imm(p2_compute_imm), .D_compute_imm_out(p3_compute_imm), 
	.D_lw(p2_lw), .D_lw_out(p3_lw), .D_sw(p2_sw), .D_sw_out(p3_sw), .D_lhb(p2_lhb), .D_lhb_out(p3_lhb), 
	.D_llb(p2_llb), .D_llb_out(p3_llb), .D_b(p2_b), .D_b_out(p3_b), .D_br(p2_br), .D_br_out(p3_br), 
	.D_pcs(p2_pcs), .D_pcs_out(p3_pcs), .D_hlt(p2_hlt), .D_hlt_out(p3_hlt));


//instantiate data mem
memory1c data_mem(.data_out(DM_out), .data_in(DM_in), .addr(DM_addr), .enable(DM_en), .wr(DM_wr), .clk(clk), .rst(rst));


//D-CACHE
//instantiate cache_fill_FSM for DATA
cache_fill_FSM d_contrl(.clk(clk), .rst_n(rst_n), .miss_detected(DCC_miss_detected_correction), .miss_address(DCC_miss_address), 
			.fsm_busy(DCC_fsm_busy), .write_data_array(DCC_write_data_array), .write_tag_array(DCC_write_tag_array), 
			.memory_address(DCC_memory_address), .memory_data(DCC_memory_data), .memory_data_valid(DCC_memory_data_valid), .cache_data(DCC_cache_data));

//instantiate MetaDataArray for DATA
MetaDataArray d_metaData(.clk(clk), .rst(rst), .DataIn({2'b00, DMD_tagbits, DMD_validbit}), .Write(DMD_Write), .BlockEnable(DMD_BlockEnable), .DataOut(DMD_DataOut));


//instantiate DataArray for DATA
DataArray d_dataArray(.clk(clk), .rst(rst), .DataIn(DDA_DataIn), .Write(DDA_Write), .BlockEnable(DDA_Block_Enable), .WordEnable(DDA_WordEnable), .DataOut(DDA_DataOut));

//instantiate multicycle_memory for DATA
//memory4c d_mem4c(.data_out(DMM_out), .data_in(DMM_in), .addr(DMM_addr), .enable(DMM_en), .wr(DMM_wr), .clk(clk), .rst(rst), .data_valid(DMM_data_valid));

//instantiate deconder_7_128 for DATA
decoder_7_128 d_decoder_7_128(.Datain(DD_Datain), .Wordline(DD_Wordline));

//3 to 8 decoder
decoder_4_8 d_decoder_4_8(.Datain(ALU_out[3:0]), .Word_enable(D_4_8_out));

//intantiate PIPELINE 4
p4 pipeline4(.clk(clk), .rst(rst), .write_en(p4_we), .rf1(p3_rf1), .rf1_out(p4_rf1), .rf2(p3_rf2), .rf2_out(p4_rf2), .pc(p3_pc), .pc_out(p4_pc), 
	.alu(p3_alu), .alu_out(p4_alu), .dm(DDA_DataOut), .dm_out(p4_dm), .instr(p3_instr), .instr_out(p4_instr),
	.D_compute(p3_compute), .D_compute_out(p4_compute), .D_compute_imm(p3_compute_imm), .D_compute_imm_out(p4_compute_imm), 
	.D_lw(p3_lw), .D_lw_out(p4_lw), .D_sw(p3_sw), .D_sw_out(p4_sw), .D_lhb(p3_lhb), .D_lhb_out(p4_lhb), 
	.D_llb(p3_llb), .D_llb_out(p4_llb), .D_b(p3_b), .D_b_out(p4_b), .D_br(p3_br), .D_br_out(p4_br), 
	.D_pcs(p3_pcs), .D_pcs_out(p4_pcs), .D_hlt(p3_hlt), .D_hlt_out(p4_hlt)); //phase3 DM_out replaced with DDA_DataOut

//instantiate forwardUnit
forwardUnit FU(.compute(p2_compute), .lw(p3_lw & p4_lw), .l_type(p3_llb | p3_lhb | p4_llb | p4_lhb), .P2_Rs(FU_rs), .P2_Rt(p2_instr[3:0]), .P3_Rd(p3_instr[11:8]), .P4_Rd(p4_instr[11:8]), 
		.P3_WB(p3_compute | p3_compute_imm | p3_lw | p3_lhb | p3_llb | p3_pcs), 
		.P4_WB(p4_compute | p4_compute_imm | p4_lw | p4_lhb | p4_llb | p4_pcs), 
		.forwardA(FU_A), .forwardB(FU_B));

//instantiate hazard detection //p4_pcs | p4_compute | p4_compute_imm | p4_lw) ? p4_instr[11:8] : (p1_lhb | p1_llb)
hazard_detection HD(.p4_reg_cont(p4_pcs | p4_compute | p4_compute_imm | p4_lw), .p1_lhb_llb(p1_lhb | p1_llb), .p1_taken(p1_taken), .p1_br(p1_br), .read(HD_read), .compute(p1_compute), .p1_rs(p1_instr[7:4]), .p1_rt(p1_instr[3:0]), .p2_lw(p2_lw), .p2_rt(p2_instr[11:8]), .hazard_stall(HD_stall), .hazard_flush(HD_flush));


endmodule 