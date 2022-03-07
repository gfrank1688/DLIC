module ForwardUnit(EX_rs1_addr,EX_rs2_addr,MEM_rd_addr,WB_rd_addr,MEM_RegWrite,MEM_MemWrite,WB_RegWrite,Fwrs1Src,Fwrs2Src,FwRDSrc);
	input [4:0] EX_rs1_addr,EX_rs2_addr,MEM_rd_addr,WB_rd_addr;
	input WB_RegWrite;
	input MEM_RegWrite;
	input MEM_MemWrite;
	output logic [1:0] Fwrs1Src,Fwrs2Src;
	output logic FwRDSrc;
	
	
always@(*)begin//WB TO MEM  ex: 1.add  2.sw 
	if((WB_RegWrite && MEM_MemWrite)&&(WB_rd_addr == MEM_rd_addr)) FwRDSrc = 1'b1;
	else FwRDSrc = 1'b0;
end
always@(*)begin
	if(MEM_RegWrite&&(MEM_rd_addr != 5'b0)&&(MEM_rd_addr == EX_rs1_addr)) Fwrs1Src = 2'b01;
	else if(WB_RegWrite && (WB_rd_addr != 5'b0)&&(!(MEM_RegWrite && (MEM_rd_addr != 5'b0)&&(MEM_rd_addr == EX_rs1_addr)))&&(WB_rd_addr == EX_rs1_addr)) Fwrs1Src = 2'b10;
	else Fwrs1Src = 2'b00;
end
always@(*)begin
	if((MEM_RegWrite)&&(MEM_rd_addr != 5'b0)&&(MEM_rd_addr == EX_rs2_addr)) Fwrs2Src = 2'b01;
	else if(WB_RegWrite && (WB_rd_addr != 5'b0)&&(!(MEM_RegWrite && (MEM_rd_addr != 5'b0)&&(MEM_rd_addr == EX_rs2_addr)))&&(WB_rd_addr == EX_rs2_addr)) Fwrs2Src = 2'b10;
	else Fwrs2Src = 2'b00;
end

endmodule
	

