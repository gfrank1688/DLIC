module traffic_light (
  input  clk,
  input  rst,
  input  pass,
  output reg R,
  output reg G,
  output reg Y
);

reg [12:0] cnt;

parameter [2:0] S0 =3'b000,
                S1 =3'b001,
                S2 =3'b010,
                S3 =3'b011,
                S4 =3'b100,
                S5 =3'b101,
                S6 =3'b110;

reg [2:0] current,next;
always@(posedge clk or posedge rst)begin
  if(rst ) begin
     current <= S0;
     cnt <= 13'b0;
  end
  else if((pass && (current != S0 ))|| cnt == 13'd3071)begin
    current <= S0;
    cnt <= 13'b0;
  end
  else begin
      current <= next;
      cnt <= cnt + 13'b1;
  end 

end

always@(*)begin
  case(current)
    S0:begin
      if(cnt == 13'd1023) next  = S1;
      else  next = S0;
    end
    S1:begin
      if(cnt == 13'd1151) next  = S2;
      else next = S1;
    end
    S2:begin
      if(cnt == 13'd1279) next  = S3;
      else  next = S2;
    end
    S3:begin
      if(cnt == 13'd1407) next  = S4;
      else  next = S3;
    end
    S4:begin
      if(cnt == 13'd1535) next  = S5;
      else  next = S4;
    end
    S5:begin
      if(cnt == 13'd2047) next  = S6;
      else  next = S5;
    end
    S6:begin
      if(cnt == 13'd3071) next  = S0;
      else  next = S6;
    end
    default:begin
      next = S1;
    end
  endcase
end
always@(*)begin
  case(current)
    S0:begin
      R=1'b0;
      G=1'b1;
      Y=1'b0;
    end
    S1:begin
      R=1'b0;
      G=1'b0;
      Y=1'b0;
    end
    S2:begin
      R=1'b0;
      G=1'b1;
      Y=1'b0;
    end
    S3:begin
      R=1'b0;
      G=1'b0;
      Y=1'b0;
    end
    S4:begin
      R=1'b0;
      G=1'b1;
      Y=1'b0;
    end
    S5:begin
      R=1'b0;
      G=1'b0;
      Y=1'b1;
    end
    S6:begin
      R=1'b1;
      G=1'b0;
      Y=1'b0;
    end
    default:begin
      R=1'b0;
      G=1'b0;
      Y=1'b0;
    end
  endcase
end
endmodule