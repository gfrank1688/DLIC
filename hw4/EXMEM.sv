module EXMEM(
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
    input clk,rst;
    input EX_Memread,EX_Memwrite,EX_Memtoreg,EX_Regwrite,EX_PCtoregsrc,EX_RDsrc;
    input [31:0] pc_to_reg;
    input [31:0] EX_alu_out;
    input [31:0] EX_forward_rs2_data;
    input [4:0] EX_rd_addr;
    input [2:0] EX_funct3;
    output logic MEM_Memread,MEM_Memwrite,MEM_Memtoreg,MEM_Regwrite,MEM_PCtoregsrc,MEM_RDsrc;
    output logic [31:0] MEM_pc_to_reg;
    output logic [31:0] MEM_alu_out;
    output logic [31:0] MEM_forward_rs2_data;
    output logic [4:0] MEM_rd_addr;
    output logic [2:0] MEM_funct3;
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            MEM_Memread=0;
            MEM_Memwrite=0;
            MEM_Memtoreg=0;
            MEM_Regwrite=0;
            MEM_PCtoregsrc=0;
            MEM_RDsrc=0;
            MEM_pc_to_reg=0;
            MEM_alu_out=0;
            MEM_forward_rs2_data=0;
            MEM_rd_addr=0;
	    MEM_funct3 =0;
        end
        else begin
            MEM_Memread=EX_Memread;
            MEM_Memwrite=EX_Memwrite;
            MEM_Memtoreg=EX_Memtoreg;
            MEM_Regwrite=EX_Regwrite;
            MEM_PCtoregsrc=EX_PCtoregsrc;
            MEM_RDsrc=EX_RDsrc;
            MEM_pc_to_reg=pc_to_reg;
            MEM_alu_out=EX_alu_out;
            MEM_forward_rs2_data=EX_forward_rs2_data;
            MEM_rd_addr=EX_rd_addr;
	    MEM_funct3 = EX_funct3;
        end
    end
endmodule