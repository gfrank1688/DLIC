module Decoder(opcode,ImmType,Branch,ALUop,ALUSrc,RDSrc,PCtoRegSrc,RegWrite,MemRead,MemWrite,MemtoReg);
	input [6:0] opcode;
	output logic [1:0] Branch;
	output logic [2:0] ImmType;
	output logic [2:0] ALUop;
	output logic ALUSrc,RDSrc,PCtoRegSrc,RegWrite,MemRead,MemWrite,MemtoReg;


always@(*)begin
	case(opcode)
		7'b0110011:begin//Rtype
			ImmType		= 3'b000;//dont care
		        Branch          = 2'b00;
			ALUop  		= 3'b000;
			ALUSrc 		= 1'b0;
			RDSrc		= 1'b1;
			PCtoRegSrc	= 1'b0;//dont care
			RegWrite 	= 1'b1;
			MemRead		= 1'b0;
			MemWrite	= 1'b0;
			MemtoReg	= 1'b0;
			
		end
		7'b0000011:begin//lw
			ImmType         = 3'b000;
                        Branch          = 2'b00;
                        ALUop           = 3'b001;//ALU DO ADD
                        ALUSrc          = 1'b1;
                        RDSrc           = 1'b1;
                        PCtoRegSrc      = 1'b0;//dont care
                        RegWrite        = 1'b1;
                        MemRead         = 1'b1;
                        MemWrite        = 1'b0;
                        MemtoReg        = 1'b1;
		end
		7'b0010011:begin//I-TYPE
			ImmType         = 3'b000;
                        Branch          = 2'b00;
                        ALUop           = 3'b010;
                        ALUSrc          = 1'b1;
                        RDSrc           = 1'b1;
                        PCtoRegSrc      = 1'b0;//dont care
                        RegWrite        = 1'b1;
                        MemRead         = 1'b0;
                        MemWrite        = 1'b0;
                        MemtoReg        = 1'b0;
		end
		7'b1100111:begin//I-TYPE JALR
			ImmType         = 3'b000;
                        Branch          = 2'b10;
                        ALUop           = 3'b011;
                        ALUSrc          = 1'b1;
                        RDSrc           = 1'b0;
                        PCtoRegSrc      = 1'b1;
                        RegWrite        = 1'b1;
                        MemRead         = 1'b0;
                        MemWrite        = 1'b0;
                        MemtoReg        = 1'b0;
		end
		7'b0100011:begin//S-TYPE
			ImmType         = 3'b001;
                        Branch          = 2'b00;
                        ALUop           = 3'b001;
                        ALUSrc          = 1'b1;
                        RDSrc           = 1'b1;
                        PCtoRegSrc      = 1'b0;
                        RegWrite        = 1'b0;
                        MemRead         = 1'b0;
                        MemWrite        = 1'b1;
                        MemtoReg        = 1'b0;
		end
		7'b1100011:begin//B-TYPE
			ImmType         = 3'b010;
                        Branch          = 2'b01;
                        ALUop           = 3'b100;
                        ALUSrc          = 1'b0;
                        RDSrc           = 1'b1;
                        PCtoRegSrc      = 1'b0;
                        RegWrite        = 1'b0;
                        MemRead         = 1'b0;
                        MemWrite        = 1'b0;
                        MemtoReg        = 1'b0;
		end
		7'b0010111:begin//U-TYPE AUIPC
			ImmType         = 3'b011;
                        Branch          = 2'b00;
                        ALUop           = 3'b001;
                        ALUSrc          = 1'b1;//dc
                        RDSrc           = 1'b0;
                        PCtoRegSrc      = 1'b0;
                        RegWrite        = 1'b1;
                        MemRead         = 1'b0;
                        MemWrite        = 1'b0;
                        MemtoReg        = 1'b0;
		end
		7'b0110111:begin//U-TYPE LUI
			ImmType         = 3'b011;
                        Branch          = 2'b00;
                        ALUop           = 3'b101;
                        ALUSrc          = 1'b1;
                        RDSrc           = 1'b1;
                        PCtoRegSrc      = 1'b0;
                        RegWrite        = 1'b1;
                        MemRead         = 1'b0;
                        MemWrite        = 1'b0;
                        MemtoReg        = 1'b0;
		end
		7'b1101111:begin//J-TYPE
			ImmType         = 3'b100;
                        Branch          = 2'b11;
                        ALUop           = 3'b110;
                        ALUSrc          = 1'b1;//dc
                        RDSrc           = 1'b0;
                        PCtoRegSrc      = 1'b1;
                        RegWrite        = 1'b1;
                        MemRead         = 1'b0;
                        MemWrite        = 1'b0;
                        MemtoReg        = 1'b0;
		end
		default:begin
			ImmType         = 3'b000;
                        Branch          = 2'b00;
                        ALUop           = 3'b000;
                        ALUSrc          = 1'b0;//dc
                        RDSrc           = 1'b0;
                        PCtoRegSrc      = 1'b0;
                        RegWrite        = 1'b0;
                        MemRead         = 1'b0;
                        MemWrite        = 1'b0;
                        MemtoReg        = 1'b0;
		end
	endcase
end
endmodule	
