module ProgramCounter(
	input clk,
	input rst,
	input PCWrite,
	input [31:0] pc_in,
	output logic [31:0] pc_out
	);


always@(posedge clk or posedge rst)begin
if(rst) pc_out <= 0;
else 
  if(PCWrite)	pc_out <= pc_in;

end

endmodule
