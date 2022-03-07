module MUX3to1(
	input [31:0] in1,
	input [31:0] in2,
	input [31:0] in3,
	input [1:0] select,
	output logic [31:0] out
	);

assign out = select == (2'b00)? in1:(select ==(2'b01)? in2:in3);

endmodule
