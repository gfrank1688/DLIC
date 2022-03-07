module ID_EX(clk,rst,flush,
	ID_pc,
	Branch,ALUop,RDSrc,ALUSrc,MemRead,MemWrite,MemtoReg,RegWrite,PCtoRegSrc,
	rs1_data,rs2_data,
	imm,
	fun3,fun7,
	rs1_addr,rs2_addr,rd_addr,
	EX_Branch,EX_ALUop,EX_RDSrc,EX_ALUSrc,EX_MemRead,EX_MemWrite,EX_MemtoReg,EX_RegWrite,EX_PCtoRegSrc,
	EX_rs1_data,EX_rs2_data,
	EX_pc,
	EX_imm,
	EX_fun3,EX_fun7,
	EX_rs1_addr,EX_rs2_addr,EX_rd_addr
	);

input clk,rst;
input flush;
input [31:0] ID_pc;
input [1:0] Branch;
input [2:0] ALUop;
input ALUSrc,RDSrc,MemRead,MemWrite,MemtoReg,RegWrite,PCtoRegSrc;
input [31:0] rs1_data,rs2_data;
input [31:0] imm;
input [2:0] fun3;
input [6:0] fun7;
input [4:0] rs1_addr,rs2_addr,rd_addr;
output logic EX_RDSrc,EX_ALUSrc,EX_MemRead,EX_MemWrite,EX_MemtoReg,EX_RegWrite,EX_PCtoRegSrc;
output logic [31:0] EX_rs1_data,EX_rs2_data;
output logic [31:0] EX_pc,EX_imm;
output logic [2:0] EX_fun3;
output logic [6:0] EX_fun7;
output logic [4:0] EX_rd_addr,EX_rs1_addr,EX_rs2_addr;
output logic [1:0] EX_Branch;
output logic [2:0] EX_ALUop;





always@(posedge clk or posedge rst)begin
	if(rst) begin
  	  EX_ALUSrc <= 1'b0;
	  EX_RDSrc <= 1'b0;
	  EX_PCtoRegSrc <= 1'b0;
	  EX_MemRead <= 1'b0;
	  EX_MemWrite <=1'b0;
	  EX_MemtoReg <= 1'b0;
	  EX_RegWrite <= 1'b0;
	  EX_ALUop <= 3'b000;
	  EX_Branch <= 2'b00;
	  EX_pc <= 32'b0;
	  EX_rs1_data <= 32'b0;
	  EX_rs2_data <= 32'b0;
	  EX_imm <= 32'b0;
	  EX_fun3 <= 3'd0;
	  EX_fun7 <= 7'd0;
	  EX_rd_addr <= 5'd0;
	  EX_rs1_addr <= 5'd0;
	  EX_rs2_addr <= 5'd0;
	end
	else begin
		if(flush)begin
          		EX_ALUSrc <= 1'b0;
          		EX_RDSrc <= 1'b0;
          		EX_PCtoRegSrc <= 1'b0;
          		EX_MemRead <= 1'b0;
          		EX_MemWrite <=1'b0;
          		EX_MemtoReg <= 1'b0;
          		EX_RegWrite <= 1'b0;
          		EX_ALUop <= 3'd0;
          		EX_Branch <= 2'd0;	
       		end
 		else begin
	  		EX_ALUSrc <= ALUSrc;
         		EX_RDSrc <= RDSrc;
         		EX_PCtoRegSrc <= PCtoRegSrc;
         		EX_MemRead <= MemRead;
         		EX_MemWrite <=MemWrite;
         		EX_MemtoReg <= MemtoReg;
         		EX_RegWrite <= RegWrite;
         		EX_ALUop <= ALUop;
         		EX_Branch <= Branch;
        
   	 	end
	 EX_pc  <= ID_pc;
	 EX_rs1_data <= rs1_data;
         EX_rs2_data <= rs2_data;
         EX_imm <= imm;
         EX_fun3 <= fun3;
         EX_fun7 <= fun7;
         EX_rd_addr <= rd_addr;
         EX_rs1_addr <= rs1_addr;
         EX_rs2_addr <= rs2_addr;
	end

      end

	
 
	
	

endmodule
