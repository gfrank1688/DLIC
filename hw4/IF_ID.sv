module IF_ID(clk,rst,flush,IFIDWrite,pc_out,instr,ID_pc,ID_instr);

	input clk,rst,flush;
	input IFIDWrite;
	input [31:0] pc_out,instr;
	output logic [31:0] ID_instr;
	output logic [31:0] ID_pc;
	always@(posedge clk or posedge rst)begin
		if(rst) begin
			ID_pc    <= 0;
			ID_instr <= 0;
		end
		else if(flush)begin
			ID_pc    <= 0;
			ID_instr <= 0;
		end	
		else if(IFIDWrite == 1'b1) begin
				ID_pc    <= pc_out;
				ID_instr <= instr;
			end
		

	end
endmodule 


