module Regfile(
	input clk,
	input rst,
	input [4:0] rs1_addr,
	input [4:0] rs2_addr,
	input [4:0] rd_addr,
	input WB_RegWrite,
	input WB_MemRead,
	input MemWrite,
	input [31:0] rd_data,
	input [2:0] EX_funct3,
	input [2:0] funct3,
	output logic [31:0] rs1_data,
	output logic [31:0] rs2_data
	
	);

reg [31:0] Rf [0:31];
integer i;
 
always@(*)begin

rs2_data = (rs2_addr == 5'b00000) ? 32'h00000000 : Rf[rs2_addr];
//if(MemWrite)begin
//	case(funct3)
//		3'b010: rs2_data = (rs2_addr == 5'b00000) ? 32'h00000000 : Rf[rs2_addr];//sw
//		3'b000: rs2_data = (rs2_addr == 5'b00000) ? 32'h00000000 : {24'b0,Rf[rs2_addr][7:0]};
//		3'b001: rs2_data = (rs2_addr == 5'b00000) ? 32'h00000000 : {16'b0,Rf[rs2_addr][15:0]};
//	endcase
//end

end


always@(negedge clk or posedge rst)begin
		if(rst)begin
			for(i =0;i<32;i = i + 1)
		 		 Rf[i] <= 32'h0;
		end	
		else if(WB_MemRead && WB_RegWrite)begin
		   case(EX_funct3)
			3'b010: Rf[rd_addr] <= rd_data;
		 	3'b101: Rf[rd_addr] <= {16'b0,rd_data[15:0]};//lhu
			3'b001: Rf[rd_addr] <= {{16{rd_data[15]}},rd_data[15:0]};//lh
			3'b100: Rf[rd_addr] <= {24'b0,rd_data[7:0]};//lbu
			3'b000: Rf[rd_addr] <= {{24{rd_data[7]}},rd_data[7:0]};//lb
		   endcase
		end
	  	else if(WB_RegWrite)begin
			Rf[rd_addr] <= rd_data;
		end
	
		
end
/*always@(negedge clk)begin
		if(WB_RegWrite&&WB_MemRead)begin
			Rf[rd_addr] <= rd_data;
		end
end*/


assign rs1_data = (rs1_addr == 5'b00000) ? 32'h00000000 : Rf[rs1_addr];

//assign rs2_data = (rs2_addr == 5'b00000) ? 32'h00000000 : Rf[rs2_addr];


endmodule
