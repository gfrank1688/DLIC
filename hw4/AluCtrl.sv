module AluCtrl(
	input [2:0] fun3,
	input [6:0] fun7,
	input [2:0] ALUop,
	output reg [4:0] aluctrl
	);


always@(*)begin

	case(ALUop)
		3'b000:begin//R-TYPE
			case(fun3)
			3'b000:begin	if(fun7 == 7'b0000000) aluctrl = 5'b00000;//add
				else aluctrl = 5'b00001;//sub
			       end
			3'b001:aluctrl = 5'b00010;//sll
			3'b010:aluctrl = 5'b00011;//slt
			3'b011:aluctrl = 5'b00100;//sltu
			3'b100:aluctrl = 5'b00101;//xor
			3'b101:begin
				  if(fun7 == 7'b0000000) aluctrl = 5'b00110;//srl
				  else aluctrl = 5'b00111;//sra
				end
			3'b110:aluctrl = 5'b01000;//or
			3'b111:aluctrl = 5'b01001;//and
			endcase
		end
		3'b001:aluctrl =5'b00000;//lw & sw
		3'b010:begin
			case(fun3)
			3'b000:aluctrl = 5'b00000;//addi	 
			3'b010:aluctrl = 5'b00011;//stli
			3'b011:aluctrl = 5'b00100;//sltiu
			3'b100:aluctrl = 5'b00101;//xori
			3'b110:aluctrl = 5'b01000;//ori
			3'b111:aluctrl = 5'b01001;//andi
			3'b101:begin
				if(fun7==7'b0000000) aluctrl = 5'b00110;//srli
				else aluctrl = 5'b00111;//srai
			       end
			3'b001:aluctrl = 5'b00010;//slli
			endcase
		end
		3'b011: aluctrl =5'b10001;//jalr
		3'b100:begin
			case(fun3)
			3'b000:aluctrl =5'b01010;//beg
			3'b001:aluctrl =5'b01011;//bne
			3'b100:aluctrl =5'b01100;//blt
			3'b101:aluctrl =5'b01101;//bge
			3'b110:aluctrl =5'b01110;//bltu
			3'b111:aluctrl =5'b01111;//bgeu
			default:aluctrl =5'b01010;
			endcase
		end
		3'b101:aluctrl = 5'b10000;//lui
		3'b110:aluctrl = 5'b10000;//jal
		default:aluctrl = 5'b00000;
	
		
	endcase		
end

endmodule				
