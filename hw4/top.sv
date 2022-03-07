`include "SRAM_wrapper.sv"
`include "MUX3to1.sv"
`include "ProgramCounter.sv"
`include "ImmG.sv"
`include "Regfile.sv"
`include "Decoder.sv"
`include "MEMWB.sv"
`include "IF_ID.sv"
`include "ID_EX.sv"
`include "EXMEM.sv"
`include "ALU.sv"
`include "BranchCtrl.sv"
`include "AluCtrl.sv"
`include "HazardCtrl.sv"
`include "ForwardUnit.sv"

module top(rst,clk);
    input rst,clk;
    //output logic [31:0] out;
  

// IF STAGE
    logic [31:0] pc_in,pc_out,pc_add_4;
    logic [31:0] instr;
    logic flush,flush2,IFIDwrite,PCwrite;
    logic [1:0] b_ctrl;
    logic [31:0] EX_alu_out;
    logic [31:0] EX_pc;
    logic [31:0] EX_imm;
    assign pc_add_4=pc_out+4;
   
    MUX3to1 m1(EX_alu_out,(EX_pc+EX_imm),pc_add_4,b_ctrl,pc_in);	


    ProgramCounter pc(clk,rst,PCwrite,pc_in,pc_out);
    


   SRAM_wrapper IM1(
   .CK(~clk),
   .CS(1'b1),
   .OE(1'b1),
   .WEB(4'b1111),
   .A(pc_out[15:2]),
   .DI(32'd0),
   .DO(instr)
   );


    //SRAM_wrapper IM1(~clk,1'b1,1'b1,4'b1111,pc_out[15:2],32'd0,instr);

  
    
    logic [1:0] Branch;
    logic zeroflag;

//ID Stage


    logic [31:0] ID_inst;
    logic [31:0] ID_pc;
    logic[4:0] rd,rs1,rs2;
    logic[2:0] funct3;
    logic[6:0] funct7;
    logic[31:0] imm;
    logic[2:0] ImmType;
    logic[31:0] rs1data,rs2data;
    
    IF_ID ifid(clk,rst,flush,IFIDwrite,pc_out,instr,ID_pc,ID_inst);
    always @(*) begin
        if(flush) begin
            rd=0;
            rs1=0;
            rs2=0;
            funct3=0;
            funct7=0;
        end
        else begin
            rd=ID_inst[11:7];
            rs1=ID_inst[19:15];
            rs2=ID_inst[24:20];
            funct3=ID_inst[14:12];
            funct7=ID_inst[31:25];
        end
    end

    ImmG immg(ImmType,ID_inst,imm);

    logic [2:0] Aluop;
    logic Alusrc,Memread,Memwrite,Memtoreg,Regwrite,PCtoregsrc,RDsrc;
    Decoder dc(ID_inst[6:0],ImmType,Branch,Aluop,Alusrc,RDsrc,PCtoregsrc,Regwrite,Memread,Memwrite,Memtoreg);


    //EX Stage
 
    logic [31:0] EX_rs1_data,EX_rs2_data;
    logic [2:0] EX_funct3;
    logic [6:0] EX_funct7;
    logic [1:0] EX_Branch;
    logic [4:0] EX_rs1_addr,EX_rs2_addr,EX_rd_addr;
    logic [2:0] EX_Aluop;
    logic EX_Alusrc,EX_Memread,EX_Memwrite,EX_Memtoreg,EX_Regwrite,EX_PCtoregsrc,EX_RDsrc;
    logic [31:0] EX_forward_rs2_data;
    ID_EX idex(clk,rst,flush2,ID_pc,Branch,Aluop,RDsrc,Alusrc,Memread,Memwrite,Memtoreg,Regwrite,PCtoregsrc,
		rs1data,rs2data,imm,funct3,funct7,rs1,rs2,rd,EX_Branch,EX_Aluop,EX_RDsrc,
		EX_Alusrc,EX_Memread,EX_Memwrite,EX_Memtoreg,EX_Regwrite,EX_PCtoregsrc,EX_rs1_data,EX_rs2_data,EX_pc,EX_imm,EX_funct3,EX_funct7,EX_rs1_addr,EX_rs2_addr,EX_rd_addr);

    BranchCtrl bc(EX_Branch,zeroflag,b_ctrl);

    logic [4:0] aluctrl;
    AluCtrl acl(EX_funct3,EX_funct7,EX_Aluop,aluctrl);

    logic [1:0] forwardrs1src,forwardrs2src;
    logic forwardrdsrc;
    logic [31:0] alusrca,alusrcb;
    logic [31:0] pc_to_reg;
    assign pc_to_reg=EX_PCtoregsrc?(EX_pc+4):(EX_pc+EX_imm);

    
    logic [31:0] alusrcb_final;
    assign alusrcb_final = EX_Alusrc?EX_imm:alusrcb;
    ALU alu(alusrca,alusrcb_final,aluctrl,zeroflag,EX_alu_out);
	

    //MEM
    logic MEM_Memread,MEM_Memwrite,MEM_Memtoreg,MEM_Regwrite,MEM_PCtoregsrc,MEM_RDsrc;
    logic [31:0] MEM_rd_data;
    logic [4:0] MEM_rd_addr;
    logic [31:0] MEM_pc_to_reg,MEM_alu_out;
    logic [31:0] MEM_data_in,MEM_data_out;
    logic [31:0] MEM_forward_rs2_data;
   
    logic [2:0] MEM_funct3; 
    assign EX_forward_rs2_data=alusrcb;

    EXMEM exmem(
        clk,rst,
        EX_Memread,EX_Memwrite,EX_Memtoreg,EX_Regwrite,EX_PCtoregsrc,EX_RDsrc,
        pc_to_reg,
        EX_alu_out,
        EX_forward_rs2_data,
        EX_rd_addr,
	EX_funct3,
        MEM_Memread,MEM_Memwrite,MEM_Memtoreg,MEM_Regwrite,MEM_PCtoregsrc,MEM_RDsrc,
        MEM_pc_to_reg,
        MEM_alu_out,
        MEM_forward_rs2_data,
        MEM_rd_addr,
	MEM_funct3
    );

    


    
    //WB STAGE
    logic WB_Memread,WB_Memwrite,WB_Memtoreg,WB_Regwrite,WB_PCtoregsrc,WB_RDsrc;
    logic [4:0] WB_rd_addr;
    logic [31:0] WB_rd_data;
    logic [31:0] WB_wb_data;
    logic [31:0] WB_data_out;
    
    logic [2:0] WB_funct3;
    assign MEM_rd_data=MEM_RDsrc?MEM_alu_out:MEM_pc_to_reg;

   
  

     logic chipselect;
    assign chipselect=MEM_Memread|MEM_Memwrite;
   
    logic [3:0] WEB; 
    logic [31:0] MEM_di;
    logic [1:0] byte_offset;
    logic hb_offset;
    assign byte_offset = MEM_alu_out %4;
    assign hb_offset = MEM_alu_out[31:1] %2;
    always@(*)begin
    if(MEM_Memwrite) begin
	MEM_di = 0;
	case(MEM_funct3)
		3'b010:begin//sw
			MEM_di = MEM_data_in;
			WEB = 4'b0000;
		end
		3'b000:begin//sb
			case(byte_offset)
				2'b00:begin
					MEM_di[7:0]   = MEM_data_in[7:0];
					WEB = 4'b1110;
				end
				2'b01:begin
					MEM_di[15:8]  = MEM_data_in[7:0];
					WEB = 4'b1101;
				end
				2'b10:begin
					MEM_di[23:16] = MEM_data_in[7:0];
					WEB = 4'b1011;
				end
				2'b11:begin
					MEM_di[31:24] = MEM_data_in[7:0];
					WEB = 4'b0111;
				end

			endcase
		end
		3'b001:begin//sh
			case(hb_offset)
				1'b0:begin
					MEM_di[15:0] = MEM_data_in[15:0];
					WEB = 4'b1100;
				end
				1'b1:begin
					MEM_di[31:16] = MEM_data_in[15:0];
					WEB = 4'b0011;
				end
			endcase
		end
		default:begin
			MEM_di = MEM_data_in;
			WEB = 4'b1111;
		end
	endcase
    
    end
    else begin
	WEB = 4'b1111;//not store
	MEM_di = MEM_data_in;
    end
  end


    SRAM_wrapper DM1(
    .CK(~clk),
    .CS(1'b1),
    .OE(1'b1),
    .WEB(WEB),
    .A(MEM_alu_out[15:2]),
    .DI(MEM_di),
    .DO(MEM_data_out)
    );


    MEMWB memwb(
        clk,rst,
        MEM_Memread,MEM_Memwrite,MEM_Memtoreg,MEM_Regwrite,MEM_PCtoregsrc,MEM_RDsrc,
        MEM_rd_data,
        MEM_data_out,
        MEM_rd_addr,
	MEM_funct3,
        WB_Memread,WB_Memwrite,WB_Memtoreg,WB_Regwrite,WB_PCtoregsrc,WB_RDsrc,
        WB_rd_data,
        WB_data_out,
        WB_rd_addr,
	WB_funct3
    ); 
       
    //SRAM_wrapper DM1(~clk,chipselect,MEM_Memread,WEB,MEM_alu_out[15:2],MEM_di,MEM_data_out);         
 
        


    assign WB_wb_data=WB_Memtoreg?WB_data_out:WB_rd_data;

    assign MEM_data_in=forwardrdsrc?WB_wb_data:MEM_forward_rs2_data;

  
    HazardCtrl hz(b_ctrl,EX_Memread,rs1,rs2,EX_rs1_addr,EX_rs2_addr,EX_rd_addr,IFIDwrite,PCwrite,flush,flush2);
    ForwardUnit fwun(EX_rs1_addr,EX_rs2_addr,MEM_rd_addr,WB_rd_addr,MEM_Regwrite,MEM_Memwrite,WB_Regwrite,forwardrs1src,forwardrs2src,forwardrdsrc);
    

    MUX3to1 m4fw1(EX_rs1_data,MEM_rd_data,WB_wb_data,forwardrs1src,alusrca);
    MUX3to1 m4fw2(EX_rs2_data,MEM_rd_data,WB_wb_data,forwardrs2src,alusrcb);
    Regfile rf(clk,rst,rs1,rs2,WB_rd_addr,WB_Regwrite,WB_Memread,WB_Memwrite,WB_wb_data,WB_funct3,MEM_funct3,rs1data,rs2data);
    
//    assign out = WB_wb_data;

endmodule
