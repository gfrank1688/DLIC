module ImmG(ImmType,instr,imm);
	input [2:0] ImmType;
	input [31:0] instr;
	output logic [31:0] imm;


always@(*)begin
	case(ImmType)
            3'b000:begin //I-type
                imm={{20{instr[31]}},instr[31:20]};
            end
            3'b001:begin //S-type
                imm={{20{instr[31]}},instr[31:25],instr[11:7]};
            end
            3'b010:begin //B-type
                imm={{19{instr[31]}},instr[31],instr[7],instr[30:25],instr[11:8],1'b0};
            end
            3'b011:begin //U-type
                imm={instr[31:12],12'b0};
            end
            3'b100:begin //J-type
                imm={{12{instr[31]}},instr[19:12],instr[20],instr[30:21],1'b0};
            end
	    default: imm = {{20{instr[31]}},instr[31:20]};
        endcase	
/*
	case(ImmType)
		3'b000: imm = {instr[31:12],12'h0};
		3'b001: imm = {{20{instr[31]}},instr[31:20]};//I-TYPE
		3'b010: imm = {{20{instr[31]}},instr[31:25],instr[11:7]};//S-TYPE
		3'b011: imm = {{19{instr[31]}},instr[31],instr[7],instr[30:25],instr[11:8],1'b0};//B-TYPE
                //3'b011: imm = instr[31]==1?{19'b1111111111111111111,instr[31],instr[7],instr[30:25],instr[11:8],1'b0}:{19'b0000000000000000000,instr[31],instr[7],instr[30:25],instr[11:8],1'b0};
		3'b100: imm = {instr[31:12],12'b0} ;//U-TYPE		
		3'b101: imm = {{12{instr[31]}},instr[19:12],instr[20],instr[30:21],1'b0};//J-TYPE
		//3'b101: imm = instr[31]==1?{11'b11111111111,instr[31],instr[19:12],instr[20],instr[30:21],1'b0}:{11'b00000000000,instr[31],instr[19:12],instr[20],instr[30:21],1'b0};

	endcase*/
end
endmodule
