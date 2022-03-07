module ALU(alusrc1,alusrc2,aluctrl,zeroflag,alu_out);
	input [31:0] alusrc1;
	input [31:0] alusrc2;
	input [4:0] aluctrl;
	output logic zeroflag;
	output logic [31:0] alu_out;

	
always@(*) begin
	case(aluctrl)
		5'b00000:begin
			
			//alu_out  = alusrc1 + (~alusrc2)  + 1;
			//else
			alu_out  = alusrc1 + alusrc2;//add
			zeroflag = 1'b0;
		
			end
		5'b00001:begin
			alu_out  = alusrc1 +(~alusrc2) + 32'b1;//sub
			//alu_out = alusrc1  - alusrc2;//sub
			zeroflag =1'b0;
 			end
		5'b00010:begin
			alu_out  = alusrc1 << alusrc2[4:0];//sll
			zeroflag = 1'b0;
			end
		5'b00011:begin
			alu_out  = ($signed(alusrc1) < $signed(alusrc2) )? 1:0;//slt
			zeroflag = 1'b0;
			end
		5'b00100:begin
			alu_out  = (alusrc1 < alusrc2) ? 1:0;//sltu
			zeroflag = 1'b0;
			end
		5'b00101:begin
			alu_out  = alusrc1 ^ alusrc2;//xor
			zeroflag = 1'b0;
			end
		5'b00110:begin
			alu_out  = alusrc1 >> alusrc2[4:0];//srl
			zeroflag = 1'b0;
			end
		5'b00111:begin
			alu_out  = $signed(alusrc1) >>> $signed(alusrc2[4:0]); //sra
			zeroflag = 1'b0;
			end
		5'b01000:begin
			alu_out  = alusrc1 | alusrc2;//or
			zeroflag = 1'b0;
			end
		5'b01001:begin
			alu_out  = alusrc1 & alusrc2;//and
			zeroflag = 1'b0;
			end
		5'b01010:begin
			if(alusrc1 == alusrc2)begin
			  zeroflag =1;  //beg
			  alu_out = 0;
			end
			else begin
				zeroflag = 0;
			  alu_out = 0;
			end
		end
		5'b01011:begin
			if(alusrc1 != alusrc2)begin
			  zeroflag =1;  //bne
			  alu_out = 0;
			end
			else begin
			  zeroflag = 0;
			  alu_out = 0;
			end
		end    
		5'b01100:begin
			if($signed(alusrc1) < $signed(alusrc2))begin
			   zeroflag =1;//blt
	 		   alu_out =0;
			end
			else begin
		           zeroflag = 0;
			   alu_out = 0;
			end
		end    
		5'b01101:begin
			if($signed(alusrc1) >= $signed(alusrc2))begin
			  zeroflag = 1;//bge
			  alu_out =0;
			end
			else begin
			  zeroflag = 0;
			  alu_out = 0;
			end
		end
		5'b01110:begin
			if(alusrc1 < alusrc2) begin
			   zeroflag = 1;//bltu
			   alu_out = 0;
			end
			else begin
			   zeroflag = 0;
			   alu_out = 0;
			end
		end
		5'b01111:begin
			if(alusrc1 >= alusrc2)begin
			   zeroflag = 1;//bgeu
			   alu_out = 0;
			end
			else begin 
			   zeroflag = 0;
			   alu_out = 0;
			end
		end
		
		5'b10000:begin
			alu_out  = alusrc2;//lui
			zeroflag =1'b0;
		end

		5'b10001:begin
			alu_out = (alusrc1 + alusrc2) & {28'hfffffff,4'b1110};//jalr
			zeroflag = 1'b0;
		end
	 	//5'b10010:alu_out = alusrc1 <<  alusrc2[4:0];
		default:begin
			alu_out = 32'b0;
			zeroflag = 1'b0;
		end			
		



	
	endcase
 	
end 
	

endmodule

	
