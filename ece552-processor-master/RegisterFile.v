
module RegisterFile(clk, rst, SrcReg1, SrcReg2, DstReg, WriteReg, DstData, SrcData1, SrcData2);

input clk, rst, WriteReg;
input [3:0] SrcReg1, SrcReg2, DstReg;
input [15:0] DstData;
inout [15:0] SrcData1, SrcData2;


wire[15:0] Wordline1;
wire[15:0] Wordline2;
wire[15:0] Wordline3;

//ReadDecoder_4_16(RegId, Wordline)
ReadDecoder_4_16 read_decode1(.RegId(SrcReg1), .Wordline(Wordline1));
ReadDecoder_4_16 read_decode2(.RegId(SrcReg2), .Wordline(Wordline2));
//RegId, WriteReg, Wordline
WriteDecoder_4_16 write_decode(.RegId(DstReg), .WriteReg(WriteReg), .Wordline(Wordline3));

//clk, rst, D, WriteReg, ReadEnable1, ReadEnable2, Bitline1, Bitline2
Register register0(.clk(clk), .rst(rst), .D(16'b0), .WriteReg(Wordline3[0]), .ReadEnable1(Wordline1[0]), .ReadEnable2(Wordline2[0]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register register1(.clk(clk), .rst(rst), .D(DstData), .WriteReg(Wordline3[1]), .ReadEnable1(Wordline1[1]), .ReadEnable2(Wordline2[1]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register register2(.clk(clk), .rst(rst), .D(DstData), .WriteReg(Wordline3[2]), .ReadEnable1(Wordline1[2]), .ReadEnable2(Wordline2[2]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register register3(.clk(clk), .rst(rst), .D(DstData), .WriteReg(Wordline3[3]), .ReadEnable1(Wordline1[3]), .ReadEnable2(Wordline2[3]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register register4(.clk(clk), .rst(rst), .D(DstData), .WriteReg(Wordline3[4]), .ReadEnable1(Wordline1[4]), .ReadEnable2(Wordline2[4]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register register5(.clk(clk), .rst(rst), .D(DstData), .WriteReg(Wordline3[5]), .ReadEnable1(Wordline1[5]), .ReadEnable2(Wordline2[5]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register register6(.clk(clk), .rst(rst), .D(DstData), .WriteReg(Wordline3[6]), .ReadEnable1(Wordline1[6]), .ReadEnable2(Wordline2[6]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register register7(.clk(clk), .rst(rst), .D(DstData), .WriteReg(Wordline3[7]), .ReadEnable1(Wordline1[7]), .ReadEnable2(Wordline2[7]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register register8(.clk(clk), .rst(rst), .D(DstData), .WriteReg(Wordline3[8]), .ReadEnable1(Wordline1[8]), .ReadEnable2(Wordline2[8]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register register9(.clk(clk), .rst(rst), .D(DstData), .WriteReg(Wordline3[9]), .ReadEnable1(Wordline1[9]), .ReadEnable2(Wordline2[9]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register register10(.clk(clk), .rst(rst), .D(DstData), .WriteReg(Wordline3[10]), .ReadEnable1(Wordline1[10]), .ReadEnable2(Wordline2[10]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register register11(.clk(clk), .rst(rst), .D(DstData), .WriteReg(Wordline3[11]), .ReadEnable1(Wordline1[11]), .ReadEnable2(Wordline2[11]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register register12(.clk(clk), .rst(rst), .D(DstData), .WriteReg(Wordline3[12]), .ReadEnable1(Wordline1[12]), .ReadEnable2(Wordline2[12]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register register13(.clk(clk), .rst(rst), .D(DstData), .WriteReg(Wordline3[13]), .ReadEnable1(Wordline1[13]), .ReadEnable2(Wordline2[13]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register register14(.clk(clk), .rst(rst), .D(DstData), .WriteReg(Wordline3[14]), .ReadEnable1(Wordline1[14]), .ReadEnable2(Wordline2[14]), .Bitline1(SrcData1), .Bitline2(SrcData2));
Register register15(.clk(clk), .rst(rst), .D(DstData), .WriteReg(Wordline3[15]), .ReadEnable1(Wordline1[15]), .ReadEnable2(Wordline2[15]), .Bitline1(SrcData1), .Bitline2(SrcData2));




endmodule
