module BranchCtrl(
	input [1:0] Branch,
	input zeroflag,
	output reg [1:0] b_ctrl
	);
	
always@(*)begin
	case(Branch)
		2'b00:b_ctrl = 2'b10;
		2'b01:begin
			if(zeroflag == 1'b1) b_ctrl = 2'b01;//b
			else b_ctrl = 2'b10;
		      end
		2'b10:b_ctrl = 2'b00;//jalr
		2'b11:b_ctrl = 2'b01;//j
		
	endcase

	
end
endmodule
