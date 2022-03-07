module HazardCtrl(b_ctrl,EX_MemRead,rs1_addr,rs2_addr,EX_rs1_addr,EX_rs2_addr,EX_rd_addr,IFIDWrite,PCWrite,flush,EX_flush);

input [1:0] b_ctrl;
input EX_MemRead;
input [4:0] rs1_addr,rs2_addr,EX_rs1_addr,EX_rs2_addr,EX_rd_addr;
output logic IFIDWrite,PCWrite,flush,EX_flush;


always@(*)begin
	if(b_ctrl != 2'b10)	begin
		IFIDWrite 	= 1;
		PCWrite 	= 1;
		flush		= 1;
		EX_flush	= 1;
	end
 
	/*else if((EX_MemRead)&&(((EX_rs2_addr)==(rs1_addr)) || ((EX_rs2_addr)==(rs2_addr)))) begin //stall the pipeline
		IFIDWrite	 = 0;
		PCWrite 	 = 0;
		flush		 = 1;
		EX_flush	  = 1;
	end // THIS IS FOR MPIS*/
	else if(EX_MemRead&&(EX_rd_addr == rs1_addr || EX_rd_addr == rs2_addr)) begin
		IFIDWrite 	 = 0;
		PCWrite 	 = 0;
		flush		 = 0;
		EX_flush	 = 1;
	end
  	else begin
		IFIDWrite	 = 1;
		PCWrite	  	 = 1;
		flush		 = 0;
		EX_flush	 = 0;
	end		
		
end
		



endmodule
